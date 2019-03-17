import Foundation

final class CachedBuilderService {
    private let frameworkCachingService: FrameworkCachingService
    private let carthageBuilderService: CarthageBuilderService

    init(sharedCachePath: String?) {
        self.frameworkCachingService = FrameworkCachingService(sharedCachePath: sharedCachePath)
        self.carthageBuilderService = CarthageBuilderService(frameworkCachingService: frameworkCachingService)
    }

    func frameworkProducts(manifest: Manifest, appTarget: AppTarget, dependencyGraph: DependencyGraph, platform: Platform) throws -> [FrameworkProduct] {
        var frameworkProducts: [FrameworkProduct] = []

        for framework in try appTarget.frameworkDependencies(manifest: manifest, dependencyGraph: dependencyGraph).flattenedDeepFirstOrder() {
            if let cachedFrameworkProduct = try frameworkCachingService.cachedProduct(framework: framework, platform: platform) {
                frameworkProducts.append(cachedFrameworkProduct)
            } else {
                switch try InstallationTypeDetectorService.shared.detectInstallationType(for: framework) {
                case .swiftPackageManager:
                    try XcodeProjectGeneratorService.shared.generateXcodeProject(framework: framework)
                    fallthrough

                case .carthage:
                    let frameworkProduct = try carthageBuilderService.build(framework: framework, platform: platform, alreadyBuiltFrameworkProducts: frameworkProducts)
                    frameworkProducts.append(frameworkProduct)
                }
            }
        }

        return frameworkProducts
    }
}
