import Foundation

struct FrameworkProduct {
    let frameworkDirPath: String
    let symbolsFilePath: String

    var frameworkDirUrl: URL {
        return URL(fileURLWithPath: frameworkDirPath)
    }

    var symbolsFileUrl: URL {
        return URL(fileURLWithPath: symbolsFilePath)
    }
}
