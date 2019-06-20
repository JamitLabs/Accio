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
                        .package(url: "https://github.com/Moya/Moya.git", .upToNextMajor(from: "13.0.1")),
                        .package(url: "https://github.com/Quick/Quick.git", .upToNextMajor(from: "1.0.0")),
                        .package(url: "https://github.com/Quick/Nimble.git", .upToNextMajor(from: "7.0.0")),
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
                            name: "TestProject-iOS Tests",
                            dependencies: [
                                "Quick",
                                "Nimble"
                            ],
                            path: "Tests"
                        ),
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

    private var exampleSwiftTestFile: Resource {
        return Resource(
            url: testResourcesDir.appendingPathComponent("TestProject-iOS Tests/ExampleTests.swift"),
            contents: "import XCTest\n\nclass ExampleTests: XCTestCase {}"
        )
    }

    override func setUp() {
        super.setUp()

        try! bash("rm -rf '\(testResourcesDir.path)'")
        try! bash("mkdir '\(testResourcesDir.path)'")
    }

    func testAppTargets() {
        resourcesLoaded([manifestResource, xcodeProjectResource, exampleSwiftFile, exampleSwiftTestFile]) {
            let manifest = try! ManifestHandlerService(workingDirectory: testResourcesDir.path).loadManifest(isDependency: false)

            let appTargets = try! manifest.appTargets(workingDirectory: testResourcesDir.path)
            XCTAssertEqual(appTargets.count, 2)

            XCTAssertEqual(appTargets[0].projectName, "TestProject")
            XCTAssertEqual(appTargets[0].targetName, "TestProject-iOS")
            XCTAssertEqual(appTargets[0].dependentLibraryNames, ["HandySwift", "HandyUIKit", "Imperio", "MungoHealer", "Moya"])

            XCTAssertEqual(appTargets[1].projectName, "TestProject")
            XCTAssertEqual(appTargets[1].targetName, "TestProject-iOS Tests")
            XCTAssertEqual(appTargets[1].dependentLibraryNames, ["Quick", "Nimble"])
        }
    }
}
