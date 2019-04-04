// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "Demo",
    products: [],
    dependencies: [
        .package(url: "https://github.com/AccioSupport/Alamofire.git", .upToNextMajor(from: "4.8.1")),
        .package(url: "https://github.com/AccioSupport/Bond.git", .upToNextMajor(from: "7.3.3")),
        .package(url: "https://github.com/AccioSupport/Cartography.git", .branch("master")),
        .package(url: "https://github.com/AccioSupport/folding-cell.git", .branch("master")),
        .package(url: "https://github.com/AccioSupport/Hero.git", .upToNextMajor(from: "1.4.0")),
        .package(url: "https://github.com/AccioSupport/Kingfisher.git", .branch("master")),
        .package(url: "https://github.com/AccioSupport/lottie-ios.git", .branch("master")),
        .package(url: "https://github.com/AccioSupport/Material.git", .branch("development")),
        .package(url: "https://github.com/AccioSupport/Moya.git", .upToNextMajor(from: "13.0.0-beta.1")),
        .package(url: "https://github.com/AccioSupport/ReSwift.git", .branch("master")),
        .package(url: "https://github.com/AccioSupport/RxSwift.git", .upToNextMajor(from: "4.4.2")),
        .package(url: "https://github.com/AccioSupport/Siren.git", .branch("master")),
        .package(url: "https://github.com/AccioSupport/socket.io-client-swift.git", .upToNextMajor(from: "15.0.0")),
        .package(url: "https://github.com/AccioSupport/SQLite.swift.git", .branch("master")),
        .package(url: "https://github.com/AccioSupport/Starscream.git", .upToNextMajor(from: "3.1.0")),
        .package(url: "https://github.com/AccioSupport/SwiftDate.git", .upToNextMajor(from: "6.0.1")),
        .package(url: "https://github.com/AccioSupport/SwifterSwift.git", .upToNextMajor(from: "4.6.0")),
        .package(url: "https://github.com/AccioSupport/SwiftMessages.git", .branch("master")),
        .package(url: "https://github.com/AccioSupport/SwiftyStoreKit.git", .branch("master")),
    ],
    targets: [
        .target(
            name: "Demo-iOS",
            dependencies: [
                "Alamofire",
                "Bond",
                "Cartography",
                "FoldingCell",
                "Hero",
                "Kingfisher",
                "Lottie",
                "Material",
                "Moya",
                "ReSwift",
                "RxSwift",
                "Siren",
                "SocketIO",
                "SQLite",
                "Starscream",
                "SwiftDate",
                "SwifterSwift",
                "SwiftMessages",
                "SwiftyStoreKit",
            ],
            path: "Demo-iOS"
        ),
        .target(
            name: "Demo-iOSTests",
            dependencies: [
            ],
            path: "Demo-iOSTests"
        ),
        .target(
            name: "Demo-tvOS",
            dependencies: [
                "Alamofire",
                "Bond",
                "Cartography",
                "Hero",
                "Kingfisher",
                "Lottie",
                "Moya",
                "ReSwift",
                "RxSwift",
                "SocketIO",
                "SQLite",
                "Starscream",
                "SwiftDate",
                "SwifterSwift",
                "SwiftyStoreKit",
            ],
            path: "Demo-tvOS"
        ),
        .target(
            name: "Demo-tvOSTests",
            dependencies: [
            ],
            path: "Demo-tvOSTests"
        ),
        .target(
            name: "Demo-macOS",
            dependencies: [
                "Alamofire",
                "Bond",
                "Cartography",
                "Kingfisher",
                "Lottie",
                "Moya",
                "ReSwift",
                "RxSwift",
                "SocketIO",
                "SQLite",
                "Starscream",
                "SwiftDate",
                "SwifterSwift",
                "SwiftyStoreKit",
            ],
            path: "Demo-macOS"
        ),
        .target(
            name: "Demo-macOSTests",
            dependencies: [
            ],
            path: "Demo-macOSTests"
        ),
    ]
)
