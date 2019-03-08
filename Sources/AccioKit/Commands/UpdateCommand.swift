import Foundation
import SwiftCLI

public class UpdateCommand: Command {
    // MARK: - Command
    public let name: String = "update"
    public let shortDescription: String = "Updates the dependencies"

    let sharedCachePath = Key<String>("-c", "--shared-cache-path", description: "Path used by multiple users for caching built products")

    // MARK: - Initializers
    public init() {}

    // MARK: - Instance Methods
    public func execute() throws {
        try DependencyResolverService.shared.updateDependencies()
        let manifest = try loadManifest()
        try buildFrameworksAndIntegrateWithXcode(manifest: manifest, sharedCachePath: sharedCachePath.value)
    }
}

extension UpdateCommand: DependencyInstaller {}
