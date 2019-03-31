// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "Demo",
    products: [],
    dependencies: [
        .package(url: "https://github.com/AccioSupport/Kingfisher.git", .branch("master")),
        .package(url: "https://github.com/AccioSupport/Moya.git", .upToNextMajor(from: "13.0.0-beta.1")),
        .package(url: "https://github.com/AccioSupport/RxSwift.git", .upToNextMajor(from: "4.4.2")),
    ],
    targets: [
        .target(
            name: "Demo-iOS",
            dependencies: [
                "Kingfisher",
                "Moya",
                "RxSwift"
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
