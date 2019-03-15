import Foundation
import SwiftCLI

public class ClearCacheCommand: Command {
    // MARK: - Command
    public let name: String = "clear-cache"
    public let shortDescription: String = "Deletes all cached build products from local cache to make up space"

    // MARK: - Initializers
    public init() {}

    // MARK: - Instance Methods
    public func execute() throws {
        guard FileManager.default.fileExists(atPath: Constants.localCachePath) else {
            print("Local cache is already empty.", level: .info)
            return
        }

        print("Calculating size of local cache ...", level: .info)
        let localCacheDirectorySizeInBytes = try FileManager.default.directorySizeInBytes(atPath: Constants.localCachePath)

        print("Clearing local cache ...", level: .info)
        try bash("rm -rf '\(Constants.localCachePath)'")

        let byteCountFormatter = ByteCountFormatter()
        let localCacheSizeString = byteCountFormatter.string(fromByteCount: localCacheDirectorySizeInBytes)
        print("Successfully cleared local cache. Total space freed up: \(localCacheSizeString)", level: .info)
    }
}
