import Foundation

enum Constants {
    static let buildPath: String = ".accio"
    static let dependenciesPath: String = "Dependencies"
    static let localCachePath: String = FileManager.applicationSupportDirUrl.appendingPathComponent("Accio/Cache").path
    static let xcodeDependenciesGroup: String = "Dependencies"
    static let copyBuildScript: String = "Accio"
}
