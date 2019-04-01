import Foundation
import PathKit
import xcodeproj

enum XcodeProjectIntegrationError: Error {
    case targetNotFound
    case frameworksBuildPhaseNotFound
}

final class XcodeProjectIntegrationService {
    static let shared = XcodeProjectIntegrationService(workingDirectory: GlobalOptions.workingDirectory.value ?? FileManager.default.currentDirectoryPath)

    private let workingDirectory: String

    init(workingDirectory: String) {
        self.workingDirectory = workingDirectory
    }

    func handleRemovedTargets(keepingTargets targetsToKeep: [AppTarget]) throws {
        guard let projectName = targetsToKeep.first?.projectName else { return }

        // find groups of which the associated target is no longer listed in the Package.swift
        let xcodeProjectPath = "\(workingDirectory)/\(projectName).xcodeproj"
        let projectFile = try XcodeProj(path: Path(xcodeProjectPath))
        let pbxproj = projectFile.pbxproj
        let rootGroup = try pbxproj.rootGroup()!
        let dependenciesGroup = try rootGroup.group(named: Constants.xcodeDependenciesGroup) ?? rootGroup.addGroup(named: Constants.xcodeDependenciesGroup, options: .withoutFolder)[0]

        let targetNames = targetsToKeep.map { $0.targetName }
        let groupsToRemove = dependenciesGroup.children.filter { !targetNames.contains($0.name ?? "") }.compactMap { $0 as? PBXGroup }

        // sort dependencies group alphabetically
        dependenciesGroup.children.sort { ($0.name ?? "") < ($1.name ?? "") }

        for groupToRemove in groupsToRemove {
            guard !groupToRemove.children.isEmpty, let groupName = groupToRemove.name else { continue }

            let target = pbxproj.targets(named: groupName).first

            // remove references to frameworks in removed groups and unlink them
            let frameworkBuildPhase = target?.buildPhases.first { $0.buildPhase == .frameworks } as? PBXFrameworksBuildPhase

            let printSuffix = frameworkBuildPhase == nil ? "..." : "& unlinking from target '\(groupName)' ..."
            print("Removing frameworks \(groupToRemove.children.compactMap { $0.name }) from project navigator group '\(Constants.xcodeDependenciesGroup)/\(groupName)' \(printSuffix)", level: .info)

            frameworkBuildPhase?.files?.removeAll { file in groupToRemove.children.contains { $0 == file  } }
            groupToRemove.children.removeAll()
            pbxproj.delete(object: groupToRemove)
            pbxproj.deleteAllTemporaryFileReferences()

            // clean up potential copy frameworks phase
            if let target = target, let copyFrameworksPhase = (target.buildPhases.first {
                $0.type() == .copyFiles &&
                    ($0 as! PBXCopyFilesBuildPhase).name == Constants.copyFilesPhase &&
                    ($0 as! PBXCopyFilesBuildPhase).dstSubfolderSpec == .frameworks
            }) as? PBXCopyFilesBuildPhase {
                print("Cleaning up frameworks in copy frameworks phase '\(Constants.copyFilesPhase)' for target '\(target.name)' ...", level: .info)
                copyFrameworksPhase.files = []
            }

            // clean up potential copy build script
            if let target = target, let copyBuildScript = (target.buildPhases.first {
                $0.type() == .runScript &&
                    ($0 as! PBXShellScriptBuildPhase).name == Constants.copyBuildScript
            }) as? PBXShellScriptBuildPhase {
                print("Cleaning up input paths in copy build script phase '\(Constants.copyBuildScript)' for target '\(target.name)' ...", level: .info)
                copyBuildScript.inputPaths = []
            }
        }

        if !groupsToRemove.isEmpty {
            // remove references to groups themselves
            print("Removing empty groups \(groupsToRemove.compactMap { $0.name }) from project navigator group '\(Constants.xcodeDependenciesGroup)' ...", level: .info)
            for groupToRemove in groupsToRemove {
                dependenciesGroup.children.removeAll { $0 == groupToRemove }
            }
        }

        // write project file
        try projectFile.write(path: Path(xcodeProjectPath), override: true)
    }

    func clearDependenciesFolder() throws {
        let dependenciesPath = "\(workingDirectory)/\(Constants.dependenciesPath)/*"
        try bash("rm -rf \(dependenciesPath)")
    }

