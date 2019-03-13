import Foundation
import SwiftShell

enum FrameworkError: Error {
    case dependencyNotFoundInDependencyGraph
}

struct Framework {
    let directory: String
    let scheme: String
    let commit: String
    let dependencies: [Framework]

    var xcodeProjectPath: String { // TODO: should not only work with projects named like scheme
        return "\(directory)/\(scheme).xcodeproj"
    }

    init(graphDependency: DependencyGraph.Dependency) {
        self.directory = graphDependency.path
        self.scheme = graphDependency.name
        self.commit = run(bash: "git --git-dir \(graphDependency.path)/.git rev-parse HEAD").stdout
        self.dependencies = graphDependency.dependencies.map { Framework(graphDependency: $0) }
    }

    init(targetDependency: Manifest.Target.Dependency, dependencyGraph: DependencyGraph) throws {
        guard let graphDependency = Framework.graphDependency(for: targetDependency, in: dependencyGraph.dependencies) else {
            print("Could not find specified target dependency '\(targetDependency.name)' within dependency graph.", level: .error)
            throw FrameworkError.dependencyNotFoundInDependencyGraph
        }

        self.init(graphDependency: graphDependency)
    }

    private static func graphDependency(for targetDependency: Manifest.Target.Dependency, in graphDependencies: [DependencyGraph.Dependency]) -> DependencyGraph.Dependency? {
        if let matchingGraphDependency = graphDependencies.first(where: { $0.name == targetDependency.name }) {
            return matchingGraphDependency
        }

        for graphDependency in graphDependencies {
            if let matchingGraphDependency = Framework.graphDependency(for: targetDependency, in: graphDependency.dependencies) {
                return matchingGraphDependency
            }
        }

        return nil
    }
}
