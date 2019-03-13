import Foundation

class Manifest: Decodable {
    // MARK: - Sub Types
    struct Target: Decodable {
        struct Dependency: Decodable {
            let name: String
        }

        let name: String
        let type: String
        let dependencies: [Dependency]
    }

    // MARK: - Properties
    let name: String
    let targets: [Target]
}

extension Manifest.Target {
    func frameworks(dependencyGraph: DependencyGraph) -> [Framework] {
        return [] // TODO: not yet implemented
    }
}
