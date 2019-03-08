@testable import AccioKit
import XCTest

class ManifestCreatorServiceTests: XCTestCase {
    private let testResourcesDir: URL = FileManager.userCacheDirUrl.appendingPathComponent("AccioTestResources")

    private var manifest: Resource {
        return Resource(url: testResourcesDir.appendingPathComponent("Package.swift"), contents: "// any content")
    }

    override func setUp() {
        super.setUp()

        try! bash("rm -rf \(testResourcesDir.path)")
        try! bash("mkdir \(testResourcesDir.path)")
    }

    func testCreateManifestWithoutExistingManifest() {
        let manifestCreatorService = ManifestCreatorService(workingDirectory: testResourcesDir.path)

        XCTAssertFalse(FileManager.default.fileExists(atPath: manifest.url.path))

        try! manifestCreatorService.createManifestFromDefaultTemplateIfNeeded(projectName: "TestProject", targetNames: ["iOS-App", "tvOS-App"])

        XCTAssertTrue(FileManager.default.fileExists(atPath: manifest.url.path))
        XCTAssertEqual(
            try! String(contentsOf: manifest.url),
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
                            ]
                        ),
                        .target(
                            name: \"tvOS-App\",
                            dependencies: [
                                // add your dependencies scheme names here, for example:
                                // \"Project\",
                            ]
                        ),
                    ]
                )

                """
        )
    }

    func testCreateManifestWitExistingManifest() {
        let manifestCreatorService = ManifestCreatorService(workingDirectory: testResourcesDir.path)

        resourcesLoaded([manifest]) {
            XCTAssertTrue(FileManager.default.fileExists(atPath: manifest.url.path))
            try! manifestCreatorService.createManifestFromDefaultTemplateIfNeeded(projectName: "TestProject", targetNames: ["iOS-App", "tvOS-App"])

            XCTAssertTrue(FileManager.default.fileExists(atPath: manifest.url.path))
            XCTAssertEqual(try! String(contentsOf: manifest.url), manifest.contents)
        }
    }
}
