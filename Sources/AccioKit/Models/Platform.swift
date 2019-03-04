import Foundation

enum Platform: String {
    case iOS
    case macOS
    case tvOS
    case watchOS

    static func with(target: String) -> Platform {
        switch target.lowercased() {
        case Platform.iOS.rawValue.lowercased(), "iphone", "ipad":
            return .iOS

        case Platform.macOS.rawValue.lowercased(), "osx", "mac":
            return .macOS

        case Platform.tvOS.rawValue.lowercased(), "appletv":
            return .tvOS

        case Platform.watchOS.rawValue.lowercased(), "applewatch":
            return .watchOS

        default:
            return .iOS
        }
    }
}
