import Foundation
import SwiftShell

final class InstallationTypeDetectorService {
    static let shared = InstallationTypeDetectorService()

    func detectInstallationType(for framework: Framework) throws -> InstallationType {
        let frameworkRootFilesNames: [String] = try FileManager.default.contentsOfDirectory(atPath: framework.directory)
        let frameworkRootFilePaths: [String] = frameworkRootFilesNames.map { URL(fileURLWithPath: framework.directory).appendingPathComponent($0).path }

        if frameworkRootFilePaths.contains(where: { $0.hasSuffix(".xcodeproj") && !$0.isAliasFile }) {
            return .carthage
        } else {
            return .swiftPackageManager
        }
    }
}
