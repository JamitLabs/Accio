import Foundation
import Version

enum DependencyGraphError: Error {
    case libraryNotFound
}

class DependencyGraph: Decodable {
    // MARK: - Sub Types
    class Dependency: Decodable {
        let name: String
        let path: String
        let version: String
        let dependencies: [Dependency]

        private var cachedManifest: Manifest?

        func manifest() throws -> Manifest {
            if cachedManifest == nil {
                cachedManifest = try ManifestHandlerService(workingDirectory: path).loadManifest(isDependency: true)
            }

            return cachedManifest!
        }
    }

    // MARK: - Properties
    let name: String
    let dependencies: [Dependency]

    private var cachedDeepFirstDependencies: [Dependency]?

    /// Flattened all dependencies including subdependencies into one array.
    var deepFirstDependencies: [Dependency] {
        if cachedDeepFirstDependencies == nil {
            cachedDeepFirstDependencies = dependencies.flatMap { $0.deepFirstDependencies() }
        }

        return cachedDeepFirstDependencies!
    }
}

extension DependencyGraph.Dependency {
    /// Flattened all dependencies including self & subdependencies into one array.
    func deepFirstDependencies() -> [DependencyGraph.Dependency] {
        return dependencies.flatMap { $0.deepFirstDependencies() } + [self]
    }
}

extension DependencyGraph {
    func framework(libraryName: String) throws -> Framework {
        guard let dependency = try deepFirstDependencies.first(where: { try $0.manifest().products.contains { $0.name == libraryName } }) else {
            print("DependencyGraph: Could not find library product with name '\(libraryName)' in package manifest for project '\(name)'.", level: .error)
            throw DependencyGraphError.libraryNotFound
        }

        return Framework(
            projectName: dependency.name,
            libraryName: libraryName,
            version: Version(tolerant: dependency.version),
            projectDirectory: dependency.path,
            requiredFrameworks: try dependency.manifest().frameworkDependencies(ofLibrary: libraryName, dependencyGraph: self)
        )
    }
}
