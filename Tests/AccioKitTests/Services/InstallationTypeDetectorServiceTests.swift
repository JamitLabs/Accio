@testable import AccioKit
import XCTest

class InstallationTypeDetectorServiceTests: XCTestCase {
    private let manifestContents: String = """
        // swift-tools-version:4.2
        import PackageDescription

        let package = Package(
            name: "App",
            products: [],
            dependencies: [
                .package(url: "https://github.com/Flinesoft/HandySwift.git", .upToNextMajor(from: "2.8.0")),
                .package(url: "https://github.com/Flinesoft/HandyUIKit.git", .upToNextMajor(from: "1.9.0")),
                .package(url: "https://github.com/Flinesoft/Imperio.git", .upToNextMajor(from: "3.0.0")),
                .package(url: "https://github.com/JamitLabs/MungoHealer.git", .upToNextMajor(from: "0.3.0")),
                .package(url: "https://github.com/SwiftyBeaver/SwiftyBeaver.git", .upToNextMajor(from: "1.6.2")),
            ],
            targets: [
                .target(
                    name: "App",
                    dependencies: [
                      "HandySwift",
                      "HandyUIKit",
                      "Imperio",
                      "MungoHealer",
                      "SwiftyBeaver",
                    ]
                )
            ]
        )

        """

    let testResourcesDir = FileManager.userCacheDirUrl.appendingPathComponent("AccioTestResources")

    override func setUp() {
        super.setUp()

        try! bash("mkdir -p \(testResourcesDir.path)")

        FileManager.default.createFile(atPath: testResourcesDir.appendingPathComponent("Package.swift").path, contents: manifestContents.data(using: .utf8))
        try! DependencyResolverService(workingDirectory: testResourcesDir.path).resolveDependencies()
    }

    func testDetectInstallationTypeTests() {
        let expectedTypes: [String: InstallationType] = [
            "HandySwift": InstallationType.swiftPackageManager,
            "HandyUIKit": InstallationType.carthage,
            "Imperio": InstallationType.carthage,
            "MungoHealer": InstallationType.swiftPackageManager,
            "SwiftyBeaver": InstallationType.swiftPackageManager
        ]

        let checkoutsDir = testResourcesDir.appendingPathComponent(".accio/checkouts")

        for (frameworkName, expectedInstallationType) in expectedTypes {
            let frameworkDirName = try! FileManager.default.contentsOfDirectory(atPath: checkoutsDir.path).first { $0.hasPrefix(frameworkName) }!
            let frameworkDir = checkoutsDir.appendingPathComponent(frameworkDirName)
            let xcodeProjectName = try! FileManager.default.contentsOfDirectory(atPath: frameworkDir.path).first { $0.hasSuffix(".xcodeproj") }!

            let framework = Framework(
                commit: "aaa",
                directory: frameworkDir.path,
                xcodeProjectPath: frameworkDir.appendingPathComponent(xcodeProjectName).path,
                scheme: frameworkName
            )

            let installationType = InstallationTypeDetectorService.shared.detectInstallationType(for: framework)
            XCTAssertEqual(installationType, expectedInstallationType, "Expected \(frameworkName) to be of type \(expectedInstallationType).")
        }
    }
}
