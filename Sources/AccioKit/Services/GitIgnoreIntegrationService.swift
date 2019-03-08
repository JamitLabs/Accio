import Foundation
import HandySwift

enum GitIgnoreIntegrationError: Error {
    case gitignoreFileReadingFailed
}

final class GitIgnoreIntegrationService {
    static let shared = GitIgnoreIntegrationService(workingDirectory: FileManager.default.currentDirectoryPath)

    private let workingDirectory: String

    init(workingDirectory: String) {
        self.workingDirectory = workingDirectory
    }

    func addIgnoreEntriesIfNeeded() throws {
        let gitignoreUrl = URL(fileURLWithPath: workingDirectory).appendingPathComponent(".gitignore")

        if !FileManager.default.fileExists(atPath: gitignoreUrl.path) {
            try bash("touch \(gitignoreUrl.path)")
        }

        var gitignoreContents: String = try String(contentsOfFile: gitignoreUrl.path)
        if !gitignoreContents.contains("\n\(Constants.dependenciesPath)/\n") || !gitignoreContents.contains("\n\(Constants.buildPath)/\n") {
            print("Adding .gitignore entries for build & dependencies directories.", level: .info)

            if !gitignoreContents.isBlank {
                gitignoreContents += "\n\n"
            }

            gitignoreContents += "# Accio dependency management\n\(Constants.dependenciesPath)/\n\(Constants.buildPath)/\n"
            try gitignoreContents.write(toFile: gitignoreUrl.path, atomically: true, encoding: .utf8)
        }
    }
}
