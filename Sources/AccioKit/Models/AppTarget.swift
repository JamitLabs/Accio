import Foundation

struct AppTarget {
    enum TargetType: String {
        case regular
        case test
    }

    let projectName: String
    let targetName: String
    let dependentLibraryNames: [String]
    let targetType: TargetType
}

extension AppTarget {
    func frameworkDependencies(manifest: Manifest, dependencyGraph: DependencyGraph) throws -> [Framework] {
        var frameworks: [Framework] = []

        for libraryName in dependentLibraryNames {
            frameworks.append(try dependencyGraph.framework(libraryName: libraryName))
        }

        return frameworks
    }
}
