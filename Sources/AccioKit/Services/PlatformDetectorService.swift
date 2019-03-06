import Foundation
import xcodeproj
import PathKit

enum PlatformDetectorError: Error {
    case targetNotFound
    case platformNotSpecified
}

final class PlatformDetectorService {
    static let shared = PlatformDetectorService()

    func detectPlatform(xcodeProjectPath: String, scheme: String) throws -> Platform {
        let projectFile = try XcodeProj(path: Path(xcodeProjectPath))
        let rootProject = try projectFile.pbxproj.rootProject()

        guard let target = projectFile.pbxproj.targets(named: scheme).first else {
            print("Could not find any target named '\(scheme)' at Xcode project path '\(xcodeProjectPath)'.", level: .error)
            throw PlatformDetectorError.targetNotFound
        }

        let targetPlatformSpecifier: String? = target.buildConfigurationList?.buildConfigurations.first?.buildSettings["SDKROOT"] as? String
        let projectPlatformSpecifier: String? = rootProject?.buildConfigurationList?.buildConfigurations.first?.buildSettings["SDKROOT"] as? String

        guard let platformSpecifier = targetPlatformSpecifier ?? projectPlatformSpecifier else {
            print("Could not detect platform type from Xcode project at '\(xcodeProjectPath)'.", level: .error)
            throw PlatformDetectorError.platformNotSpecified
        }

        return Platform.with(target: platformSpecifier)
    }
}
