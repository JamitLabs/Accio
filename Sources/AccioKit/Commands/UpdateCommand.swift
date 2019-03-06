import Foundation
import SwiftCLI

public class UpdateCommand: Command {
    // MARK: - Command
    public let name: String = "update"
    public let shortDescription: String = "Updates the dependencies"

    let sharedCachePath = Key<String>("-c", "--shared-cache-path", description: "Path used by multiple users for caching built products")
    let targetPlatform = Key<String>("-p", "--target-platform", description: "Specify the target platform to build for – one of iOS, tvOS, macOS or watchOS")

    var platform: Platform {
        return Platform.with(target: targetPlatform.value ?? Platform.iOS.rawValue)
    }

    // MARK: - Initializers
    public init() {}

    // MARK: - Instance Methods
    public func execute() throws {
        try DependencyResolverService.shared.updateDependencies()
        let frameworkProductsPerTarget = try CachedBuilderService(sharedCachePath: sharedCachePath.value).frameworkProductsPerTarget(platform: platform)
        try XcodeProjectIntegrationService.shared.updateDependencies(with: frameworkProductsPerTarget)
    }
}
