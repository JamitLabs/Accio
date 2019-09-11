import Foundation

enum ManifestError: Error {
    case libraryNotFound
}

class Manifest: Decodable {
    // MARK: - Sub Types
    struct Target: Decodable {
        struct Dependency {
            let names: [String]
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
    func appTargets(workingDirectory: String = GlobalOptions.workingDirectory.value ?? FileManager.default.currentDirectoryPath) throws -> [AppTarget] {
        return try targets.compactMap {
            var targetType: AppTarget.TargetType?

            switch $0.type {
            case AppTarget.TargetType.test.rawValue:
                targetType = AppTarget.TargetType.test

            default:
                let targetTypeDetectorService = TargetTypeDetectorService(workingDirectory: workingDirectory)
                targetType = try targetTypeDetectorService.detectTargetType(ofTarget: $0.name, in: name)

                if targetType! == .test {
                    print("Unexpectedly found '\(targetType!.wrapperExtension)' wrapper extension product for non-test target '\($0.name)'.", level: .warning)
                }
            }

            return AppTarget(projectName: name, targetName: $0.name, dependentLibraryNames: $0.dependencies.flatMap { $0.names }, targetType: targetType!)
        }
    }

    func frameworkDependencies(ofLibrary libraryName: String, dependencyGraph: DependencyGraph) throws -> [Framework] {
        let libraryProducts: [Product] = products.filter { $0.type.library != nil && !$0.type.library!.isEmpty }

        guard let product: Product = libraryProducts.first(where: { $0.name == libraryName }) else {
            print("Manifest: Could not find library product with name '\(libraryName)' in package manifest for project '\(name)'.", level: .error)
            throw ManifestError.libraryNotFound
        }

        let productsTargets: [Target] = targets.filter { product.targets.contains($0.name) }
        let dependencyNames: [String] = Array(Set(productsTargets.flatMap { $0.dependencies.flatMap { $0.names } })).sorted()

        let projectTargetNames: [String] = targets.map { $0.name }
        let projectProductNames: [String] = products.map { $0.name }

        let dependencyInternalLibraryNames: [String] = dependencyNames.filter { projectProductNames.contains($0) }
        let dependencyExternalLibraryNames: [String] = dependencyNames.filter { !projectTargetNames.contains($0) }

        let libraryNames: [String] = dependencyInternalLibraryNames + dependencyExternalLibraryNames
        return try libraryNames.map { try dependencyGraph.framework(libraryName: $0) }
    }
}

extension Manifest.Target.Dependency: Decodable {
    enum ManifestTargetDependencyParsingError: Error { case error }
    enum CodingKeys: String, CodingKey {
        case byName
        case target
        case product
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        if let byName = try container.decodeIfPresent([String?].self, forKey: .byName) {
            names = byName.compactMap { $0 }
        } else if let target = try container.decodeIfPresent([String?].self, forKey: .target) {
            names = target.compactMap { $0 }
        } else if let product = try container.decodeIfPresent([String?].self, forKey: .product) {
            names = product.compactMap { $0 }
        } else {
            throw ManifestTargetDependencyParsingError.error
        }
    }
}
