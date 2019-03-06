@testable import AccioKit
import XCTest

class ManifestReaderServiceTests: XCTestCase {
    private let testResourcesDir: URL = FileManager.userCacheDirUrl.appendingPathComponent("AccioTestResources")

    private var manifestResource: Resource {
        return Resource(
            url: testResourcesDir.appendingPathComponent("Package.swift"),
            contents: """
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
                        .package(url: "https://github.com/radex/SwiftyUserDefaults.git", .upToNextMajor(from: "4.0.0-beta.1"))
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
                              "SwiftyUserDefaults"
                            ]
                        )
                    ]
                )

                """
        )
    }

    func testReadManifest() {
        resourcesLoaded([manifestResource]) {
            let manifest = try! ManifestReaderService(workingDirectory: testResourcesDir.path).readManifest()

            XCTAssertEqual(manifest.projectName, "App")
            XCTAssertEqual(manifest.frameworksPerTarget.count, 1)
            XCTAssertEqual(manifest.frameworksPerTarget.keys.first, "App")

            let foundFrameworks = manifest.frameworksPerTarget["App"]!
            XCTAssertEqual(foundFrameworks.count, 6)

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

            XCTAssertEqual(foundFrameworks[5].scheme, "SwiftyUserDefaults")
            XCTAssert(foundFrameworks[5].directory.contains("checkouts/SwiftyUserDefaults.git-"))
            XCTAssert(foundFrameworks[5].xcodeProjectPath.contains("SwiftyUserDefaults.xcodeproj"))
            XCTAssertEqual(foundFrameworks[5].commit.count, 40)
        }
    }
}
