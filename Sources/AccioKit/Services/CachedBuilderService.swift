import Foundation

final class CachedBuilderService {
    private let frameworkCachingService: FrameworkCachingService
    private let carthageBuilderService: CarthageBuilderService

    init(sharedCachePath: String?) {
        frameworkCachingService = FrameworkCachingService(sharedCachePath: sharedCachePath)
        carthageBuilderService = CarthageBuilderService(frameworkCachingService: frameworkCachingService)
    }

    func frameworkProducts(
        manifest: Manifest,
        appTarget: AppTarget,
        dependencyGraph: DependencyGraph,
        platform: Platform,
        swiftVersion: String
    ) throws -> [FrameworkProduct] {
        var frameworkProducts: [FrameworkProduct] = []

        let frameworks = try appTarget.frameworkDependencies(manifest: manifest, dependencyGraph: dependencyGraph).flattenedDeepFirstOrder()
        let frameworksWithoutDuplicates: [Framework] = frameworks.reduce(into: []) { result, framework in
            if !result.contains(framework) { result.append(framework) }
        }

        for framework in frameworksWithoutDuplicates {
            if
                let cachedFrameworkProduct = try frameworkCachingService.cachedProduct(
                framework: framework,
                platform: platform,
                swiftVersion: swiftVersion
            ) {
                frameworkProducts.append(cachedFrameworkProduct)
            } else {
                switch try InstallationTypeDetectorService.shared.detectInstallationType(for: framework) {
                case .swiftPackageManager:
                    try XcodeProjectGeneratorService.shared.generateXcodeProject(framework: framework)
                    let frameworkProduct = try carthageBuilderService.build(
                        framework: framework,
                        platform: platform,
                        swiftVersion: swiftVersion,
                        alreadyBuiltFrameworkProducts: frameworkProducts
                    )
                    frameworkProducts.append(frameworkProduct)

                case .carthage:
                    try GitResetService.shared.resetGit(atPath: framework.projectDirectory, includeUntrackedFiles: false)
                    let frameworkProduct = try carthageBuilderService.build(
                        framework: framework,
                        platform: platform,
                        swiftVersion: swiftVersion,
                        alreadyBuiltFrameworkProducts: frameworkProducts
                    )
                    frameworkProducts.append(frameworkProduct)
                }
            }
        }

        return frameworkProducts
    }
}
