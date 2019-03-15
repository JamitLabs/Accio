import Foundation
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
                    buildConfiguration.buildSettings[platform.deploymentTargetBuildSetting] = "\"\(version)\""
                }
            }
        }

        try projectFile.write(path: Path(xcodeProjectPath), override: true)
    }

    /// Swift 4.2 doesn't support the `platform` parameter in the Package manifest, thus read it from a comment with this method.
    func platformToVersion(framework: Framework) throws -> [Platform: String] {
        return [.iOS: "8.0", .macOS: "10.10", .tvOS: "9.0", .watchOS: "2.0"] // TODO: not yet implemented, read from comment in Package.swift file
    }
}