    func updateDependencies(of appTarget: AppTarget, for platform: Platform, with frameworkProducts: [FrameworkProduct]) throws {
        let dependenciesPlatformPath = "\(workingDirectory)/\(Constants.dependenciesPath)/\(platform.rawValue)"
        let copiedFrameworkProducts: [FrameworkProduct] = try copy(frameworkProducts: frameworkProducts, of: appTarget, to: dependenciesPlatformPath)
        try link(frameworkProducts: copiedFrameworkProducts, with: appTarget, for: platform)
    }

    private func copy(frameworkProducts: [FrameworkProduct], of appTarget: AppTarget, to targetPath: String) throws -> [FrameworkProduct] {
        print("Copying build products of target '\(appTarget.targetName)' into folder '\(Constants.dependenciesPath)' ...", level: .info)

        try bash("mkdir -p '\(targetPath)'")
        var copiedFrameworkProducts: [FrameworkProduct] = []

        for frameworkProduct in frameworkProducts {
            let frameworkDirPath = "\(targetPath)/\(frameworkProduct.frameworkDirUrl.lastPathComponent)"
            let symbolsFilePath = "\(targetPath)/\(frameworkProduct.symbolsFileUrl.lastPathComponent)"

            if FileManager.default.fileExists(atPath: frameworkDirPath) {
                try bash("rm -rf '\(frameworkDirPath)'")
            }

            if FileManager.default.fileExists(atPath: symbolsFilePath) {
                try bash("rm -rf '\(symbolsFilePath)'")
            }

            try bash("cp -R '\(frameworkProduct.frameworkDirPath)' '\(frameworkDirPath)'")
            try bash("cp -R '\(frameworkProduct.symbolsFilePath)' '\(symbolsFilePath)'")

            let frameworkProduct = FrameworkProduct(frameworkDirPath: frameworkDirPath, symbolsFilePath: symbolsFilePath)
            try frameworkProduct.cleanupRecursiveFrameworkIfNeeded()

            copiedFrameworkProducts.append(frameworkProduct)
        }

        return copiedFrameworkProducts
    }

