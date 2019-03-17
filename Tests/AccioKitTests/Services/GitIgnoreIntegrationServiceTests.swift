@testable import AccioKit
import XCTest

class GitIgnoreIntegrationServiceTests: XCTestCase {
    private let testResourcesDir: URL = FileManager.userCacheDirUrl.appendingPathComponent("AccioTestResources")

    private var gitignore: Resource {
        return Resource(
            url: testResourcesDir.appendingPathComponent(".gitignore"),
            contents: """
                ## Build generated
                build/
                DerivedData/
                """
        )
    }

    override func setUp() {
        super.setUp()

        try! bash("rm -rf '\(testResourcesDir.path)'")
        try! bash("mkdir '\(testResourcesDir.path)'")
    }

    func testAddIgnoreEntriesWithoutGitignore() {
        let gitignoreIntegrationService = GitIgnoreIntegrationService(workingDirectory: testResourcesDir.path)

        XCTAssertFalse(FileManager.default.fileExists(atPath: gitignore.url.path))

        try! gitignoreIntegrationService.addIgnoreEntriesIfNeeded()

        XCTAssertTrue(FileManager.default.fileExists(atPath: gitignore.url.path))
        XCTAssert(try! String(contentsOf: gitignore.url).contains("\n\(Constants.dependenciesPath)/\n"))
        XCTAssert(try! String(contentsOf: gitignore.url).contains("\n\(Constants.buildPath)/\n"))

        XCTAssertFalse(try! String(contentsOf: gitignore.url).hasPrefix("\n"))
        XCTAssertTrue(try! String(contentsOf: gitignore.url).hasSuffix("\n"))
    }

    func testAddIgnoreEntriesWithExistingGitignore() {
        let gitignoreIntegrationService = GitIgnoreIntegrationService(workingDirectory: testResourcesDir.path)

        resourcesLoaded([gitignore]) {
            XCTAssertFalse(try! String(contentsOf: gitignore.url).contains("\n\(Constants.dependenciesPath)/\n"))
            XCTAssertFalse(try! String(contentsOf: gitignore.url).contains("\n\(Constants.buildPath)/\n"))

            try! gitignoreIntegrationService.addIgnoreEntriesIfNeeded()

            XCTAssertTrue(try! String(contentsOf: gitignore.url).contains("\n\(Constants.dependenciesPath)/\n"))
            XCTAssertTrue(try! String(contentsOf: gitignore.url).contains("\n\(Constants.buildPath)/\n"))

            XCTAssertFalse(try! String(contentsOf: gitignore.url).hasPrefix("\n"))
            XCTAssertTrue(try! String(contentsOf: gitignore.url).hasSuffix("\n"))

            let gitignoreContentsAfterFirstExecution = try! String(contentsOf: gitignore.url)

            try! gitignoreIntegrationService.addIgnoreEntriesIfNeeded()
            try! gitignoreIntegrationService.addIgnoreEntriesIfNeeded()

            XCTAssertEqual(try! String(contentsOf: gitignore.url), gitignoreContentsAfterFirstExecution)
        }
    }
}
