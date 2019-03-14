import Foundation
import SwiftCLI

public class CleanCommand: Command {
    // MARK: - Command
    public let name: String = "clean"
    public let shortDescription: String = "Deletes all cached build products from local cache to make up space"

    // MARK: - Initializers
    public init() {}

    // MARK: - Instance Methods
    public func execute() throws {
        print("Calculating size of local cache ...", level: .info)
        let localCacheDirectorySizeInBytes = try FileManager.default.directorySizeInBytes(atPath: Constants.localCachePath)

        print("Cleaning local cache ...", level: .info)
        try bash("rm -rf '\(Constants.localCachePath)'")

        let byteCountFormatter = ByteCountFormatter()
        let localCacheSizeString = byteCountFormatter.string(fromByteCount: localCacheDirectorySizeInBytes)
        print("Successfully cleaned local cache. Total space freed up: \(localCacheSizeString)", level: .info)
    }
}
