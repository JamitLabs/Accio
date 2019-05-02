import Foundation
import SwiftCLI

enum SupportCommandError: Error {
    case unknownPlatform(String)
}

public class SupportCommand: Command {
    // MARK: - Command
    public let name: String = "supports"
    public let shortDescription: String = "Validates if the project is supporting accio"

    public let platforms = OptionalParameter(
        completion: .values([
            (name: "iOS", description: "Check support for platform iOS"),
            (name: "macOS", description: "Check support for platform macOS"),
            (name: "tvOS", description: "Check support for platform tvOS"),
            (name: "watchOS", description: "Check support for platform watchOS"),
        ])
    )

    // MARK: - Initializers
    public init() {}

    // MARK: - Instance Methods
    private func parsePlatforms() throws -> [Platform] {
        guard let arguments = platforms.value?.components(separatedBy: ",") else {
            return Platform.allCases
        }

        return try arguments.map { argument -> Platform in
            guard let platform = Platform(rawValue: argument) else {
                throw SupportCommandError.unknownPlatform(argument)
            }

            return platform
        }
    }

    public func execute() throws {
        let targetPlatforms = try parsePlatforms()
        targetPlatforms.forEach { platform in
            print("Implementation missing!", level: .error)
        }
    }
}
