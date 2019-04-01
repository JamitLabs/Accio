import Foundation

struct FrameworkProduct {
    let frameworkDirPath: String
    let symbolsFilePath: String

    init(frameworkDirPath: String, symbolsFilePath: String) {
        self.frameworkDirPath = frameworkDirPath
        self.symbolsFilePath = symbolsFilePath
    }

    init(libraryName: String, platformName: String) {
        self.frameworkDirPath = Constants.temporaryFrameworksUrl.appendingPathComponent("\(platformName)/\(libraryName).framework").path
        self.symbolsFilePath = Constants.temporaryFrameworksUrl.appendingPathComponent("\(platformName)/\(libraryName).framework.dSYM").path
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

    // This is a workaround for issues with frameworks that symlink to themselves (first found in RxSwift)
    func cleanupRecursiveFrameworkIfNeeded() throws {
        let recursiveFrameworkPath: String = frameworkDirUrl.appendingPathComponent(frameworkDirUrl.lastPathComponent).path
        if FileManager.default.fileExists(atPath: recursiveFrameworkPath) {
            try FileManager.default.removeItem(atPath: recursiveFrameworkPath)
        }
    }
}
