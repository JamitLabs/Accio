import Foundation
import SwiftShell

enum FrameworkError: Error {
    case noSharedSchemes
}

struct Framework {
    let projectName: String
    let libraryName: String
    let projectDirectory: String
    let additionalConfiguration: AdditionalConfiguration
    let requiredFrameworks: [Framework]

    var commitHash: String {
        if TestHelper.shared.isStartedByUnitTests && projectDirectory.isEmpty {
            return "PSEUDO_HASH_\(libraryName)"
        }

        return run(bash: "git -C '\(projectDirectory)' rev-parse HEAD").stdout
    }

    var generatedXcodeProjectPath: String {
        return URL(fileURLWithPath: projectDirectory).appendingPathComponent("\(projectName).xcodeproj").path
    }

    func xcodeProjectPaths(in directory: String) throws -> [String] {
        let directoryUrl: URL = URL(fileURLWithPath: directory)
        let visibleContentNames: [String] = try FileManager.default.contentsOfDirectory(atPath: directoryUrl.path).filter { !$0.hasPrefix(".") }
        let visibleContentPaths: [String] = visibleContentNames.map { directoryUrl.appendingPathComponent($0).path }

        let directoryPaths: [String] = try visibleContentPaths.filter { try FileManager.default.isDirectory(atPath: $0) && !pathIsProjectFile($0) }
        let projectFilePaths: [String] = visibleContentPaths.filter { pathIsProjectFile($0) && !$0.isAliasFile }

        let projectFilePathsInDirectories: [String] = try directoryPaths.reduce([]) { $0 + (try xcodeProjectPaths(in: $1)) }
        let xcodeProjectFilePaths: [String] = projectFilePaths + projectFilePathsInDirectories
        return xcodeProjectFilePaths.filter { !$0.hasSuffix(".playground/playground.xcworkspace") }
    }

    func sharedSchemePaths() throws -> [String] {
        return try xcodeProjectPaths(in: projectDirectory).reduce([]) { result, xcodeProjectPath in
            let schemesDirUrl: URL = URL(fileURLWithPath: xcodeProjectPath).appendingPathComponent("xcshareddata/xcschemes")
            guard FileManager.default.fileExists(atPath: schemesDirUrl.path) else { return result }

            let sharedSchemeFileNames: [String] = try FileManager.default.contentsOfDirectory(atPath: schemesDirUrl.path).filter { $0.hasSuffix(".xcscheme") }
            return result + sharedSchemeFileNames.map { schemesDirUrl.appendingPathComponent($0).path }
        }
    }

    func librarySchemePaths(in schemePaths: [String], framework: Framework) -> [String] {
        let nonLibrarySchemeSubstrings: [String] = ["Example", "Demo", "Sample", "Tests"]
        return schemePaths.filter { schemePath in
            let relativeSchemePath = schemePath.replacingOccurrences(of: framework.projectDirectory, with: "")
            return !nonLibrarySchemeSubstrings.contains { relativeSchemePath.contains($0) }
        }
    }

    private func pathIsProjectFile(_ path: String) -> Bool {
        return path.hasSuffix(".xcodeproj") || path.hasSuffix(".xcworkspace")
    }
}

/// The type of the product to be generated for a dependency
enum ProductType: String, CaseIterable {
    /// The default one: generate the product as the author of the dependency has configured it
    case `default`
    /// Generate a static framework
    case staticFramework = "static-framework"
    /// Generate a dynamic framework
    case dynamicFramework = "dynamic-framework"
}

/// The type of integration to be used when adding the dependencies to the Xcode project
enum IntegrationType: String, CaseIterable {
    /// The default one: adding the dependencies to the Xcode project
    case `default`
    /// Adding the dependencies to a cocoapods setup
    case cocoapods
}

/// Additional configuration for the frameworks
struct AdditionalConfiguration {
    var productType: ProductType
    var integrationType: IntegrationType

    static let `default` = AdditionalConfiguration(productType: .default, integrationType: .default)
}

