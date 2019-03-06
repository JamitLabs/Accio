import Foundation

extension FileManager {
    static var userCacheDirUrl: URL {
        return FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
    }

    func createFile(atPath path: String, withIntermediateDirectories: Bool, contents: Data?, attributes: [FileAttributeKey: Any]?) throws {
        let directoryUrl = URL(fileURLWithPath: path).deletingLastPathComponent()

        if withIntermediateDirectories && !FileManager.default.fileExists(atPath: directoryUrl.path) {
            try createDirectory(at: directoryUrl, withIntermediateDirectories: true, attributes: attributes)
        }

        createFile(atPath: path, contents: contents, attributes: attributes)
    }
}