    private func link(frameworkProducts: [FrameworkProduct], with appTarget: AppTarget, for platform: Platform) throws {
        let xcodeProjectPath = "\(workingDirectory)/\(appTarget.projectName).xcodeproj"
        let projectFile = try XcodeProj(path: Path(xcodeProjectPath))
        let pbxproj = projectFile.pbxproj

        guard let targetObject = pbxproj.targets(named: appTarget.targetName).first else {
            print("Could not find any target named '\(appTarget.targetName)' at Xcode project path '\(xcodeProjectPath)'.", level: .error)
            throw XcodeProjectIntegrationError.targetNotFound
        }

        guard let frameworksBuildPhase = targetObject.buildPhases.first(where: { $0.buildPhase == .frameworks }) as? PBXFrameworksBuildPhase else {
            print("Could not find frameworks build phase for target '\(appTarget.targetName)' at Xcode project path '\(xcodeProjectPath)'.", level: .error)
            throw XcodeProjectIntegrationError.frameworksBuildPhaseNotFound
        }

        // ensure the framework search path includes the dependencies path
        for buildConfiguration in targetObject.buildConfigurationList!.buildConfigurations {
            let frameworkSearchPaths: [String] = buildConfiguration.buildSettings["FRAMEWORK_SEARCH_PATHS"] as? [String] ?? ["$(inherited)"]
            if !frameworkSearchPaths.contains("$(PROJECT_DIR)/\(Constants.dependenciesPath)/\(platform.rawValue)") {
                buildConfiguration.buildSettings["FRAMEWORK_SEARCH_PATHS"] = frameworkSearchPaths + ["$(PROJECT_DIR)/\(Constants.dependenciesPath)/\(platform.rawValue)"]
            }
        }

        let rootGroup = try pbxproj.rootGroup()!
        let dependenciesGroup = try rootGroup.group(named: Constants.xcodeDependenciesGroup) ?? rootGroup.addGroup(named: Constants.xcodeDependenciesGroup, options: .withoutFolder)[0]
        let targetGroup = try dependenciesGroup.group(named: appTarget.targetName) ?? dependenciesGroup.addGroup(named: appTarget.targetName, options: .withoutFolder)[0]

        // manage added files
        let frameworksToAdd = frameworkProducts.filter { product in !targetGroup.children.compactMap { $0.path }.contains { $0.hasSuffix(product.frameworkDirUrl.lastPathComponent) } }.removingDuplicates()
        let platformGroupName = "\(Constants.xcodeDependenciesGroup)/\(targetGroup.name!)"

        if !frameworksToAdd.isEmpty {
            let frameworkNames = frameworksToAdd.map { $0.frameworkDirUrl.lastPathComponent.components(separatedBy: ".").first! }
            print("Adding frameworks \(frameworkNames) to project navigator group '\(platformGroupName)' & linking with target '\(appTarget.targetName)' ...", level: .info)

            for frameworkToAdd in frameworksToAdd {
                let frameworkFileRef = try targetGroup.addFile(at: Path(frameworkToAdd.frameworkDirPath), sourceRoot: Path(workingDirectory))

                if let files = frameworksBuildPhase.files, !files.contains(where: { $0.file?.path == frameworkFileRef.path }) {
                    _ = try frameworksBuildPhase.add(file: frameworkFileRef)
                }
            }
        }

        // manage removed files
        let filesToRemove = targetGroup.children.filter { fileRef in !frameworkProducts.contains { $0.frameworkDirPath.hasSuffix(fileRef.name!) } }

        if !filesToRemove.isEmpty {
            let fileNames = filesToRemove.map { $0.name! }
            print("Removing frameworks \(fileNames) from project navigator group '\(platformGroupName)' & unlinking from target '\(appTarget.targetName)' ...", level: .info)

            for fileToRemove in filesToRemove {
                targetGroup.children.removeAll { $0 === fileToRemove }
                frameworksBuildPhase.files?.removeAll { file in
                    file.file === fileToRemove
                }
                pbxproj.delete(object: fileToRemove)
            }
        }

        targetGroup.children.removeDuplicates()
        targetGroup.children.sort { $0.name! < $1.name! }

        switch appTarget.targetType {
        case .regular:
            // manage copy build script for regular targets
            var copyBuildScript: PBXShellScriptBuildPhase! = targetObject.buildPhases.first { $0.type() == .runScript && ($0 as! PBXShellScriptBuildPhase).name == Constants.copyBuildScript } as? PBXShellScriptBuildPhase
            if copyBuildScript == nil {
                print("Creating new copy build script phase '\(Constants.copyBuildScript)' for target '\(appTarget.targetName)'...", level: .info)
                copyBuildScript = PBXShellScriptBuildPhase(name: Constants.copyBuildScript, shellScript: "/usr/local/bin/carthage copy-frameworks")
                targetObject.buildPhases.append(copyBuildScript)
                pbxproj.add(object: copyBuildScript)
            }

            print("Updating input paths in copy build script phase '\(Constants.copyBuildScript)' for target '\(appTarget.targetName)' ...", level: .info)
            copyBuildScript.inputPaths = targetGroup.children.map { "$(SRCROOT)/\($0.path!)" }

        case .test:
            // manage copy frameworks phase for test targets
            var copyFrameworksPhase: PBXCopyFilesBuildPhase! = targetObject.buildPhases.first {
                $0.type() == .copyFiles &&
                    ($0 as! PBXCopyFilesBuildPhase).name == Constants.copyFilesPhase &&
                    ($0 as! PBXCopyFilesBuildPhase).dstSubfolderSpec == .frameworks
                } as? PBXCopyFilesBuildPhase
            if copyFrameworksPhase == nil {
                print("Creating new copy frameworks phase '\(Constants.copyFilesPhase)' for target '\(appTarget.targetName)'...", level: .info)
                copyFrameworksPhase = PBXCopyFilesBuildPhase(dstSubfolderSpec: .frameworks, name: Constants.copyFilesPhase)
                targetObject.buildPhases.append(copyFrameworksPhase)
                pbxproj.add(object: copyFrameworksPhase)
            }

            print("Updating frameworks in copy frameworks phase '\(Constants.copyFilesPhase)' for target '\(appTarget.targetName)' ...", level: .info)
            try targetGroup.children.forEach { _ = try copyFrameworksPhase.add(file: $0) }
            copyFrameworksPhase.files?.forEach { $0.settings = ["ATTRIBUTES": ["CodeSignOnCopy"]] }
        }

        try projectFile.write(path: Path(xcodeProjectPath), override: true)
    }
}
