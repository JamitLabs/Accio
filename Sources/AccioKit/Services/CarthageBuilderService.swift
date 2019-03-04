import Foundation

final class CarthageBuilderService {
    static let shared = CarthageBuilderService()

    func build(framework: Framework, platform: Platform) throws -> FrameworkProduct {
        try bash("carthage update --project-directory \(framework.directory) --platform \(platform.rawValue)")

        let platformBuildDir = "\(framework.directory)/Carthage/Build/\(platform)"

        return FrameworkProduct(
            frameworkDirPath: "\(platformBuildDir)/\(framework.scheme).framework",
            symbolsFilePath: "\(platformBuildDir)/\(framework.scheme).dSYM"
        )
    }
}
