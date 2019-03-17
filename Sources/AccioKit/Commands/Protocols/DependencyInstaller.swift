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
        let manifest = try ManifestHandlerService.shared.loadManifest(isDependency: false)

        guard !manifest.targets.isEmpty else {
            print("No targets specified in manifest file. Please add at least one target to the 'targets' array in Package.swift.", level: .warning)
            throw DependencyInstallerError.noTargetsInManifest
        }

        return manifest
    }

    func buildFrameworksAndIntegrateWithXcode(manifest: Manifest, dependencyGraph: DependencyGraph, sharedCachePath: String?) throws {
        for appTarget in manifest.appTargets {
            guard !appTarget.dependentLibraryNames.isEmpty else {
                print("No dependencies specified for target '\(appTarget.targetName)'. Please add at least one dependency scheme to the 'dependencies' array of the target in Package.swift.", level: .warning)
                continue
            }

            let platform = try PlatformDetectorService.shared.detectPlatform(of: appTarget)
            let frameworkProducts = try CachedBuilderService(sharedCachePath: sharedCachePath).frameworkProducts(manifest: manifest, appTarget: appTarget, dependencyGraph: dependencyGraph, platform: platform)
            try XcodeProjectIntegrationService.shared.updateDependencies(of: appTarget, for: platform, with: frameworkProducts)
        }
    }
}
