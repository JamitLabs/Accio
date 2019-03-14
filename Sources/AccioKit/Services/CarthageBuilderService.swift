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
        print("Building scheme \(framework.libraryName) with Carthage ...", level: .info)

        for requiredFramework in framework.requiredFrameworks {
            let requiredFrameworkProduct = requiredFramework.expectedFrameworkProduct(platform: platform)
            let productsTargetDirectoryUrl = URL(fileURLWithPath: framework.projectDirectory).appendingPathComponent("Carthage/Build/\(platform.rawValue)")

            print("Linking required frameworks build products '\(requiredFrameworkProduct.frameworkDirPath)(.dSYM)' into directory '\(productsTargetDirectoryUrl.path)' ...", level: .verbose)

            try bash("mkdir -p '\(productsTargetDirectoryUrl.path)'")
            try bash("ln -s '\(requiredFrameworkProduct.frameworkDirPath)' '\(productsTargetDirectoryUrl.appendingPathComponent("\(requiredFramework.libraryName).framework").path)'")
            try bash("ln -s '\(requiredFrameworkProduct.symbolsFilePath)' '\(productsTargetDirectoryUrl.appendingPathComponent("\(requiredFramework.libraryName).framework.dSYM").path)'")
        }

        try bash("carthage build --project-directory '\(framework.projectDirectory)' --platform \(platform.rawValue) --no-skip-current")

        let platformBuildDir = "\(framework.projectDirectory)/Carthage/Build/\(platform)"
        let frameworkProduct = FrameworkProduct(
            frameworkDirPath: "\(platformBuildDir)/\(framework.libraryName).framework",
            symbolsFilePath: "\(platformBuildDir)/\(framework.libraryName).framework.dSYM"
        )

        guard FileManager.default.fileExists(atPath: frameworkProduct.frameworkDirPath) && FileManager.default.fileExists(atPath: frameworkProduct.symbolsFilePath) else {
            print("Failed to build products to \(platformBuildDir)/\(framework.libraryName).framework(.dSYM).", level: .error)
            throw CarthageBuilderError.buildProductsMissing
        }

        print("Completed building scheme \(framework.libraryName) with Carthage.", level: .info)
        try frameworkCachingService.cache(product: frameworkProduct, framework: framework, platform: platform)

        return frameworkProduct
    }
}
