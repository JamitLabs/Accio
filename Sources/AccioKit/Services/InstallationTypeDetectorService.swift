import Foundation
import SwiftShell

final class InstallationTypeDetectorService {
    static let shared = InstallationTypeDetectorService()

    func detectInstallationType(for framework: Framework) throws -> InstallationType {
        if try framework.containsXcodeProjectWithLibraryScheme() {
            return .carthage
        } else {
            return .swiftPackageManager
        }
    }
}
