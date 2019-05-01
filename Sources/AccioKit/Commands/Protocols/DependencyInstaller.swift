import Foundation
import SwiftCLI

enum DependencyInstallerError: Error {
    case noTargetsInManifest
}

protocol DependencyInstaller {
    func loadManifest() throws -> Manifest
    func revertCheckoutChanges(workingDirectory: String) throws
    func buildFrameworksAndIntegrateWithXcode(manifest: Manifest, dependencyGraph: DependencyGraph, sharedCachePath: String?) throws
}

extension DependencyInstaller {
    func loadManifest() throws -> Manifest {
        let manifest = try ManifestHandlerService.shared.loadManifest(isDependency: false)

        guard !manifest.targets.isEmpty else {
            print("No targets specified in manifest file. Please add at least one target to the 'targets' array in Package.swift.", level: .warning)
            throw DependencyInstallerError.noTargetsInManifest
        }

        return manifest
    }

    func revertCheckoutChanges(workingDirectory: String = GlobalOptions.workingDirectory.value ?? FileManager.default.currentDirectoryPath) throws {
        let workingDirectoryUrl = URL(fileURLWithPath: workingDirectory)
        let checkoutsDirUrl = workingDirectoryUrl.appendingPathComponent("\(Constants.buildPath)/checkouts")

        if FileManager.default.fileExists(atPath: checkoutsDirUrl.path) {
            print("Reverting any changes in the checkouts directory ...", level: .info)

            for fileName in try FileManager.default.contentsOfDirectory(atPath: checkoutsDirUrl.path) {
                let frameworkCheckoutPath: String = checkoutsDirUrl.appendingPathComponent(fileName).path

                if try FileManager.default.isDirectory(atPath: frameworkCheckoutPath) {
                    do {
                        try bash("git -C '\(frameworkCheckoutPath)' reset HEAD --hard --quiet 2> /dev/null")
                        try bash("git -C '\(frameworkCheckoutPath)' clean -fd --quiet 2> /dev/null")
                        try bash("git -C '\(frameworkCheckoutPath)' clean -fdX --quiet 2> /dev/null")
                    }
                    catch {
                        // Remove checkout if git reset fails for some reason
                        // If the checkout is missing, SPM will automatically clone again in the next step
                        FileManager.default.removeItem(atPath: frameworkCheckoutPath)
                    }
                }
            }
        }
    }

    func buildFrameworksAndIntegrateWithXcode(manifest: Manifest, dependencyGraph: DependencyGraph, sharedCachePath: String?) throws {
        if FileManager.default.fileExists(atPath: Constants.temporaryFrameworksUrl.path) {
            try bash("rm -rf '\(Constants.temporaryFrameworksUrl.path)'")
        }

        if FileManager.default.fileExists(atPath: Constants.temporaryUncachingUrl.path) {
            try bash("rm -rf '\(Constants.temporaryUncachingUrl.path)'")
        }

        try bash("mkdir -p '\(Constants.temporaryFrameworksUrl.path)'")
        try bash("mkdir -p '\(Constants.temporaryUncachingUrl.path)'")

        typealias ParsingResult = (target: AppTarget, platform: Platform, frameworkProducts: [FrameworkProduct])

        let appTargets: [AppTarget] = try manifest.appTargets()
        let parsingResults: [ParsingResult] = try appTargets.compactMap { appTarget in
            guard !appTarget.dependentLibraryNames.isEmpty else {
                print("No dependencies specified for target '\(appTarget.targetName)'. Please add at least one dependency scheme to the 'dependencies' array of the target in Package.swift.", level: .warning)
                return nil
            }

            let platform = try PlatformDetectorService.shared.detectPlatform(of: appTarget)
            print("Resolving dependencies for target '\(appTarget.targetName)' on platform '\(platform.rawValue)' ...", level: .info)

            let frameworkProducts = try CachedBuilderService(sharedCachePath: sharedCachePath).frameworkProducts(manifest: manifest, appTarget: appTarget, dependencyGraph: dependencyGraph, platform: platform)
            return ParsingResult(target: appTarget, platform: platform, frameworkProducts: frameworkProducts)
        }

        try XcodeProjectIntegrationService.shared.clearDependenciesFolder()

        for parsingResult in parsingResults {
            try XcodeProjectIntegrationService.shared.updateDependencies(of: parsingResult.target, for: parsingResult.platform, with: parsingResult.frameworkProducts)
        }

        try XcodeProjectIntegrationService.shared.handleRemovedTargets(keepingTargets: appTargets)
        try bash("rm -rf '\(Constants.temporaryFrameworksUrl.path)'")
    }
}
