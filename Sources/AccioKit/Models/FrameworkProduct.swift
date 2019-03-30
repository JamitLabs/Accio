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
}
