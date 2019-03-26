@testable import AccioKit
import XCTest

class ManifestTests: XCTestCase {
    private let testResourcesDir: URL = FileManager.userCacheDirUrl.appendingPathComponent("AccioTestResources")

    private var manifestResource: Resource {
        return Resource(
            url: testResourcesDir.appendingPathComponent("Package.swift"),
            contents: """
                // swift-tools-version:4.2
                import PackageDescription

                let package = Package(
                    name: "TestProject",
                    products: [],
                    dependencies: [
                        .package(url: "https://github.com/Flinesoft/HandySwift.git", .upToNextMajor(from: "2.8.0")),
                        .package(url: "https://github.com/Flinesoft/HandyUIKit.git", .upToNextMajor(from: "1.9.0")),
                        .package(url: "https://github.com/Flinesoft/Imperio.git", .upToNextMajor(from: "3.0.0")),
                        .package(url: "https://github.com/JamitLabs/MungoHealer.git", .upToNextMajor(from: "0.3.0")),
                        .package(url: "https://github.com/Moya/Moya.git", .revision("43209d6ac45d244d8be08f4cf6df684b96190616")),
                    ],
                    targets: [
                        .target(
                            name: "TestProject-iOS",
                            dependencies: [
                              "HandySwift",
                              "HandyUIKit",
                              "Imperio",
                              "MungoHealer",
                              "Moya",
                            ],
                            path: "TestProject-iOS"
                        ),
                        .testTarget(
                            name: "TestProject-iOS Tests"
                        )
                    ]
                )

                """
        )
    }

    private var xcodeProjectResource: Resource {
        return Resource(
            url: testResourcesDir.appendingPathComponent("TestProject.xcodeproj/project.pbxproj"),
            contents: ResourceData.iOSProjectFileContents
        )
    }

    private var exampleSwiftFile: Resource {
        return Resource(
            url: testResourcesDir.appendingPathComponent("TestProject-iOS/Example.swift"),
            contents: "class Example {}"
        )
    }

    override func setUp() {
        super.setUp()

        try! bash("rm -rf '\(testResourcesDir.path)'")
        try! bash("mkdir '\(testResourcesDir.path)'")
    }

    func testAppTargets() {
        resourcesLoaded([manifestResource, xcodeProjectResource, exampleSwiftFile]) {
            let manifest = try! ManifestHandlerService(workingDirectory: testResourcesDir.path).loadManifest(isDependency: false)

            let appTargets = manifest.appTargets
            XCTAssertEqual(appTargets.count, 1)
            XCTAssertEqual(appTargets[0].projectName, "TestProject")
            XCTAssertEqual(appTargets[0].targetName, "TestProject-iOS")
            XCTAssertEqual(appTargets[0].dependentLibraryNames, ["HandySwift", "HandyUIKit", "Imperio", "MungoHealer", "Moya"])
        }
    }
}
