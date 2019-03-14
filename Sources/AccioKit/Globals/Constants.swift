import Foundation

enum Constants {
    static var useTestPaths: Bool = false

    static let buildPath: String = ".accio"
    static let dependenciesPath: String = "Dependencies"
    static let xcodeDependenciesGroup: String = "Dependencies"
    static let copyBuildScript: String = "Accio"

    static var localCachePath: String {
        if useTestPaths {
            FileManager.userCacheDirUrl.appendingPathComponent("AccioTest/Cache").path
        }

        return FileManager.userCacheDirUrl.appendingPathComponent("Accio/Cache").path
    }
}
