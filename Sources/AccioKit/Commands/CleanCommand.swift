import Foundation
import SwiftCLI

public class CleanCommand: Command {
    // MARK: - Command
    public let name: String = "clean"
    public let shortDescription: String = "Deletes all checkouts and build prodcuts from within the current projects directory"

    // MARK: - Initializers
    public init() {}

    // MARK: - Instance Methods
    public func execute() throws {
        print("Calculating size of local build path & temp dirs ...", level: .info)
        let localBuildDirectorySizeInBytes = try FileManager.default.directorySizeInBytes(atPath: Constants.buildPath)
        let temporaryUncachingUrlSizeInBytes = try FileManager.default.directorySizeInBytes(atPath: Constants.temporaryFrameworksUrl.path)
        let temporaryFrameworksUrlSizeInBytes = try FileManager.default.directorySizeInBytes(atPath: Constants.temporaryFrameworksUrl.path)

        print("Cleaning local build path & temp dirs ...", level: .info)
        try bash("rm -rf '\(Constants.buildPath)'")
        try bash("rm -rf '\(Constants.temporaryUncachingUrl.path)'")
        try bash("rm -rf '\(Constants.temporaryFrameworksUrl.path)'")

        let byteCountFormatter = ByteCountFormatter()
        let localBuildPathSizeString = byteCountFormatter.string(
            fromByteCount: localBuildDirectorySizeInBytes + temporaryUncachingUrlSizeInBytes + temporaryFrameworksUrlSizeInBytes
        )
        print("Successfully cleaned local build path & temp dirs. Total space freed up: \(localBuildPathSizeString)", level: .info)
    }
}
