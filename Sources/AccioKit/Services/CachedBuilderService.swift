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

        let frameworks = Set(try appTarget.frameworkDependencies(manifest: manifest, dependencyGraph: dependencyGraph).flattenedDeepFirstOrder())
        for framework in frameworks {
            if let cachedFrameworkProduct = try frameworkCachingService.cachedProduct(framework: framework, platform: platform) {
                frameworkProducts.append(cachedFrameworkProduct)
            } else {
                switch try InstallationTypeDetectorService.shared.detectInstallationType(for: framework) {
                case .swiftPackageManager:
                    try XcodeProjectGeneratorService.shared.generateXcodeProject(framework: framework)
                    let frameworkProduct = try carthageBuilderService.build(
                        framework: framework,
                        platform: platform,
                        alreadyBuiltFrameworkProducts: frameworkProducts
                    )
                    frameworkProducts.append(frameworkProduct)

                case .carthage:
                    try GitResetService.shared.resetGit(atPath: framework.projectDirectory, includeUntrackedFiles: false)
                    let frameworkProduct = try carthageBuilderService.build(
                        framework: framework,
                        platform: platform,
                        alreadyBuiltFrameworkProducts: frameworkProducts
                    )
                    frameworkProducts.append(frameworkProduct)
                }
            }
        }

        return frameworkProducts
    }
}
