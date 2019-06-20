import Foundation
import HandySwift
import PathKit
import XcodeProj

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

        try bash("chmod -R 775 '\(framework.projectDirectory)'")
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

    /// Swift 4.2 doesn't support the `platform` parameter in the Package manifest, thus read it from a comment with this method. Also ensure Swift 5 support.
    func platformToVersion(framework: Framework) throws -> [Platform: String] {
        let platformRegex = try Regex(#"\.(iOS|macOS|tvOS|watchOS)\((?:"|.v)(\d+)[\._]?(\d+)?"?\)"#)

        let manifestPath: String = URL(fileURLWithPath: framework.projectDirectory).appendingPathComponent("Package.swift").path
        let manifestContents: String = try String(contentsOfFile: manifestPath)

        var platformToVersion: [Platform: String] = [.iOS: "8.0", .macOS: "10.10", .tvOS: "9.0", .watchOS: "2.0"]

        for match in platformRegex.matches(in: manifestContents) {
            guard let platform = Platform(rawValue: match.captures[0]!) else { fatalError("Matched unknown platform rawValue.") }

            let majorVersionString = match.captures[1]!
            let minorVersionString = match.captures[2] ?? "0"

            platformToVersion[platform] = "\(majorVersionString).\(minorVersionString)"
        }

        return platformToVersion
    }
}
