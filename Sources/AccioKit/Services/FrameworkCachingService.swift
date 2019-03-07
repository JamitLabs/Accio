import Foundation

final class FrameworkCachingService {
    private let sharedCachePath: String?

    init(sharedCachePath: String?) {
        self.sharedCachePath = sharedCachePath
    }

    func cachedProduct(framework: Framework, platform: Platform) throws -> FrameworkProduct? {
        let subpath = "\(framework.scheme)/\(framework.commit)/\(platform.rawValue)"
        let localCacheDir = URL(fileURLWithPath: Constants.localCachePath).appendingPathComponent(subpath)

        let productFrameworkDir = "\(framework.scheme).framework"
        let productSymbolsFile = "\(framework.scheme).framework.dSYM"

        let localCachedFrameworkDir = "\(localCacheDir.appendingPathComponent(productFrameworkDir).path)"
        let localCachedSymbolsFile = "\(localCacheDir.appendingPathComponent(productSymbolsFile).path)"

        if FileManager.default.fileExists(atPath: localCachedFrameworkDir) && FileManager.default.fileExists(atPath: localCachedSymbolsFile) {
            return FrameworkProduct(frameworkDirPath: localCachedFrameworkDir, symbolsFilePath: localCachedSymbolsFile)
        }

        if let sharedCachePath = sharedCachePath {
            let sharedCacheDir = URL(fileURLWithPath: sharedCachePath).appendingPathComponent(subpath)

            let sharedCachedFrameworkDir = "\(sharedCacheDir.appendingPathComponent(productFrameworkDir).path)"
            let sharedCachedSymbolsFile = "\(sharedCacheDir.appendingPathComponent(productSymbolsFile).path)"

            if FileManager.default.fileExists(atPath: sharedCachedFrameworkDir) && FileManager.default.fileExists(atPath: sharedCachedSymbolsFile) {
                return FrameworkProduct(frameworkDirPath: sharedCachedFrameworkDir, symbolsFilePath: sharedCachedSymbolsFile)
            }
        }

        return nil
    }

    func cache(product: FrameworkProduct, framework: Framework, platform: Platform) throws {
        let subpath = "\(framework.scheme)/\(framework.commit)/\(platform.rawValue)"
        let localCacheDir = URL(fileURLWithPath: Constants.localCachePath).appendingPathComponent(subpath)

        try bash("mkdir -p \(localCacheDir.path)")

        try bash("cp -R \(product.frameworkDirPath) \(localCacheDir.appendingPathComponent(product.frameworkDirUrl.lastPathComponent).path)")
        try bash("cp -R \(product.symbolsFilePath) \(localCacheDir.appendingPathComponent(product.symbolsFileUrl.lastPathComponent).path)")

        if let sharedCachePath = sharedCachePath {
            let sharedCacheDir = URL(fileURLWithPath: sharedCachePath).appendingPathComponent(subpath)

            try bash("mkdir -p \(sharedCacheDir.path)")

            try bash("cp -R \(product.frameworkDirPath) \(sharedCacheDir.appendingPathComponent(product.frameworkDirUrl.lastPathComponent).path)")
            try bash("cp -R \(product.symbolsFilePath) \(sharedCacheDir.appendingPathComponent(product.symbolsFileUrl.lastPathComponent).path)")
        }
    }
}
