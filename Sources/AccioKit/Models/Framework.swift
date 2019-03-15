import Foundation
import SwiftShell

enum FrameworkError: Error {
    case noSharedSchemes
}

struct Framework {
    let projectName: String
    let libraryName: String
    let projectDirectory: String
    let requiredFrameworks: [Framework]

    var commitHash: String {
        return run(bash: "git -C '\(projectDirectory)' rev-parse HEAD").stdout
    }

    var generatedXcodeProjectPath: String {
        return URL(fileURLWithPath: projectDirectory).appendingPathComponent("\(projectName).xcodeproj").path
    }

    func xcodeProjectPaths() throws -> [String] {
        let projectDirUrl: URL = URL(fileURLWithPath: projectDirectory)
        let rootProjectFileNames: [String] = try FileManager.default.contentsOfDirectory(atPath: projectDirectory).filter { pathIsProjectFile($0) }
        let rootProjectFilePaths: [String] = rootProjectFileNames.map { projectDirUrl.appendingPathComponent($0).path }

        let projectNameDirUrl: URL = projectDirUrl.appendingPathComponent(projectName)
        guard FileManager.default.fileExists(atPath: projectNameDirUrl.path) else {
            return rootProjectFilePaths.filter { !$0.isAliasFile }
        }

        let projectNameDirProjectFileNames: [String] = try FileManager.default.contentsOfDirectory(atPath: projectNameDirUrl.path).filter { pathIsProjectFile($0) }
        let projectNameDirProjectFilePaths: [String] = projectNameDirProjectFileNames.map { projectNameDirUrl.appendingPathComponent($0).path }

        return (rootProjectFilePaths + projectNameDirProjectFilePaths).filter { !$0.isAliasFile }
    }

    func sharedSchemePaths() throws -> [String] {
        return try xcodeProjectPaths().reduce([]) { result, xcodeProjectPath in
            // TODO: doesn't find existing shared framework in AlignedCollectionViewFlowLayout project, debug
            let schemesDirUrl: URL = URL(fileURLWithPath: xcodeProjectPath).appendingPathComponent("xcshareddata/xcschemes")
            guard FileManager.default.fileExists(atPath: schemesDirUrl.path) else { return result }

            let sharedSchemeFileNames: [String] = try FileManager.default.contentsOfDirectory(atPath: schemesDirUrl.path).filter { $0.hasSuffix(".xcscheme") }
            return result + sharedSchemeFileNames.map { schemesDirUrl.appendingPathComponent($0).path }
        }
    }

    private func pathIsProjectFile(_ path: String) -> Bool {
        return path.hasSuffix(".xcodeproj") || path.hasSuffix(".xcworkspace")
    }
}
