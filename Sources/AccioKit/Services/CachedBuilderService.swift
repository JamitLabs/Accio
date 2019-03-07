import Foundation

final class CachedBuilderService {
    private let frameworkCachingService: FrameworkCachingService
    private let carthageBuilderService: CarthageBuilderService

    init(sharedCachePath: String?) {
        self.frameworkCachingService = FrameworkCachingService(sharedCachePath: sharedCachePath)
        self.carthageBuilderService = CarthageBuilderService(frameworkCachingService: frameworkCachingService)
    }

    func frameworkProductsPerTarget(platform: Platform) throws -> [Target: [FrameworkProduct]] {
        var frameworkProductsPerTarget: [Target: [FrameworkProduct]] = [:]

        let manifest = try ManifestReaderService.shared.readManifest()

        for (target, frameworks) in manifest.frameworksPerTarget {
            var frameworkProducts: [FrameworkProduct] = []

            for framework in frameworks {
                if let cachedFrameworkProduct = try frameworkCachingService.cachedProduct(framework: framework, platform: platform) {
                    frameworkProducts.append(cachedFrameworkProduct)
                } else {
                    switch InstallationTypeDetectorService.shared.detectInstallationType(for: framework) {
                    case .swiftPackageManager:
                        try XcodeProjectGeneratorService.shared.generateXcodeProject(framework: framework)
                        fallthrough

                    case .carthage:
                        let frameworkProduct = try carthageBuilderService.build(framework: framework, platform: platform)
                        frameworkProducts.append(frameworkProduct)
                    }
                }
            }

            frameworkProductsPerTarget[target] = frameworkProducts
        }

        return frameworkProductsPerTarget
    }
}
