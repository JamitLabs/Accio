import Foundation
import SwiftShell

final class DependencyResolverService {
    static let shared = DependencyResolverService(workingDirectory: GlobalOptions.workingDirectory.value ?? FileManager.default.currentDirectoryPath)

    private let workingDirectory: String

    init(workingDirectory: String) {
        self.workingDirectory = workingDirectory
    }

    func resolveDependencies() throws {
        print("Resolving dependencies ...", level: .info)
        try bash("swift package --package-path \(contextSpecifiers()) resolve")
    }

    func updateDependencies() throws {
        print("Updating dependencies ...", level: .info)
        try bash("swift package --package-path \(contextSpecifiers()) update")
    }

    func dependencyGraph() throws -> DependencyGraph {
        print("Generating dependency graph ...", level: .info)
        let dependencyGraphJson = run(bash: "swift package \(contextSpecifiers()) show-dependencies --format json").stdout
        return try JSONDecoder().decode(DependencyGraph.self, from: dependencyGraphJson.data(using: .utf8)!)
    }

    private func contextSpecifiers() -> String {
        return "--package-path \(workingDirectory) --build-path \(workingDirectory)/\(Constants.buildPath)"
    }
}
