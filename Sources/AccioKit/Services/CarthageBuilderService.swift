import Foundation

enum CarthageBuilderError: Error {
    case buildProductsMissing
}

final class CarthageBuilderService {
    private let frameworkCachingService: FrameworkCachingService

    init(frameworkCachingService: FrameworkCachingService) {
        self.frameworkCachingService = frameworkCachingService
    }

    func build(framework: Framework, platform: Platform) throws -> FrameworkProduct {
        print("Building scheme \(framework.scheme) with Carthage ...", level: .info)
        try bash("carthage build --project-directory \(framework.directory) --platform \(platform.rawValue) --no-skip-current")

        let platformBuildDir = "\(framework.directory)/Carthage/Build/\(platform)"
        let frameworkProduct = FrameworkProduct(
            frameworkDirPath: "\(platformBuildDir)/\(framework.scheme).framework",
            symbolsFilePath: "\(platformBuildDir)/\(framework.scheme).framework.dSYM"
        )

        guard FileManager.default.fileExists(atPath: frameworkProduct.frameworkDirPath) && FileManager.default.fileExists(atPath: frameworkProduct.symbolsFilePath) else {
            print("Failed to build products to \(platformBuildDir)/\(framework.scheme)/.framework(.dSYM).", level: .error)
            throw CarthageBuilderError.buildProductsMissing
        }

        print("Completed building scheme \(framework.scheme) with Carthage.", level: .info)
        try frameworkCachingService.cache(product: frameworkProduct, framework: framework, platform: platform)

        return frameworkProduct
    }
}
