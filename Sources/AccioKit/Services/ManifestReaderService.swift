import Foundation
import SwiftShell
import SwiftSyntax

enum ManifestReaderError: Error {
    case noPackageManifestFound
    case couldntParseManifest
    case manifestIncomplete
}

final class ManifestReaderService: SyntaxVisitor {
    static let shared = ManifestReaderService(workingDirectory: FileManager.default.currentDirectoryPath)

    private let workingDirectory: String
    private var manifest: Manifest?

    init(workingDirectory: String) {
        self.workingDirectory = workingDirectory
    }

    /// NOTE: Dependencies must already be resolved for this to work. Use DependencyResolverService to do so.
    func readManifest() throws -> Manifest {
        let packageManifestUrl = URL(fileURLWithPath: workingDirectory).appendingPathComponent("Package.swift")

        guard FileManager.default.fileExists(atPath: packageManifestUrl.path) else {
            throw ManifestReaderError.noPackageManifestFound
        }

        let sourceFile: SourceFileSyntax = try SyntaxTreeParser.parse(packageManifestUrl)
        manifest = nil

        print("Reading package manifest ...", level: .info)
        visit(sourceFile)

        guard let manifest = manifest else {
            throw ManifestReaderError.manifestIncomplete
        }

        print("Found \(manifest.frameworksPerTargetName.count) targets in package manifest.", level: .info)
        return manifest
    }

    override func visit(_ initializerClause: InitializerClauseSyntax) {
        super.visit(initializerClause)

        // NOTE: To understand the following code bettter, open https://swift-ast-explorer.kishikawakatsumi.com/ and copy the manifestResource contents
        //       from the ManifestReaderServiceTests file. Otherwise following the code is probably difficult.

        // initializerClause looks like this: '= Package(name: ..., products: ..., dependencies: ..., targets: ...)'
        guard let functionCallArgumentsList = initializerClause.child(at: 1)?.child(at: 2) as? FunctionCallArgumentListSyntax else { return }

        // functionCallArgumentList looks like this: 'name: ..., products: ..., dependencies: ..., targets: ...'
        let functionCallArguments = functionCallArgumentsList.children.compactMap { $0 as? FunctionCallArgumentSyntax }

        // functionCallArguments looks like this: ['name: ...', 'products: ...', 'dependencies: ...', 'targets: ...']
        guard let nameArgument          = functionCallArguments.first(where: { $0.label?.text == "name" })          else { return }
        guard let dependenciesArgument  = functionCallArguments.first(where: { $0.label?.text == "dependencies" })  else { return }
        guard let targetsArgument       = functionCallArguments.first(where: { $0.label?.text == "targets" })       else { return }

        guard let projectName                   = (nameArgument.expression as? StringLiteralExprSyntax)?.text       else { return }
        guard let dependenciesArrayElementList  = (dependenciesArgument.expression as? ArrayExprSyntax)?.elements   else { return }
        guard let targetsArrayElementList       = (targetsArgument.expression as? ArrayExprSyntax)?.elements        else { return }

        // dependenciesArrayElementList looks like this: '.package(url: ..., ...), .package(url: ..., ...), .package(url: ..., ...)'
        let dependenciesUrls = dependenciesArrayElementList.compactMap { (($0.child(at: 0)?.child(at: 2)?.child(at: 0) as? FunctionCallArgumentSyntax)?.expression as? StringLiteralExprSyntax)?.text }

        // targetsArrayElementList looks like this: '.target(name: ..., dependencies: [...]), .testTarget(name: ..., dependencies: [...])'
        let targetFunctionCalls = targetsArrayElementList.compactMap { $0.child(at: 0) as? FunctionCallExprSyntax }.filter { $0.calledExpression.description.hasSuffix(".target") }
        let targetsDependenciesTuples: [(String, [String])] = targetFunctionCalls.compactMap { targetFunctionCall in
            guard let targetNameArgument = targetFunctionCall.argumentList.first(where: { $0.label?.text == "name" }) else { return nil }
            guard let targetName = (targetNameArgument.expression as? StringLiteralExprSyntax)?.text else { return nil }

            guard let dependenciesArgument = targetFunctionCall.argumentList.first(where: { $0.label?.text == "dependencies" }) else { return nil }
            guard let dependenciesArrayElementList = (dependenciesArgument.expression as? ArrayExprSyntax)?.elements else { return nil }
            let dependencies = dependenciesArrayElementList.compactMap({ ($0.expression as? StringLiteralExprSyntax)?.text })

            return (targetName, dependencies)
        }

        let checkoutsDirPath = "\(workingDirectory)/\(Constants.buildPath)/checkouts"
        let checkoutDirNames = try! FileManager.default.contentsOfDirectory(atPath: checkoutsDirPath)

        var frameworksPerTargetName: [String: [Framework]] = [:]

        for (targetName, dependencies) in targetsDependenciesTuples {
            frameworksPerTargetName[targetName] = dependencies.map { dependency in
                let dependencyDirectoryNamePrefix = dependenciesUrls.first { $0.contains(dependency) }!.components(separatedBy: "/").last!
                let directoryName = checkoutDirNames.first { $0.hasPrefix(dependencyDirectoryNamePrefix) }!

                let checkoutProjectDir = "\(checkoutsDirPath)/\(directoryName)"
                let commitHash = run(bash: "git --git-dir \(checkoutProjectDir)/.git rev-parse HEAD").stdout

                return Framework(
                    commit: commitHash,
                    directory: checkoutProjectDir,
                    xcodeProjectPath: "\(checkoutProjectDir)/\(dependency).xcodeproj",
                    scheme: dependency
                )
            }
        }

        manifest = Manifest(projectName: projectName, frameworksPerTargetName: frameworksPerTargetName)
    }
}

extension StringLiteralExprSyntax {
    var text: String {
        let description: String = self.description.trimmingCharacters(in: .whitespacesAndNewlines)
        guard description.count > 2 else { return "" }

        let textRange = description.index(description.startIndex, offsetBy: 1) ..< description.index(description.endIndex, offsetBy: -1)
        return String(description[textRange])
    }
}
