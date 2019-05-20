@testable import AccioKit
import XCTest

class XcodeProjectGeneratorServiceTests: XCTestCase {
    private let testResourcesDir: URL = FileManager.userCacheDirUrl.appendingPathComponent("AccioTestResources")

    private var singleLineCommentedManifestResourceWithStringSpecifiers: Resource {
        return Resource(
            url: testResourcesDir.appendingPathComponent("Package.swift"),
            contents: #"// platforms: [.iOS("12.0"), .macOS("10.12"), .tvOS("11.2"), .watchOS("3.0")],"#
        )
    }

    private var multilineManifestResourceWithEnumCaseSpecifiers: Resource {
        return Resource(
            url: testResourcesDir.appendingPathComponent("Package.swift"),
            contents: """
                platforms: [
                    .macOS(.v10_12), .iOS(.v12), .tvOS(.v11_2),
                ],
            """
        )
    }

    override func setUp() {
        super.setUp()

        clean()
    }

    private func clean() {
        try! bash("rm -rf '\(testResourcesDir.path)'")
    }

    func testPlatformToVersionWithSingleLineCommentedStringSpecifiers() {
        let projectGeneratorService = XcodeProjectGeneratorService()
        let framework = Framework(projectName: "X", libraryName: "X", version: nil, projectDirectory: testResourcesDir.path, requiredFrameworks: [])

        resourcesLoaded([singleLineCommentedManifestResourceWithStringSpecifiers]) {
            let platformToVersion: [Platform: String] = try! projectGeneratorService.platformToVersion(framework: framework)

            XCTAssertEqual(platformToVersion[.iOS], "12.0")
            XCTAssertEqual(platformToVersion[.macOS], "10.12")
            XCTAssertEqual(platformToVersion[.tvOS], "11.2")
            XCTAssertEqual(platformToVersion[.watchOS], "3.0")
        }
    }

    func testPlatformToVersionWithMultiLineEnumCaseSpecifiers() {
        let projectGeneratorService = XcodeProjectGeneratorService()
        let framework = Framework(projectName: "X", libraryName: "X", version: nil, projectDirectory: testResourcesDir.path, requiredFrameworks: [])

        resourcesLoaded([multilineManifestResourceWithEnumCaseSpecifiers]) {
            let platformToVersion: [Platform: String] = try! projectGeneratorService.platformToVersion(framework: framework)

            XCTAssertEqual(platformToVersion[.iOS], "12.0")
            XCTAssertEqual(platformToVersion[.macOS], "10.12")
            XCTAssertEqual(platformToVersion[.tvOS], "11.2")
            XCTAssertEqual(platformToVersion[.watchOS], "2.0") // default value for watchOS
        }
    }
}
