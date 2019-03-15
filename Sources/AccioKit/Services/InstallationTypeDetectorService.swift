import Foundation
import SwiftShell

final class InstallationTypeDetectorService {
    static let shared = InstallationTypeDetectorService()

    func detectInstallationType(for framework: Framework) throws -> InstallationType {
        if !(try framework.sharedSchemePaths().isEmpty) {
            return .carthage
        } else {
            return .swiftPackageManager
        }
    }
}
