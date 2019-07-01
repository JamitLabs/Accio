import Foundation

struct FrameworkProduct {
    let frameworkDirPath: String
    let symbolsFilePath: String
    let commitHash: String

    init(frameworkDirPath: String, symbolsFilePath: String, commitHash: String) {
        self.frameworkDirPath = frameworkDirPath
        self.symbolsFilePath = symbolsFilePath
        self.commitHash = commitHash
    }

    init(libraryName: String, platformName: String, commitHash: String) {
        self.frameworkDirPath = Constants.temporaryFrameworksUrl.appendingPathComponent("\(platformName)/\(libraryName).framework").path
        self.symbolsFilePath = Constants.temporaryFrameworksUrl.appendingPathComponent("\(platformName)/\(libraryName).framework.dSYM").path
        self.commitHash = commitHash
    }

    var frameworkDirUrl: URL {
        return URL(fileURLWithPath: frameworkDirPath)
    }

    var symbolsFileUrl: URL {
        return URL(fileURLWithPath: symbolsFilePath)
    }

    var libraryName: String {
        return frameworkDirUrl.lastPathComponent.replacingOccurrences(of: ".framework", with: "")
    }

    var platformName: String {
        return frameworkDirUrl.pathComponents.suffix(2).first!
    }

    // This is a workaround for issues with frameworks that symlink to themselves (first found in RxSwift)
    func cleanupRecursiveFrameworkIfNeeded() throws {
        let recursiveFrameworkPath: String = frameworkDirUrl.appendingPathComponent(frameworkDirUrl.lastPathComponent).path
        if FileManager.default.fileExists(atPath: recursiveFrameworkPath) {
            try FileManager.default.removeItem(atPath: recursiveFrameworkPath)
        }
    }
}
