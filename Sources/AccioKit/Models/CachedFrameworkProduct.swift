import Foundation

struct CachedFrameworkProduct: Codable {
    let libraryName: String
    let commitHash: String
    let platform: String

    func getCacheFileSubPath() throws -> String {
        let swiftVersion = try SwiftVersionDetectorService.shared.getCurrentSwiftVersion()
        return "\(swiftVersion)/\(libraryName)/\(commitHash)/\(platform).zip"
    }
}
