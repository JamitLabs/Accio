// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "Demo",
    products: [],
    dependencies: [
        .package(url: "https://github.com/AccioSupport/folding-cell.git", .branch("master")),
        .package(url: "https://github.com/AccioSupport/Kingfisher.git", .branch("master")),
        .package(url: "https://github.com/AccioSupport/Moya.git", .upToNextMajor(from: "13.0.0-beta.1")),
        .package(url: "https://github.com/AccioSupport/RxSwift.git", .upToNextMajor(from: "4.4.2")),
        .package(url: "https://github.com/AccioSupport/Siren.git", .branch("master")),
        .package(url: "https://github.com/AccioSupport/socket.io-client-swift.git", .upToNextMajor(from: "15.0.0")),
        .package(url: "https://github.com/AccioSupport/Starscream.git", .upToNextMajor(from: "3.1.0")),
        .package(url: "https://github.com/AccioSupport/SwiftDate.git", .upToNextMajor(from: "6.0.1")),
        .package(url: "https://github.com/AccioSupport/SwifterSwift.git", .upToNextMajor(from: "4.6.0")),
        .package(url: "https://github.com/AccioSupport/SwiftMessages.git", .branch("master")),
    ],
    targets: [
        .target(
            name: "Demo-iOS",
            dependencies: [
                "FoldingCell",
                "Kingfisher",
                "Moya",
                "RxSwift",
                "Siren",
                "SocketIO",
                "Starscream",
                "SwiftDate",
                "SwifterSwift",
                "SwiftMessages",
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
                "Kingfisher",
                "Moya",
                "RxSwift",
                "SocketIO",
                "Starscream",
                "SwiftDate",
                "SwifterSwift",
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
                "Kingfisher",
                "Moya",
                "RxSwift",
                "SocketIO",
                "Starscream",
                "SwiftDate",
                "SwifterSwift",
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
