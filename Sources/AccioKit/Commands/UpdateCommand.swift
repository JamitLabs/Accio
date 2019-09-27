import Foundation
import SwiftCLI

public class UpdateCommand: Command {
    // MARK: - Command
    public let name: String = "update"
    public let shortDescription: String = "Updates the dependencies"

    let sharedCachePath = Key<String>("-c", "--shared-cache-path", description: "Path used by multiple users for caching built products")
    let toolchain = Key<String>("-t", "--toolchain", description: "Selection of a swift toolchain used for build")

    // MARK: - Initializers
    public init() {}

    // MARK: - Instance Methods
    public func execute() throws {
        let config = try Config.load()
        try revertCheckoutChanges()
        try DependencyResolverService.shared.updateDependencies()

        let manifest = try loadManifest()
        let dependencyGraph = try DependencyResolverService.shared.dependencyGraph()

        try buildFrameworksAndIntegrateWithXcode(
            manifest: manifest,
            dependencyGraph: dependencyGraph,
            sharedCachePath: sharedCachePath.value ?? config.defaultSharedCachePath,
            toolchain: toolchain.value
        )
        print("Successfully updated dependencies.", level: .info)
    }
}

extension UpdateCommand: DependencyInstaller {}
