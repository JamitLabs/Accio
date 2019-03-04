import Foundation
import SwiftCLI

public class InstallCommand: Command {
    // MARK: - Command
    public let name: String = "install"
    public let shortDescription: String = "Installs the already resolved dependencies"

    let target = Parameter()

    var platform: Platform {
        return Platform.with(target: target.value)
    }

    // MARK: - Initializers
    public init() {}

    // MARK: - Instance Methods
    public func execute() throws {
        try DependencyResolverService.shared.resolveDependencies()
        let frameworkProducts = try CachedBuilderService.shared.frameworkProducts(platform: platform)
        try XcodeProjectIntegrationService.shared.updateDependencies(with: frameworkProducts)
    }
}
