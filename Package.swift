// swift-tools-version:4.2

import PackageDescription

let package = Package(
    name: "Accio",
    products: [
        .executable(name: "accio", targets: ["Accio"]),
        .library(name: "AccioKit", type: .dynamic, targets: ["AccioKit"])
    ],
    dependencies: [
        .package(url: "https://github.com/Flinesoft/HandySwift.git", .upToNextMajor(from: "2.8.0")),
        .package(url: "https://github.com/jakeheis/SwiftCLI.git", .upToNextMajor(from: "5.2.2"))
    ],
    targets: [
        .target(
            name: "Accio",
            dependencies: ["AccioKit"]
        ),
        .target(
            name: "AccioKit",
            dependencies: ["HandySwift", "SwiftCLI"]
        ),
        .testTarget(
            name: "AccioKitTests",
            dependencies: ["AccioKit", "HandySwift"]
        )
    ]
)
