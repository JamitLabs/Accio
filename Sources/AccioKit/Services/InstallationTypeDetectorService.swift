import Foundation

final class InstallationTypeDetectorService {
    static let shared = InstallationTypeDetectorService()

    func detectInstallationType(for framework: Framework) -> InstallationType {
        // TODO: not yet implemented
        return .carthage
    }
}
