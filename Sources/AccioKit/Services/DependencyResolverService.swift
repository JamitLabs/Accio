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

        print("Dependency graph JSON output is:\n\n\(dependencyGraphJson)\n\n", level: .verbose)
        return try JSONDecoder().decode(DependencyGraph.self, from: dependencyGraphJson.data(using: .utf8)!)
    }

    private func contextSpecifiers() -> String {
        return "--package-path \(workingDirectory) --build-path \(workingDirectory)/\(Constants.buildPath)"
    }
}
