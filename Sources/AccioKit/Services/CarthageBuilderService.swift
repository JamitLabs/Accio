import Foundation

final class CarthageBuilderService {
    static let shared = CarthageBuilderService()

    func build(framework: Framework, platform: Platform) throws -> FrameworkProduct {
        try bash("carthage update --project-directory \(framework.directory) --platform \(platform.rawValue)")

        let platformBuildDir = "\(framework.directory)/Carthage/Build/\(platform)"

        let frameworkProduct = FrameworkProduct(
            frameworkDirPath: "\(platformBuildDir)/\(framework.scheme).framework",
            symbolsFilePath: "\(platformBuildDir)/\(framework.scheme).dSYM"
        )

        try FrameworkCachingService.shared.cache(product: frameworkProduct, framework: framework, platform: platform)
        return frameworkProduct
    }
}
