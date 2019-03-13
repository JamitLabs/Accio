import Foundation

class Manifest: Decodable {
    // MARK: - Sub Types
    struct Target: Decodable {
        struct Dependency: Decodable {
            let name: String
        }

        let name: String
        let dependencies: [Dependency]
    }

    struct Product: Decodable {
        let name: String
        let productType: String
        let targets: [String]
    }

    // MARK: - Properties
    let name: String
    let products: [Product]
    let targets: [Target]
}

extension Manifest.Target {
    func frameworks(dependencyGraph: DependencyGraph) throws -> [Framework] {
        return try dependencies.map { dependency in
            return try Framework(targetDependency: dependency, dependencyGraph: dependencyGraph)
        }
    }
}
