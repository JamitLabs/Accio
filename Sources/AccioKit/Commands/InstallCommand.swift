import Foundation
import SwiftCLI

public class InstallCommand: Command {
    // MARK: - Command
    public let name: String = "install"
    public let shortDescription: String = "Installs the already resolved dependencies"

    let sharedCachePath = Key<String>("-c", "--shared-cache-path", description: "Path used by multiple users for caching built products")
    let targetPlatform = Key<String>("-p", "--target-platform", description: "Specify the target platform to build for – one of iOS, tvOS, macOS or watchOS")

    var platform: Platform {
        return Platform.with(target: targetPlatform.value ?? Platform.iOS.rawValue)
    }

    // MARK: - Initializers
    public init() {}

    // MARK: - Instance Methods
    public func execute() throws {
        try DependencyResolverService.shared.resolveDependencies()
        let frameworkProductsPerTarget = try CachedBuilderService(sharedCachePath: sharedCachePath.value).frameworkProductsPerTarget(platform: platform)
        try XcodeProjectIntegrationService.shared.updateDependencies(with: frameworkProductsPerTarget)
    }
}
