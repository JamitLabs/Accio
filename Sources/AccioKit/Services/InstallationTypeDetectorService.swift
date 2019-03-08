import Foundation
import SwiftShell

final class InstallationTypeDetectorService {
    static let shared = InstallationTypeDetectorService()

    func detectInstallationType(for framework: Framework) throws -> InstallationType {
        if try FileManager.default.contentsOfDirectory(atPath: framework.directory).contains(where: { $0.hasSuffix(".xcodeproj") }) {
            return .carthage
        } else {
            return .swiftPackageManager
        }
    }
}
