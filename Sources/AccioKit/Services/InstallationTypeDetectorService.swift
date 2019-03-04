import Foundation

final class InstallationTypeDetectorService {
    static let shared = InstallationTypeDetectorService()

    func detectInstallationType(for framework: Framework) -> InstallationType {
        // TODO: check if framework has proper Swift Package Manager support (by running swift build?), fall back to Carthage if not
        return .carthage
    }
}
