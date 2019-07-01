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
        let config = try Config.load()

        if try loadRequiredFrameworksFromCache(sharedCachePath: sharedCachePath.value ?? config.defaultSharedCachePath) {
            print("No changes found & successfully copied dependencies from cache.", level: .info)
            return
        }

        try revertCheckoutChanges()
        try DependencyResolverService.shared.resolveDependencies()

        let manifest = try loadManifest()
        let dependencyGraph = try DependencyResolverService.shared.dependencyGraph()

        try buildFrameworksAndIntegrateWithXcode(
            manifest: manifest,
            dependencyGraph: dependencyGraph,
            sharedCachePath: sharedCachePath.value ?? config.defaultSharedCachePath
        )
        print("Successfully installed dependencies.", level: .info)
    }
}

extension InstallCommand: DependencyInstaller {}
