import Foundation

final class DependencyResolverService {
    static let shared = DependencyResolverService()

    func resolveDependencies() throws {
        try bash("swift package resolve --build-path \(Constants.buildPath)")
    }

    func updateDependencies() throws {
        try bash("swift package update --build-path \(Constants.buildPath)")
    }
}
