import Foundation

enum DependencyInstallerError: Error {
    case noTargetsInManifest
}

protocol DependencyInstaller {
    func loadManifest() throws -> Manifest
    func buildFrameworksAndIntegrateWithXcode(manifest: Manifest, sharedCachePath: String?) throws
}

extension DependencyInstaller {
    func loadManifest() throws -> Manifest {
        let manifest = try ManifestReaderService.shared.readManifest()

        guard !manifest.frameworksPerTargetName.isEmpty else {
            print("No targets specified in manifest file. Please add at least one target to the 'targets' array.", level: .warning)
            throw DependencyInstallerError.noTargetsInManifest
        }

        return manifest
    }

    func buildFrameworksAndIntegrateWithXcode(manifest: Manifest, sharedCachePath: String?) throws {
        for (targetName, frameworks) in manifest.frameworksPerTargetName {
            guard !frameworks.isEmpty else {
                print("No dependencies specified for target '\(targetName)'. Please add at least one dependency scheme to the 'dependencies' array of the target.", level: .warning)
                continue
            }

            let platform = try PlatformDetectorService.shared.detectPlatform(projectName: manifest.projectName, targetName: targetName)
            let target = Target(name: targetName, platform: platform)

            let frameworkProducts = try CachedBuilderService(sharedCachePath: sharedCachePath).frameworkProducts(target: target, frameworks: frameworks)
            try XcodeProjectIntegrationService.shared.updateDependencies(of: target, in: manifest.projectName, with: frameworkProducts)
        }
    }
}
