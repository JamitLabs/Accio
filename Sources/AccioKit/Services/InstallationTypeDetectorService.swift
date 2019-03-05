import Foundation

final class InstallationTypeDetectorService {
    static let shared = InstallationTypeDetectorService()

    func detectInstallationType(for framework: Framework) -> InstallationType {
        do {
            try bash("swift build --package-path \(framework.directory)")
            return .swiftPackageManager
        } catch {
            return .carthage
        }
    }
}
