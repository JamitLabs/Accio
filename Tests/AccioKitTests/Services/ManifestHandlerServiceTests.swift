@testable import AccioKit
import XCTest

class ManifestCreatorServiceTests: XCTestCase {
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
                        .package(url: "https://github.com/SwiftyBeaver/SwiftyBeaver.git", .upToNextMajor(from: "1.6.2")),
                    ],
                    targets: [
                        .target(
                            name: "TestProject-iOS",
                            dependencies: [
                              "HandySwift",
                              "HandyUIKit",
                              "Imperio",
                              "MungoHealer",
                              "SwiftyBeaver",
                            ],
                            path: "TestProject-iOS"
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

        try! bash("rm -rf \(testResourcesDir.path)")
        try! bash("mkdir \(testResourcesDir.path)")
    }

    func testLoadManifest() {
        resourcesLoaded([manifestResource, xcodeProjectResource, exampleSwiftFile]) {
            try! DependencyResolverService(workingDirectory: testResourcesDir.path).resolveDependencies()
            let dependencyGraph = try! DependencyResolverService(workingDirectory: testResourcesDir.path).dependencyGraph()
            let manifest = try! ManifestHandlerService(workingDirectory: testResourcesDir.path).loadManifest()

            XCTAssertEqual(manifest.name, "TestProject")
            XCTAssertEqual(manifest.targets.count, 1)
            XCTAssertEqual(manifest.targets.first!.name, "TestProject-iOS")

            let foundFrameworks = try! manifest.targets.first!.frameworks(dependencyGraph: dependencyGraph)
            XCTAssertEqual(foundFrameworks.count, 5)

            XCTAssertEqual(foundFrameworks[0].scheme, "HandySwift")
            XCTAssert(foundFrameworks[0].directory.contains("checkouts/HandySwift.git-"))
            XCTAssert(foundFrameworks[0].xcodeProjectPath.contains("HandySwift.xcodeproj"))
            XCTAssertEqual(foundFrameworks[0].commit.count, 40)

            XCTAssertEqual(foundFrameworks[1].scheme, "HandyUIKit")
            XCTAssert(foundFrameworks[1].directory.contains("checkouts/HandyUIKit.git-"))
            XCTAssert(foundFrameworks[1].xcodeProjectPath.contains("HandyUIKit.xcodeproj"))
            XCTAssertEqual(foundFrameworks[1].commit.count, 40)

            XCTAssertEqual(foundFrameworks[2].scheme, "Imperio")
            XCTAssert(foundFrameworks[2].directory.contains("checkouts/Imperio.git-"))
            XCTAssert(foundFrameworks[2].xcodeProjectPath.contains("Imperio.xcodeproj"))
            XCTAssertEqual(foundFrameworks[2].commit.count, 40)

            XCTAssertEqual(foundFrameworks[3].scheme, "MungoHealer")
            XCTAssert(foundFrameworks[3].directory.contains("checkouts/MungoHealer.git-"))
            XCTAssert(foundFrameworks[3].xcodeProjectPath.contains("MungoHealer.xcodeproj"))
            XCTAssertEqual(foundFrameworks[3].commit.count, 40)

            XCTAssertEqual(foundFrameworks[4].scheme, "SwiftyBeaver")
            XCTAssert(foundFrameworks[4].directory.contains("checkouts/SwiftyBeaver.git-"))
            XCTAssert(foundFrameworks[4].xcodeProjectPath.contains("SwiftyBeaver.xcodeproj"))
            XCTAssertEqual(foundFrameworks[4].commit.count, 40)
        }
    }

    func testCreateManifestWithoutExistingManifest() {
        let manifestCreatorService = ManifestHandlerService(workingDirectory: testResourcesDir.path)

        XCTAssertFalse(FileManager.default.fileExists(atPath: manifestResource.url.path))

        try! manifestCreatorService.createManifestFromDefaultTemplateIfNeeded(projectName: "TestProject", targetNames: ["iOS-App", "tvOS-App"])

        XCTAssertTrue(FileManager.default.fileExists(atPath: manifestResource.url.path))
        XCTAssertEqual(
            try! String(contentsOf: manifestResource.url),
            """
                // swift-tools-version:4.2
                import PackageDescription

                let package = Package(
                    name: \"TestProject\",
                    products: [],
                    dependencies: [
                        // add your dependencies here, for example:
                        // .package(url: \"https://github.com/User/Project.git\", .upToNextMajor(from: \"1.0.0\")),
                    ],
                    targets: [
                        .target(
                            name: \"iOS-App\",
                            dependencies: [
                                // add your dependencies scheme names here, for example:
                                // \"Project\",
                            ],
                            path: \"iOS-App\"
                        ),
                        .target(
                            name: \"tvOS-App\",
                            dependencies: [
                                // add your dependencies scheme names here, for example:
                                // \"Project\",
                            ],
                            path: \"tvOS-App\"
                        ),
                    ]
                )

                """
        )
    }

    func testCreateManifestWitExistingManifest() {
        let manifestCreatorService = ManifestHandlerService(workingDirectory: testResourcesDir.path)

        resourcesLoaded([manifestResource]) {
            XCTAssertTrue(FileManager.default.fileExists(atPath: manifestResource.url.path))
            try! manifestCreatorService.createManifestFromDefaultTemplateIfNeeded(projectName: "TestProject", targetNames: ["iOS-App", "tvOS-App"])

            XCTAssertTrue(FileManager.default.fileExists(atPath: manifestResource.url.path))
            XCTAssertEqual(try! String(contentsOf: manifestResource.url), manifestResource.contents)
        }
    }
}
