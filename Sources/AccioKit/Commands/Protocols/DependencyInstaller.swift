import Foundation

enum DependencyInstallerError: Error {
    case noTargetsInManifest
}

protocol DependencyInstaller {
    func loadManifest() throws -> Manifest
    func buildFrameworksAndIntegrateWithXcode(manifest: Manifest, dependencyGraph: DependencyGraph, sharedCachePath: String?) throws
}

extension DependencyInstaller {
    func loadManifest() throws -> Manifest {
        let manifest = try ManifestHandlerService.shared.loadManifest()

        guard !manifest.targets.isEmpty else {
            print("No targets specified in manifest file. Please add at least one target to the 'targets' array in Package.swift.", level: .warning)
            throw DependencyInstallerError.noTargetsInManifest
        }

        return manifest
    }

    func buildFrameworksAndIntegrateWithXcode(manifest: Manifest, dependencyGraph: DependencyGraph, sharedCachePath: String?) throws {
        for target in manifest.targets {
            guard !target.dependencies.isEmpty else {
                print("No dependencies specified for target '\(target.name)'. Please add at least one dependency scheme to the 'dependencies' array of the target in Package.swift.", level: .warning)
                continue
            }

            let platform = try PlatformDetectorService.shared.detectPlatform(projectName: manifest.name, targetName: target.name)
            let frameworkProducts = try CachedBuilderService(sharedCachePath: sharedCachePath).frameworkProducts(target: target, dependencyGraph: dependencyGraph, platform: platform)
            try XcodeProjectIntegrationService.shared.updateDependencies(of: target, for: platform, in: manifest.name, with: frameworkProducts)
        }
    }
}
