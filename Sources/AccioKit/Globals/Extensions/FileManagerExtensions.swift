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

    func directorySizeInBytes(atPath path: String) throws -> Int64 {
        let folderUrl = URL(fileURLWithPath: path)
        let relativeFilePaths: [String] = try FileManager.default.subpathsOfDirectory(atPath: path)
        let filePaths: [String] = relativeFilePaths.map { folderUrl.appendingPathComponent($0).path }
        return try filePaths.reduce(0) { $0 + (try fileSizeInBytes(atPath: $1)) }
    }

    func fileSizeInBytes(atPath path: String) throws -> Int64 {
        return Int64(try FileManager.default.attributesOfItem(atPath: path)[FileAttributeKey.size] as! UInt64)
    }

    func isDirectory(atPath path: String) throws -> Bool {
        var isDirectory: ObjCBool = false

        if fileExists(atPath: path, isDirectory: &isDirectory) {
            return isDirectory.boolValue
        } else {
            return false
        }
    }
}
