import Foundation

struct AppTarget {
    let projectName: String
    let targetName: String
    let dependentLibraryNames: [String]
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
