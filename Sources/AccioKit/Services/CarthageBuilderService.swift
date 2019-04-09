import Foundation

enum CarthageBuilderError: Error {
    case buildProductsMissing
    case requiredBuildProductsMissing
}

final class CarthageBuilderService {
    private let frameworkCachingService: FrameworkCachingService

    init(frameworkCachingService: FrameworkCachingService) {
        self.frameworkCachingService = frameworkCachingService
    }

    func build(framework: Framework, platform: Platform, alreadyBuiltFrameworkProducts: [FrameworkProduct]) throws -> FrameworkProduct {
        print("Building scheme \(framework.libraryName) with Carthage ...", level: .info)

        try bash("git -C '\(framework.projectDirectory)' reset HEAD --hard --quiet")
        try bash("git -C '\(framework.projectDirectory)' clean -fd --quiet")

        // link already built subdependencies from previous calls of this method
        for requiredFramework in framework.requiredFrameworks.flattenedDeepFirstOrder() {
            guard let requiredFrameworkProduct = alreadyBuiltFrameworkProducts.first(where: { $0.libraryName == requiredFramework.libraryName }) else {
                print("Could not find required framework '\(requiredFramework.libraryName)'s build products in already built frameworks.", level: .error)
                throw CarthageBuilderError.requiredBuildProductsMissing
            }

            let productsTargetDirectoryUrl = URL(fileURLWithPath: framework.projectDirectory).appendingPathComponent("Carthage/Build/\(platform.carthageBuildFolderName)")

            print("Linking required frameworks build products '\(requiredFrameworkProduct.frameworkDirPath)(.dSYM)' into directory '\(productsTargetDirectoryUrl.path)' ...", level: .verbose)

            try bash("mkdir -p '\(productsTargetDirectoryUrl.path)'")
            try bash("ln -f -s '\(requiredFrameworkProduct.frameworkDirPath)' '\(productsTargetDirectoryUrl.path)'")
            try bash("ln -f -s '\(requiredFrameworkProduct.symbolsFilePath)' '\(productsTargetDirectoryUrl.path)'")
        }

        try XcodeProjectSchemeHandlerService.shared.removeUnnecessarySharedSchemes(from: framework, platform: platform)
        try bash("/usr/local/bin/carthage build --project-directory '\(framework.projectDirectory)' --platform \(platform.rawValue) --no-skip-current --no-use-binaries")

        let frameworkProduct = FrameworkProduct(libraryName: framework.libraryName, platformName: platform.rawValue)
        let platformBuildDir = "\(framework.projectDirectory)/Carthage/Build/\(platform.carthageBuildFolderName)"

        try bash("mkdir -p '\(frameworkProduct.frameworkDirUrl.deletingLastPathComponent().path)'")
        try bash("cp -R '\(platformBuildDir)/\(framework.libraryName).framework' '\(frameworkProduct.frameworkDirPath)'")
        try bash("cp -R '\(platformBuildDir)/\(framework.libraryName).framework.dSYM' '\(frameworkProduct.symbolsFilePath)'")

        // revert any changes to prevent issues when removing checked out dependency
        try bash("rm -rf '\(framework.projectDirectory)/Carthage/Build'")
        try bash("git -C '\(framework.projectDirectory)' reset HEAD --hard --quiet")
        try bash("git -C '\(framework.projectDirectory)' clean -fd --quiet")

        guard FileManager.default.fileExists(atPath: frameworkProduct.frameworkDirPath) && FileManager.default.fileExists(atPath: frameworkProduct.symbolsFilePath) else {
            print("Failed to build products to \(platformBuildDir)/\(framework.libraryName).framework(.dSYM).", level: .error)
            throw CarthageBuilderError.buildProductsMissing
        }

        try frameworkProduct.cleanupRecursiveFrameworkIfNeeded()

        print("Completed building scheme \(framework.libraryName) with Carthage.", level: .info)
        try frameworkCachingService.cache(product: frameworkProduct, framework: framework, platform: platform)

        return frameworkProduct
    }
}
