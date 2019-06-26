import Foundation
import CryptoSwift

final class ResolvedManifestCachingService {
    private let sharedCachePath: String?

    init(sharedCachePath: String?) {
        self.sharedCachePath = sharedCachePath
    }

    func cacheResolvedManifest(at url: URL, with cachedFrameworkProducts: [CachedFrameworkProduct]) throws {
        let resolvedManifestHash = try fileHash(at: url)
        let subpath = cacheFileSubPath(hash: resolvedManifestHash)

        if
            let sharedCachePath = sharedCachePath,
            FileManager.default.fileExists(atPath: URL(fileURLWithPath: sharedCachePath).deletingLastPathComponent().path)
        {
            let sharedCacheFileUrl = URL(fileURLWithPath: sharedCachePath).appendingPathComponent(subpath)
            try bash("mkdir -p '\(sharedCacheFileUrl.deletingLastPathComponent().path)'")

            let data = try JSONEncoder().encode(cachedFrameworkProducts)
            try data.write(to: sharedCacheFileUrl)
            print("Saved resolved manifest in shared cache.", level: .info)
        } else {
            let localCacheFileUrl = URL(fileURLWithPath: Constants.localCachePath).appendingPathComponent(subpath)
            try bash("mkdir -p '\(localCacheFileUrl.deletingLastPathComponent().path)'")

            let data = try JSONEncoder().encode(cachedFrameworkProducts)
            try data.write(to: localCacheFileUrl)
            print("Saved resolved manifest in local cache.", level: .info)
        }
    }

    func cachedFrameworkProducts(forResolvedManifestAt url: URL) throws -> [CachedFrameworkProduct]? {
        guard FileManager.default.fileExists(atPath: url.path) else { return nil }

        let resolvedManifestHash = try fileHash(at: url)
        let subpath = cacheFileSubPath(hash: resolvedManifestHash)
        let localCachedFileUrl = URL(fileURLWithPath: Constants.localCachePath).appendingPathComponent(subpath)

        if FileManager.default.fileExists(atPath: localCachedFileUrl.path) {
            print("Found cached resolved manifest results in local cache - trying to reuse cached build products.", level: .info)
            return try JSONDecoder().decode([CachedFrameworkProduct].self, from: Data(contentsOf: localCachedFileUrl))
        }

        if let sharedCachePath = sharedCachePath {
            let sharedCacheFileUrl = URL(fileURLWithPath: sharedCachePath).appendingPathComponent(subpath)

            if FileManager.default.fileExists(atPath: sharedCacheFileUrl.path) {
                print("Found cached resolved manifest results in shared cache - trying to reuse cached build products.", level: .info)
                return try JSONDecoder().decode([CachedFrameworkProduct].self, from: Data(contentsOf: sharedCacheFileUrl))
            }
        }

        return nil
    }

    private func fileHash(at url: URL) throws -> String {
        return try Data(contentsOf: url).sha1().toHexString()
    }

    private func cacheFileSubPath(hash: String) -> String {
        return "ResolvedManifests/\(hash).json"
    }
}
