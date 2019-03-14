import Foundation
import SwiftShell

struct Framework {
    let projectName: String
    let libraryName: String
    let projectDirectory: String
    let requiredFrameworks: [Framework]

    var commitHash: String {
        return run(bash: "git --git-dir '\(projectDirectory)/.git' rev-parse HEAD").stdout
    }

    var xcodeProjectPath: String {
        return URL(fileURLWithPath: projectDirectory).appendingPathComponent("\(projectName).xcodeproj").path
    }
}
