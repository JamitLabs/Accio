import Foundation

extension FileManager {
    static var userCacheDirUrl: URL {
        return FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
    }
}
