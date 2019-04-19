import Foundation
import SwiftShell

enum DependencyResolverError: Error {
    case dependencyGraphGenerationFailed
}

final class DependencyResolverService {
    static let shared = DependencyResolverService(workingDirectory: GlobalOptions.workingDirectory.value ?? FileManager.default.currentDirectoryPath)

    private let workingDirectory: String

    init(workingDirectory: String) {
        self.workingDirectory = workingDirectory
    }

    func resolveDependencies() throws {
        print("Resolving dependencies ...", level: .info)
        try bash("swift package \(contextSpecifiers()) resolve")
    }

    func updateDependencies() throws {
        print("Updating dependencies ...", level: .info)
        try bash("swift package \(contextSpecifiers()) update")
    }

    func dependencyGraph() throws -> DependencyGraph {
        print("Generating dependency graph ...", level: .info)
        let output = run(bash: "swift package \(contextSpecifiers()) show-dependencies --format json")

        guard output.exitcode == 0 else {
            print(output.stderror, level: .error)

            if output.stderror.contains("contains mixed language source files") {
                print(
                    """
                    Please make sure that the 'path' of all targets in Package.swift are set to directories containing only Swift files.
                        For additional details, please see here: https://github.com/JamitLabs/Accio/issues/3
                    """,
                    level: .warning
                )
            } else if output.stderror.contains("multiple targets named") {
                print("This is a known issue. For more details, please see here: https://github.com/JamitLabs/Accio/issues/26", level: .warning)
            }

            throw DependencyResolverError.dependencyGraphGenerationFailed
        }

        let dependencyGraphJson: String = {
            if output.stdout.hasPrefix("{") {
                return output.stdout
            } else {
                let separator = "\n{"
                return separator + output.stdout.components(separatedBy: separator).dropFirst().joined(separator: separator)
            }
        }()

        print("Dependency graph JSON output is:\n\(dependencyGraphJson)", level: .verbose)
        return try JSONDecoder.swiftPM.decode(DependencyGraph.self, from: dependencyGraphJson.data(using: .utf8)!)
    }

    private func contextSpecifiers() -> String {
        return "--package-path '\(workingDirectory)' --build-path '\(workingDirectory)/\(Constants.buildPath)'"
    }
}
