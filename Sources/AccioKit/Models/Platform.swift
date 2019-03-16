import Foundation

enum Platform: String, CaseIterable {
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

    var deploymentTargetBuildSetting: String {
        switch self {
        case .iOS:
            return "IPHONEOS_DEPLOYMENT_TARGET"

        case .macOS:
            return "MACOSX_DEPLOYMENT_TARGET"

        case .tvOS:
            return "TVOS_DEPLOYMENT_TARGET"

        case .watchOS:
            return "WATCHOS_DEPLOYMENT_TARGET"
        }
    }
}
