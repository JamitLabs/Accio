import Foundation
import PathKit
import xcodeproj

enum XcodeProjectIntegrationError: Error {
    case targetNotFound
    case frameworksBuildPhaseNotFound
}

final class XcodeProjectIntegrationService {
    static let shared = XcodeProjectIntegrationService(workingDirectory: FileManager.default.currentDirectoryPath)

    private let workingDirectory: String

    init(workingDirectory: String) {
        self.workingDirectory = workingDirectory
    }

    func updateDependencies(of target: Target, in projectName: String, with frameworkProducts: [FrameworkProduct]) throws {
        print("Linking build products with targets in Xcode project ...", level: .info)

        let dependenciesPlatformPath = "\(workingDirectory)/\(Constants.dependenciesPath)/\(target.platform.rawValue)"
        let copiedFrameworkProducts: [FrameworkProduct] = try copyFrameworkProducts(frameworkProducts, to: dependenciesPlatformPath)
        try linkFrameworks(copiedFrameworkProducts, with: target, in: projectName)
    }

    private func copyFrameworkProducts(_ frameworkProducts: [FrameworkProduct], to targetPath: String) throws -> [FrameworkProduct] {
        try bash("mkdir -p \(targetPath)")
        var copiedFrameworkProducts: [FrameworkProduct] = []

        for frameworkProduct in frameworkProducts {
            let frameworkDirPath = "\(targetPath)/\(frameworkProduct.frameworkDirUrl.lastPathComponent)"
            let symbolsFilePath = "\(targetPath)/\(frameworkProduct.symbolsFileUrl.lastPathComponent)"

            try bash("cp -R \(frameworkProduct.frameworkDirPath) \(frameworkDirPath)")
            try bash("cp -R \(frameworkProduct.symbolsFilePath) \(symbolsFilePath)")

            copiedFrameworkProducts.append(FrameworkProduct(frameworkDirPath: frameworkDirPath, symbolsFilePath: symbolsFilePath))
        }

        return copiedFrameworkProducts
    }

    private func linkFrameworks(_ frameworkProducts: [FrameworkProduct], with target: Target, in projectName: String) throws {
        let xcodeProjectPath = "\(workingDirectory)/\(projectName).xcodeproj"
        let projectFile = try XcodeProj(path: Path(xcodeProjectPath))
        let pbxproj = projectFile.pbxproj

        guard let targetObject = pbxproj.targets(named: target.name).first else {
            print("Could not find any target named '\(target.name)' at Xcode project path '\(xcodeProjectPath)'.", level: .error)
            throw XcodeProjectIntegrationError.targetNotFound
        }

        guard let frameworksBuildPhase = targetObject.buildPhases.first(where: { $0.buildPhase == .frameworks }) as? PBXFrameworksBuildPhase else {
            print("Could not find frameworks build phase for target '\(target.name)' at Xcode project path '\(xcodeProjectPath)'.", level: .error)
            throw XcodeProjectIntegrationError.frameworksBuildPhaseNotFound
        }

        let rootGroup = try pbxproj.rootGroup()!
        let dependenciesGroup = try rootGroup.group(named: Constants.xcodeDependenciesGroup) ?? rootGroup.addGroup(named: Constants.xcodeDependenciesGroup, options: .withoutFolder)[0]
        let platformGroup = try dependenciesGroup.group(named: target.platform.rawValue) ?? dependenciesGroup.addGroup(named: target.platform.rawValue, options: .withoutFolder)[0]

        let frameworksToAdd = frameworkProducts.filter { product in !platformGroup.children.compactMap { $0.path }.contains { $0.hasSuffix(product.frameworkDirUrl.lastPathComponent) } }
        let frameworkNames = frameworksToAdd.map { $0.frameworkDirUrl.lastPathComponent.components(separatedBy: ".").first! }
        let platformGroupName = "\(Constants.xcodeDependenciesGroup)/\(platformGroup.name!)"
        print("Adding frameworks \(frameworkNames) to group '\(platformGroupName)' in project navigator & linking with target '\(target.name)'.", level: .info)

        for frameworkToAdd in frameworksToAdd {
            let frameworkFileRef = try platformGroup.addFile(at: Path(frameworkToAdd.frameworkDirPath), sourceRoot: Path(workingDirectory))
            _ = try frameworksBuildPhase.add(file: frameworkFileRef)
        }

        let filesToRemove = platformGroup.children.filter { fileRef in !frameworkProducts.contains { $0.frameworkDirPath.hasSuffix(fileRef.name!) } }
        let fileNames = filesToRemove.map { $0.name! }
        print("Removing references \(fileNames) from group '\(platformGroupName)' and unlinking from target '\(target.name)'.", level: .info)

        for fileToRemove in filesToRemove {
            platformGroup.children.removeAll { $0 === fileToRemove }
        }

        var copyBuildScript: PBXShellScriptBuildPhase! = targetObject.buildPhases.first { $0.type() == .runScript && ($0 as! PBXShellScriptBuildPhase).name == Constants.copyBuildScript } as? PBXShellScriptBuildPhase
        if copyBuildScript == nil {
            print("Creating new copy build script phase '\(Constants.copyBuildScript)' for target '\(target.name)'...", level: .info)
            copyBuildScript = PBXShellScriptBuildPhase(name: Constants.copyBuildScript, shellScript: "/usr/local/bin/carthage copy-frameworks")
            targetObject.buildPhases.append(copyBuildScript)
        }

        pbxproj.add(object: copyBuildScript)
        print("Updating input paths in copy build script phase '\(Constants.copyBuildScript)' for target '\(target.name)'.", level: .info)
        copyBuildScript.inputPaths = platformGroup.children.map { "$(SRCROOT)/\($0.path!)" }

        try projectFile.write(path: Path(xcodeProjectPath), override: true)
    }
}
