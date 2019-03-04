import Foundation

final class FrameworkCachingService {
    static let shared = FrameworkCachingService()

    func cachedProduct(framework: Framework, platform: Platform) -> FrameworkProduct? {
        // TODO: check if a cached product is already available for platform at exact commit of framework
        return nil
    }

    func cache(product: FrameworkProduct, framework: Framework, platform: Platform) throws {
        // TODO: add build product to cache
    }
}
