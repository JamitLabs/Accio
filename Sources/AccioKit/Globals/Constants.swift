import Foundation

enum Constants {
    static let buildPath: String = ".accio"
    static let dependenciesPath: String = "./Dependencies"
    static let localCachePath: String = FileManager.userCacheDirUrl.appendingPathComponent("Accio").path
}
