import Foundation
import SwiftCLI

public class UpdateCommand: Command {
    // MARK: - Command
    public let name: String = "update"
    public let shortDescription: String = "Updates the dependencies"

    let target = Parameter()

    var platform: Platform {
        return Platform.with(target: target.value)
    }

    // MARK: - Initializers
    public init() {}

    // MARK: - Instance Methods
    public func execute() throws {
        try DependencyResolverService.shared.updateDependencies()
        let frameworkProducts = try CachedBuilderService.shared.frameworkProducts(platform: platform)
        try XcodeProjectIntegrationService.shared.updateDependencies(with: frameworkProducts)
    }
}
