import Foundation
import SwiftCLI

public class InstallCommand: Command {
    // MARK: - Command
    public let name: String = "install"
    public let shortDescription: String = "Installs the already resolved dependencies"

    let sharedCachePath = Key<String>("-c", "--shared-cache-path", description: "Path used by multiple users for caching built products")

    // MARK: - Initializers
    public init() {}

    // MARK: - Instance Methods
    public func execute() throws {
        try DependencyResolverService.shared.resolveDependencies()
        let manifest = try ManifestReaderService.shared.readManifest()

        for (targetName, frameworks) in manifest.frameworksPerTargetName {
            let platform = try PlatformDetectorService.shared.detectPlatform(projectName: manifest.projectName, targetName: targetName)
            let target = Target(name: targetName, platform: platform)

            let frameworkProducts = try CachedBuilderService(sharedCachePath: sharedCachePath.value).frameworkProducts(target: target, frameworks: frameworks)
            try XcodeProjectIntegrationService.shared.updateDependencies(of: target, in: manifest.projectName, with: frameworkProducts)
        }
    }
}
