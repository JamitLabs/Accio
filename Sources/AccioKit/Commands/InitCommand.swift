import Foundation
import SwiftCLI

enum InitCommandError: Error {
    case missingProjectName
    case missingTargetNames
}

public class InitCommand: Command {
    // MARK: - Command
    public let name: String = "init"
    public let shortDescription: String = "Initializes Accio in this project"

    let projectName = Key<String>("-p", "--project-name", description: "The name of the Xcode project file (without the .xcodeproj extension)")
    let targetNames = Key<String>("-t", "--target-name", description: "A comma-separated list of your App targets")

    // MARK: - Initializers
    public init() {}

    // MARK: - Instance Methods
    public func execute() throws {
        guard let projectName = self.projectName.value else {
            print("Missing parameter: \(self.projectName.names.last!)", level: .error)
            throw InitCommandError.missingProjectName
        }

        guard let targetNames = targetNames.value?.components(separatedBy: ",") else {
            print("Missing parameter: \(self.targetNames.names.last!)", level: .error)
            throw InitCommandError.missingTargetNames
        }

        try ManifestCreatorService.shared.createManifestFromDefaultTemplateIfNeeded(projectName: projectName, targetNames: targetNames)
        try GitIgnoreIntegrationService.shared.addIgnoreEntriesIfNeeded()

        print("Successfully initialized project.", level: .info)
    }
}
