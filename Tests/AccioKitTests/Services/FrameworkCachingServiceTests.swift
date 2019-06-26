@testable import AccioKit
import XCTest

class FrameworkCachingServiceTests: XCTestCase {
    private let sharedCachePath: String = FileManager.userCacheDirUrl.appendingPathComponent("AccioTestSharedCache").path

    private let testFramework = Framework(projectName: "TestProject", libraryName: "Example", projectDirectory: "", requiredFrameworks: [])
    private let testFrameworkProduct = FrameworkProduct(
        frameworkDirPath: FileManager.userCacheDirUrl.appendingPathComponent("AccioTestFrameworks/Example.framework").path,
        symbolsFilePath: FileManager.userCacheDirUrl.appendingPathComponent("AccioTestFrameworks/Example.framework.dSYM").path,
        commitHash: "abc"
    )

    override func setUp() {
        super.setUp()

        Constants.useTestPaths = true

        try! bash("rm -rf '\(Constants.localCachePath)'")
        try! bash("rm -rf '\(sharedCachePath)'")

        try! bash("mkdir -p '\(FileManager.userCacheDirUrl.appendingPathComponent("AccioTestFrameworks/Example.framework").path)'")
        try! bash("touch '\(FileManager.userCacheDirUrl.appendingPathComponent("AccioTestFrameworks/Example.framework/Example").path)'")
        try! bash("touch '\(FileManager.userCacheDirUrl.appendingPathComponent("AccioTestFrameworks/Example.framework.dSYM").path)'")
    }

    override func tearDown() {
        super.tearDown()

        try! bash("rm -rf '\(Constants.dependenciesPath)'")
    }

    func testCachingProductWithoutSharedCachePath() {
        TestHelper.shared.isStartedByUnitTests = true
        let frameworkCachingService = FrameworkCachingService(sharedCachePath: nil)

        let testFrameworkLocalCacheFilePath: String = "\(Constants.localCachePath)/\(Constants.swiftVersion)/\(testFramework.libraryName)/\(testFramework.commitHash)/\(Platform.iOS.rawValue).zip"
        let testFrameworkSharedCacheFilePath: String = "\(sharedCachePath)/\(Constants.swiftVersion)/\(testFramework.libraryName)/\(testFramework.commitHash)/\(Platform.iOS.rawValue).zip"

        var cachedProduct: FrameworkProduct? = try! frameworkCachingService.cachedProduct(framework: testFramework, platform: .iOS)
        XCTAssertNil(cachedProduct)

        XCTAssert(!FileManager.default.fileExists(atPath: testFrameworkLocalCacheFilePath))
        XCTAssert(!FileManager.default.fileExists(atPath: testFrameworkSharedCacheFilePath))

        try! frameworkCachingService.cache(product: testFrameworkProduct, framework: testFramework, platform: .iOS)

        cachedProduct = try! frameworkCachingService.cachedProduct(framework: testFramework, platform: .iOS)
        XCTAssertNotNil(cachedProduct)

        XCTAssert(cachedProduct!.frameworkDirPath.hasPrefix(Constants.temporaryFrameworksUrl.path))
        XCTAssert(cachedProduct!.symbolsFilePath.hasPrefix(Constants.temporaryFrameworksUrl.path))

        XCTAssert(FileManager.default.fileExists(atPath: cachedProduct!.frameworkDirPath))
        XCTAssert(FileManager.default.fileExists(atPath: cachedProduct!.symbolsFilePath))

        XCTAssert(FileManager.default.fileExists(atPath: testFrameworkLocalCacheFilePath))
        XCTAssert(!FileManager.default.fileExists(atPath: testFrameworkSharedCacheFilePath))
    }

    func testCachingProductWithSharedCachePath() {
        TestHelper.shared.isStartedByUnitTests = true
        let frameworkCachingService = FrameworkCachingService(sharedCachePath: sharedCachePath)

        let testFrameworkLocalCacheFilePath: String = "\(Constants.localCachePath)/\(Constants.swiftVersion)/\(testFramework.libraryName)/\(testFramework.commitHash)/\(Platform.iOS.rawValue).zip"
        let testFrameworkSharedCacheFilePath: String = "\(sharedCachePath)/\(Constants.swiftVersion)/\(testFramework.libraryName)/\(testFramework.commitHash)/\(Platform.iOS.rawValue).zip"

        var cachedProduct: FrameworkProduct? = try! frameworkCachingService.cachedProduct(framework: testFramework, platform: .iOS)
        XCTAssertNil(cachedProduct)

        XCTAssert(!FileManager.default.fileExists(atPath: testFrameworkLocalCacheFilePath))
        XCTAssert(!FileManager.default.fileExists(atPath: testFrameworkSharedCacheFilePath))

        try! frameworkCachingService.cache(product: testFrameworkProduct, framework: testFramework, platform: .iOS)

        cachedProduct = try! frameworkCachingService.cachedProduct(framework: testFramework, platform: .iOS)
        XCTAssertNotNil(cachedProduct)

        XCTAssert(cachedProduct!.frameworkDirPath.hasPrefix(Constants.temporaryFrameworksUrl.path))
        XCTAssert(cachedProduct!.symbolsFilePath.hasPrefix(Constants.temporaryFrameworksUrl.path))

        XCTAssert(FileManager.default.fileExists(atPath: cachedProduct!.frameworkDirPath))
        XCTAssert(FileManager.default.fileExists(atPath: cachedProduct!.symbolsFilePath))

        XCTAssert(!FileManager.default.fileExists(atPath: testFrameworkLocalCacheFilePath))
        XCTAssert(FileManager.default.fileExists(atPath: testFrameworkSharedCacheFilePath))
    }
}
