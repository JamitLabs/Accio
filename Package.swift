// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "Accio",
    platforms: [.macOS(.v10_12)],
    products: [
        .executable(name: "accio", targets: ["Accio"]),
        .library(name: "AccioKit", type: .dynamic, targets: ["AccioKit"])
    ],
    dependencies: [
        .package(url: "https://github.com/Flinesoft/HandySwift.git", .upToNextMajor(from: "2.8.0")),
        .package(url: "https://github.com/onevcat/Rainbow.git", .upToNextMajor(from: "3.1.4")),
        .package(url: "https://github.com/jakeheis/SwiftCLI.git", .upToNextMajor(from: "5.2.2")),
        .package(url: "https://github.com/kareman/SwiftShell.git", .upToNextMajor(from: "4.1.2")),
        .package(url: "https://github.com/mrylmz/xcodeproj.git", .branch("master")),
    ],
    targets: [
        .target(
            name: "Accio",
            dependencies: ["AccioKit"]
        ),
        .target(
            name: "AccioKit",
            dependencies: [
                "HandySwift",
                "Rainbow",
                "SwiftCLI",
                "SwiftShell",
                "XcodeProj",
            ]
        ),
        .testTarget(
            name: "AccioKitTests",
            dependencies: ["AccioKit", "HandySwift", "XcodeProj"]
        )
    ]
)
