import Foundation
import SwiftShell

enum FrameworkError: Error {
    case dependencyNotFoundInDependencyGraph
}

struct Framework {
    let directory: String
    let scheme: String
    let commit: String
    let graphDependencies: [DependencyGraph.Dependency]

    var xcodeProjectPath: String { // TODO: should not only work with projects named like scheme
        return "\(directory)/\(scheme).xcodeproj"
    }

    init(directory: String, scheme: String, commit: String, graphDependencies: [DependencyGraph.Dependency]) {
        self.directory = directory
        self.scheme = scheme
        self.commit = commit
        self.graphDependencies = graphDependencies
    }

    private init(scheme: String, graphDependency: DependencyGraph.Dependency) throws {
        self.directory = graphDependency.path
        self.scheme = scheme
        self.commit = run(bash: "git --git-dir \(graphDependency.path)/.git rev-parse HEAD").stdout
        self.graphDependencies = graphDependency.dependencies
    }

    init(targetDependency: Manifest.Target.Dependency, dependencyGraph: DependencyGraph) throws {
        guard let graphDependency = try Framework.graphDependency(for: targetDependency, in: dependencyGraph.dependencies) else {
            print("Could not find specified target dependency '\(targetDependency.name)' within dependency graph.", level: .error)
            throw FrameworkError.dependencyNotFoundInDependencyGraph
        }

        try self.init(scheme: targetDependency.name, graphDependency: graphDependency)
    }

    private static func graphDependency(
        for targetDependency: Manifest.Target.Dependency,
        in graphDependencies: [DependencyGraph.Dependency]
    ) throws -> DependencyGraph.Dependency? {
        let matchingGraphDependency = try graphDependencies.first { graphDependency in
            let manifest = try ManifestHandlerService(workingDirectory: graphDependency.path).loadManifest(isDependency: true)
            return manifest.products.filter { $0.productType == "library" }.contains { $0.name == targetDependency.name }
        }

        if let matchingGraphDependency = matchingGraphDependency {
            return matchingGraphDependency
        }

        for graphDependency in graphDependencies {
            if let matchingGraphDependency = try Framework.graphDependency(for: targetDependency, in: graphDependency.dependencies) {
                return matchingGraphDependency
            }
        }

        return nil
    }
}
