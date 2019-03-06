import Foundation

enum Platform: String {
    case iOS
    case macOS
    case tvOS
    case watchOS

    static func with(target: String) -> Platform {
        switch target.lowercased() {
        case Platform.iOS.rawValue.lowercased(), "iphone", "ipad", "iphoneos":
            return .iOS

        case Platform.macOS.rawValue.lowercased(), "osx", "mac", "macosx":
            return .macOS

        case Platform.tvOS.rawValue.lowercased(), "appletv", "appletvos":
            return .tvOS

        case Platform.watchOS.rawValue.lowercased(), "applewatch":
            return .watchOS

        default:
            return .iOS
        }
    }
}
