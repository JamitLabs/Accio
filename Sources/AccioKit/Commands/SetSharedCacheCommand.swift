import Foundation
import SwiftCLI

public class SetSharedCacheCommand: Command {
    // MARK: - Command
    public let name: String = "set-shared-cache"
    public let shortDescription: String = "Sets a shared cache path to be used by default for future Accio commands"

    let sharedCachePath = Parameter()

    // MARK: - Initializers
    public init() {}

    // MARK: - Instance Methods
    public func execute() throws {
        let config = try Config.load()
        config.defaultSharedCachePath = sharedCachePath.value
        try config.save()

        print("Successfully set default shared cache path to '\(config.defaultSharedCachePath!)'.", level: .info)
    }
}
