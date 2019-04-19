import Foundation

struct AppTarget {
    enum TargetType: String, CaseIterable {
        case app
        case test
        case appExtension

        var packageSpecifier: String {
            switch self {
            case .app, .appExtension:
                return "target"

            case .test:
                return "testTarget"
            }
        }

        var wrapperExtension: String {
            switch self {
            case .app:
                return "app"

            case .appExtension:
                return "appex"

            case .test:
                return "xctest"
            }
        }
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
