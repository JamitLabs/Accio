import Foundation

enum ManifestError: Error {
    case libraryNotFound
}

class Manifest: Decodable {
    // MARK: - Sub Types
    struct Target: Decodable {
        struct Dependency: Decodable {
            let byName: [String]
        }

        let name: String
        let type: String
        let dependencies: [Dependency]
    }

    struct Product: Decodable {
        struct ProductType: Decodable {
            let library: [String]?
        }

        let name: String
        let type: ProductType
        let targets: [String]
    }

    // MARK: - Properties
    let name: String
    let products: [Product]
    let targets: [Target]
}

extension Manifest {
    var appTargets: [AppTarget] {
        return targets.filter { $0.type == "regular" }.map { AppTarget(projectName: name, targetName: $0.name, dependentLibraryNames: $0.dependencies.flatMap { $0.byName }) }
    }

    func frameworkDependencies(ofLibrary libraryName: String, dependencyGraph: DependencyGraph) throws -> [Framework] {
        let libraryProducts: [Product] = products.filter { $0.type.library != nil && !$0.type.library!.isEmpty }

        guard let product: Product = libraryProducts.first(where: { $0.name == libraryName }) else {
            print("Manifest: Could not find library product with name '\(libraryName)' in package manifest for project '\(name)'.", level: .error)
            throw ManifestError.libraryNotFound
        }

        let productsTargets: [Target] = targets.filter { product.targets.contains($0.name) }
        let dependencyTargetNames: [String] = Array(Set(productsTargets.flatMap { $0.dependencies.flatMap { $0.byName } })).sorted()

        let projectTargetNames: [String] = targets.map { $0.name }
        let projectProductNames: [String] = products.map { $0.name }

        let dependencyInternalLibraryNames: [String] = dependencyTargetNames.filter { projectProductNames.contains($0) }
        let dependencyExternalLibraryNames: [String] = dependencyTargetNames.filter { !projectTargetNames.contains($0) }

        let libraryNames: [String] = dependencyInternalLibraryNames + dependencyExternalLibraryNames
        return try libraryNames.map { try dependencyGraph.framework(libraryName: $0) }
    }
}
