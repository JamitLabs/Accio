import Foundation

final class PlatformDetectorService {
    static let shared = PlatformDetectorService()

    func detectPlatform(xcodeProjectPath: String, scheme: String) -> Platform {
        // TODO: not yet implemented
        return .iOS
    }
}
