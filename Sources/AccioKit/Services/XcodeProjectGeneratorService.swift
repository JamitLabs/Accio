import Foundation
import HandySwift
import PathKit
import xcodeproj

final class XcodeProjectGeneratorService {
    static let shared = XcodeProjectGeneratorService()

    func generateXcodeProject(framework: Framework) throws {
        print("Generating Xcode project at \(framework.generatedXcodeProjectPath) using SwiftPM ...", level: .info)

        let swiftPMBuildUrl: URL = URL(fileURLWithPath: framework.projectDirectory).appendingPathComponent(".build")
        if FileManager.default.fileExists(atPath: swiftPMBuildUrl.path) {
            try bash("rm -rf '\(swiftPMBuildUrl.path)'")
        }

        if FileManager.default.fileExists(atPath: framework.generatedXcodeProjectPath) {
            try bash("rm -rf '\(framework.generatedXcodeProjectPath)'")
        }

        try bash("swift package --package-path '\(framework.projectDirectory)' generate-xcodeproj")
        try createSharedSchemeIfNeeded(framework: framework)
        try setDeploymentTargets(framework: framework)

        print("Generated Xcode project at \(framework.generatedXcodeProjectPath) using SwiftPM.", level: .info)
    }

    /// Swift 4.2 doesn't support specifying the platform deployment versions. This can be removed in Swift 5.
    func setDeploymentTargets(framework: Framework) throws {
        let xcodeProjectPath: String = framework.generatedXcodeProjectPath
        let projectFile: XcodeProj = try XcodeProj(path: Path(xcodeProjectPath))
        let pbxproj: PBXProj = projectFile.pbxproj

        let platformToVersion: [Platform: String] = try self.platformToVersion(framework: framework)

        for targetObject in pbxproj.nativeTargets {
            for buildConfiguration in targetObject.buildConfigurationList!.buildConfigurations {
                for (platform, version) in platformToVersion {
                    buildConfiguration.buildSettings[platform.deploymentTargetBuildSetting] = "\(version)"
                }
            }
        }

        try projectFile.write(path: Path(xcodeProjectPath), override: true)
    }

    func createSharedSchemeIfNeeded(framework: Framework) throws {
        let xcodeProjectPath: String = framework.generatedXcodeProjectPath
        let projectFile: XcodeProj = try XcodeProj(path: Path(xcodeProjectPath))

        if projectFile.sharedData == nil {
            projectFile.sharedData = XCSharedData(schemes: [])
        }

        if projectFile.sharedData!.schemes.isEmpty {
            print("Manually creating shared scheme for generated project to fix issues with SwiftPM ...", level: .verbose)

            let sharedScheme: XCScheme = XCScheme(name: "\(framework.libraryName)-Package", lastUpgradeVersion: "9999", version: "1.3")
            let frameworkBuildableReference = XCScheme.BuildableReference(
                referencedContainer: "container:\(framework.projectName).xcodeproj",
                blueprint: projectFile.pbxproj.nativeTargets.first { $0.name == framework.libraryName }!,
                buildableName: "\(framework.projectName).xcodeproj",
                blueprintName: framework.libraryName
            )
            let frameworkBuildAction = XCScheme.BuildAction.Entry(
                buildableReference: frameworkBuildableReference,
                buildFor: XCScheme.BuildAction.Entry.BuildFor.default
            )
            sharedScheme.buildAction = XCScheme.BuildAction(buildActionEntries: [frameworkBuildAction])

            projectFile.sharedData!.schemes = [sharedScheme]
            try projectFile.write(path: Path(xcodeProjectPath), override: true)
        }
    }

    /// Swift 4.2 doesn't support the `platform` parameter in the Package manifest, thus read it from a comment with this method.
    func platformToVersion(framework: Framework) throws -> [Platform: String] {
        let commentedPlatformsRegex = Regex("// *platforms: \\[([^\n]+)\\]")

        let manifestPath: String = URL(fileURLWithPath: framework.projectDirectory).appendingPathComponent("Package.swift").path
        let manifestContents: String = try String(contentsOfFile: manifestPath)

        var platformToVersion: [Platform: String] = [.iOS: "8.0", .macOS: "10.10", .tvOS: "9.0", .watchOS: "2.0"]

        if let match = commentedPlatformsRegex.firstMatch(in: manifestContents) {
            let capture = match.captures[0]!
            let platformSpecifierComponents: [String] = capture.components(separatedBy: ",").map { $0.stripped() }
            let platformVersionRegex = Regex("\\.(\\w+)\\(\"(\\S+)\"\\)")

            for platformSpecifier in platformSpecifierComponents {
                guard let match = platformVersionRegex.firstMatch(in: platformSpecifier) else {
                    print("Could not read platform specifier '\(platformSpecifier)' – expected format: .<platform>(\"<version>\")", level: .warning)
                    continue
                }

                guard let platform = Platform(rawValue: match.captures[0]!) else {
                    print("Did not recognize platform with name '\(match.captures[0]!)' in '\(platformSpecifier)' – expected one of \(Platform.allCases.map { $0.rawValue })", level: .warning)
                    continue
                }

                platformToVersion[platform] = match.captures[1]!
            }
        }

        return platformToVersion
    }
}
