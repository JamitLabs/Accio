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
        return URL(fileURLWithPath: projectDirectory).appendingPathComponent(projectName).path
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

    func containsXcodeProjectWithLibraryScheme() throws -> Bool {
        return try xcodeProjectPaths().contains { xcodeProjectPath -> Bool in
            let schemesDirPath: String = URL(fileURLWithPath: xcodeProjectPath).appendingPathComponent("xcshareddata/xcschemes").path
            return try FileManager.default.contentsOfDirectory(atPath: schemesDirPath).contains(libraryName)
        }
    }

    private func pathIsProjectFile(_ path: String) -> Bool {
        return path.hasSuffix(".xcodeproj") || path.hasSuffix(".xcworkspace")
    }
}
