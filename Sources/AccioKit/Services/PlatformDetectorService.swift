import Foundation

final class PlatformDetectorService {
    static let shared = PlatformDetectorService()

    func detectPlatform(xcodeProjectPath: String, scheme: String) -> Platform {
        // TODO: read the Xcode Project file and detect what platform the App target has specified
        return .iOS
    }
}
