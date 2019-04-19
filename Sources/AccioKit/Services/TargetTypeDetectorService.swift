import Foundation
import xcodeproj
import PathKit

enum TargetTypeDetectorError: Error {
    case targetNotFound
    case platformNotSpecified
}

final class TargetTypeDetectorService {
    static let shared = TargetTypeDetectorService(workingDirectory: GlobalOptions.workingDirectory.value ?? FileManager.default.currentDirectoryPath)

    private let workingDirectory: String

    init(workingDirectory: String) {
        self.workingDirectory = workingDirectory
    }

    func detectTargetType(ofTarget targetName: String, in projectName: String) throws -> AppTarget.TargetType {
        let xcodeProjectPath = "\(workingDirectory)/\(projectName).xcodeproj"
        let projectFile = try XcodeProj(path: Path(xcodeProjectPath))

        for targetType in [AppTarget.TargetType.app, AppTarget.TargetType.appExtension] {
            if projectFile.pbxproj.fileReferences.contains(where: { $0.path == "\(targetName).\(targetType.wrapperExtension)" }) {
                return targetType
            }
        }

        return targetName.contains("Tests") ? .test : .app // fall back to target name based logic
    }
}
