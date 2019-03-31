// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "Demo",
    products: [],
    dependencies: [
        .package(url: "https://github.com/AccioSupport/Moya.git", .branch("development")),
    ],
    targets: [
        .target(
            name: "Demo-iOS",
            dependencies: [
                "Moya",
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
                "Moya",
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
                "Moya",
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
