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
        let manifest = try loadManifest()
        try buildFrameworksAndIntegrateWithXcode(manifest: manifest, sharedCachePath: sharedCachePath.value)
        print("Successfully installed dependencies.", level: .info)
    }
}

extension InstallCommand: DependencyInstaller {}
