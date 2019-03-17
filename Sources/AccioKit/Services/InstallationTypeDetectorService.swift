import Foundation
import SwiftShell

final class InstallationTypeDetectorService {
    static let shared = InstallationTypeDetectorService()

    func detectInstallationType(for framework: Framework) throws -> InstallationType {
        let sharedSchemePaths: [String] = try framework.sharedSchemePaths()
        let librarySchemePaths: [String] = framework.librarySchemePaths(in: sharedSchemePaths)

        if !librarySchemePaths.isEmpty {
            return .carthage
        } else {
            return .swiftPackageManager
        }
    }
}
