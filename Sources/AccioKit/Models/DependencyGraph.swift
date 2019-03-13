import Foundation

struct DependencyGraph: Decodable {
    // MARK: - Sub Types
    struct Dependency: Decodable {
        let name: String
        let path: String
        let dependencies: [Dependency]
    }

    // MARK: - Properties
    let name: String
    let dependencies: [Dependency]
}
