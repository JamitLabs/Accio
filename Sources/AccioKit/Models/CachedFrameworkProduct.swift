import Foundation

struct CachedFrameworkProduct: Codable {
    let swiftVersion: String
    let libraryName: String
    let commitHash: String
    let platform: String

    var cacheFileSubPath: String {
        return "\(swiftVersion)/\(libraryName)/\(commitHash)/\(platform).zip"
    }
}
