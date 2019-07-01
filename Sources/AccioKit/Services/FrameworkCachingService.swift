import Foundation
import SwiftCLI

final class FrameworkCachingService {
    private let sharedCachePath: String?

    init(sharedCachePath: String?) {
        self.sharedCachePath = sharedCachePath
    }

    func cachedProduct(framework: Framework, platform: Platform) throws -> FrameworkProduct? {
        let subpath: String = cacheFileSubPath(framework: framework, platform: platform)
        let localCachedFileUrl = URL(fileURLWithPath: Constants.localCachePath).appendingPathComponent(subpath)

        if FileManager.default.fileExists(atPath: localCachedFileUrl.path) {
            print("Found cached build products for \(framework.libraryName) in local cache - skipping build.", level: .info)
            return try frameworkProduct(forCachedFileAt: localCachedFileUrl)
        }

        if let sharedCachePath = sharedCachePath {
            let sharedCacheFileUrl = URL(fileURLWithPath: sharedCachePath).appendingPathComponent(subpath)

            if FileManager.default.fileExists(atPath: sharedCacheFileUrl.path) {
                print("Found cached build products for \(framework.libraryName) in shared cache - skipping build.", level: .info)
                return try frameworkProduct(forCachedFileAt: sharedCacheFileUrl)
            }
        }

        return nil
    }

    func cache(product: FrameworkProduct, framework: Framework, platform: Platform) throws {
        let subpath: String = cacheFileSubPath(framework: framework, platform: platform)

        if
            let sharedCachePath = sharedCachePath,
            FileManager.default.fileExists(atPath: URL(fileURLWithPath: sharedCachePath).deletingLastPathComponent().path)
        {
            try cache(product: product, to: URL(fileURLWithPath: sharedCachePath).appendingPathComponent(subpath))
            print("Saved build products for \(framework.libraryName) in shared cache.", level: .info)
        } else {
            try cache(product: product, to: URL(fileURLWithPath: Constants.localCachePath).appendingPathComponent(subpath))
            print("Saved build products for \(framework.libraryName) in local cache.", level: .info)
        }
    }

    public func frameworkProduct(forCachedFileAt cachedFileUrl: URL) throws -> FrameworkProduct {
        let libraryName: String = cachedFileUrl.pathComponents.suffix(3).first!
        let platformName: String = cachedFileUrl.deletingPathExtension().lastPathComponent
        let commitHash: String = cachedFileUrl.pathComponents.suffix(2).first!

        let frameworkProduct = FrameworkProduct(libraryName: libraryName, platformName: platformName, commitHash: commitHash)

        let subpath: String = cachedFileUrl.deletingPathExtension().pathComponents.suffix(3).joined(separator: "/")
        let unzippingUrl: URL = Constants.temporaryUncachingUrl.appendingPathComponent(subpath)

        try bash("mkdir -p '\(unzippingUrl.path)'")
        try Task.run(bash: "unzip -n -q '\(cachedFileUrl.path)' -d '\(unzippingUrl.path)'")

        let unzippedFrameworkDirPath = unzippingUrl.appendingPathComponent("\(libraryName).framework").path
        let unzippedSymbolsFilePath = unzippingUrl.appendingPathComponent("\(libraryName).framework.dSYM").path

        try bash("mkdir -p '\(frameworkProduct.frameworkDirUrl.deletingLastPathComponent().path)'")

        try Task.run(bash: "cp -R '\(unzippedFrameworkDirPath)' '\(frameworkProduct.frameworkDirPath)'")
        try Task.run(bash: "cp -R '\(unzippedSymbolsFilePath)' '\(frameworkProduct.symbolsFilePath)'")

        try frameworkProduct.cleanupRecursiveFrameworkIfNeeded()

        return frameworkProduct
    }

    private func cacheFileSubPath(framework: Framework, platform: Platform) -> String {
        return "\(Constants.swiftVersion)/\(framework.libraryName)/\(framework.commitHash)/\(platform.rawValue).zip"
    }

    private func cache(product: FrameworkProduct, to targetUrl: URL) throws {
        try bash("mkdir -p '\(targetUrl.deletingLastPathComponent().path)'")

        let previousCurrentDirectoryPath = FileManager.default.currentDirectoryPath
        defer { FileManager.default.changeCurrentDirectoryPath(previousCurrentDirectoryPath) }

        FileManager.default.changeCurrentDirectoryPath(product.frameworkDirUrl.deletingLastPathComponent().path)
        try Task.run(bash: "zip -r -q -y '\(targetUrl.path)' '\(product.frameworkDirUrl.lastPathComponent)' '\(product.symbolsFileUrl.lastPathComponent)'")
    }
}
