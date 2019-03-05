import Foundation

final class DependencyResolverService {
    static let shared = DependencyResolverService(workingDirectory: FileManager.default.currentDirectoryPath)

    private let workingDirectory: String

    init(workingDirectory: String) {
        self.workingDirectory = workingDirectory
    }

    func resolveDependencies() throws {
        try bash("swift package --package-path \(workingDirectory) --build-path \(workingDirectory)/\(Constants.buildPath) resolve")
    }

    func updateDependencies() throws {
        try bash("swift package --package-path \(workingDirectory) --build-path \(workingDirectory)/\(Constants.buildPath) update")
    }
}
