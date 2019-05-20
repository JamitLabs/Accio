import Foundation
import XcodeProj
import PathKit

enum PlatformDetectorError: Error {
    case targetNotFound
    case platformNotSpecified
}

final class PlatformDetectorService {
    static let shared = PlatformDetectorService(workingDirectory: GlobalOptions.workingDirectory.value ?? FileManager.default.currentDirectoryPath)

    private let workingDirectory: String

    init(workingDirectory: String) {
        self.workingDirectory = workingDirectory
    }

    func detectPlatform(of appTarget: AppTarget) throws -> Platform {
        if CocoaPodsIntegratorService.matches(appTarget) {
            // The reserved CocoaPods target name always has iOS platform
            return .iOS
        }

        let xcodeProjectPath = "\(workingDirectory)/\(appTarget.projectName).xcodeproj"
        let projectFile = try XcodeProj(path: Path(xcodeProjectPath))
        let rootProject = try projectFile.pbxproj.rootProject()

        guard let targetObject = projectFile.pbxproj.targets(named: appTarget.targetName).first else {
            print("Could not find any target named '\(appTarget.targetName)' at Xcode project path '\(xcodeProjectPath)'.", level: .error)
            throw PlatformDetectorError.targetNotFound
        }

        let targetPlatformSpecifier: String? = targetObject.buildConfigurationList?.buildConfigurations.first?.buildSettings["SDKROOT"] as? String
        let projectPlatformSpecifier: String? = rootProject?.buildConfigurationList?.buildConfigurations.first?.buildSettings["SDKROOT"] as? String

        guard let platformSpecifier = targetPlatformSpecifier ?? projectPlatformSpecifier else {
            print("Could not detect platform type from Xcode project at '\(xcodeProjectPath)'.", level: .error)
            throw PlatformDetectorError.platformNotSpecified
        }

        return Platform.with(target: platformSpecifier)
    }
}
