import Foundation

final class CachedBuilderService {
    static let shared = CachedBuilderService()

    func frameworkProducts(platform: Platform) throws -> [FrameworkProduct] {
        var frameworkProducts: [FrameworkProduct] = []

        for framework in ManifestReaderService.shared.frameworksToBuild() {
            if let cachedFrameworkProduct = FrameworkCachingService.shared.cachedProduct(framework: framework, platform: platform) {
                frameworkProducts.append(cachedFrameworkProduct)
            } else {
                switch InstallationTypeDetectorService.shared.detectInstallationType(for: framework) {
                case .swiftPackageManager:
                    try XcodeProjectGeneratorService.shared.generateXcodeProject(framework: framework)
                    fallthrough

                case .carthage:
                    let frameworkProduct = try CarthageBuilderService.shared.build(framework: framework, platform: platform)
                    frameworkProducts.append(frameworkProduct)
                }
            }
        }

        return frameworkProducts
    }
}
