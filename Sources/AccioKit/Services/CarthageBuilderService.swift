import Foundation

final class CarthageBuilderService {
    private let frameworkCachingService: FrameworkCachingService

    init(frameworkCachingService: FrameworkCachingService) {
        self.frameworkCachingService = frameworkCachingService
    }

    func build(framework: Framework, platform: Platform) throws -> FrameworkProduct {
        print("Building scheme \(framework.scheme) with Carthage ...", level: .info)
        try bash("carthage update --project-directory \(framework.directory) --platform \(platform.rawValue)")
        print("Completed building scheme \(framework.scheme) with Carthage.", level: .info)

        let platformBuildDir = "\(framework.directory)/Carthage/Build/\(platform)"

        let frameworkProduct = FrameworkProduct(
            frameworkDirPath: "\(platformBuildDir)/\(framework.scheme).framework",
            symbolsFilePath: "\(platformBuildDir)/\(framework.scheme).dSYM"
        )

        try frameworkCachingService.cache(product: frameworkProduct, framework: framework, platform: platform)
        return frameworkProduct
    }
}
