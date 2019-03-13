@testable import AccioKit
import XCTest

class FrameworkCachingServiceTests: XCTestCase {
    private let sharedCachePath: String = FileManager.userCacheDirUrl.appendingPathComponent("AccioTestSharedCache").path

    private let testFramework = Framework(graphDependency: DependencyGraph.Dependency(name: "Example", path: "", dependencies: []))
    private let testFrameworkProduct = FrameworkProduct(
        frameworkDirPath: FileManager.userCacheDirUrl.appendingPathComponent("AccioTestFrameworks/Example.framework").path,
        symbolsFilePath: FileManager.userCacheDirUrl.appendingPathComponent("AccioTestFrameworks/Example.framework.dSYM").path
    )

    override func setUp() {
        super.setUp()

        try! bash("rm -rf \(Constants.localCachePath)")
        try! bash("rm -rf \(sharedCachePath)")

        try! bash("mkdir -p \(FileManager.userCacheDirUrl.appendingPathComponent("AccioTestFrameworks/Example.framework").path)")
        try! bash("touch \(FileManager.userCacheDirUrl.appendingPathComponent("AccioTestFrameworks/Example.framework/Example").path)")
        try! bash("touch \(FileManager.userCacheDirUrl.appendingPathComponent("AccioTestFrameworks/Example.framework.dSYM").path)")
    }

    override func tearDown() {
        super.tearDown()

        try! bash("rm -rf \(Constants.dependenciesPath)")
    }

    func testCachingProductWithoutSharedCachePath() {
        let frameworkCachingService = FrameworkCachingService(sharedCachePath: nil)

        let testFrameworkLocalCacheDir: String = "\(Constants.localCachePath)/\(testFramework.scheme)/\(testFramework.commit)/\(Platform.iOS.rawValue)"
        let testFrameworkSharedCacheDir: String = "\(sharedCachePath)/\(testFramework.scheme)/\(testFramework.commit)/\(Platform.iOS.rawValue)"

        var cachedProduct: FrameworkProduct? = try! frameworkCachingService.cachedProduct(framework: testFramework, platform: .iOS)
        XCTAssertNil(cachedProduct)

        XCTAssert(!FileManager.default.fileExists(atPath: "\(testFrameworkLocalCacheDir)/\(testFrameworkProduct.frameworkDirUrl.lastPathComponent)"))
        XCTAssert(!FileManager.default.fileExists(atPath: "\(testFrameworkLocalCacheDir)/\(testFrameworkProduct.symbolsFileUrl.lastPathComponent)"))

        XCTAssert(!FileManager.default.fileExists(atPath: "\(testFrameworkSharedCacheDir)/\(testFrameworkProduct.frameworkDirUrl.lastPathComponent)"))
        XCTAssert(!FileManager.default.fileExists(atPath: "\(testFrameworkSharedCacheDir)/\(testFrameworkProduct.symbolsFileUrl.lastPathComponent)"))

        try! frameworkCachingService.cache(product: testFrameworkProduct, framework: testFramework, platform: .iOS)

        cachedProduct = try! frameworkCachingService.cachedProduct(framework: testFramework, platform: .iOS)
        XCTAssertNotNil(cachedProduct)

        XCTAssert(FileManager.default.fileExists(atPath: "\(testFrameworkLocalCacheDir)/\(testFrameworkProduct.frameworkDirUrl.lastPathComponent)"))
        XCTAssert(FileManager.default.fileExists(atPath: "\(testFrameworkLocalCacheDir)/\(testFrameworkProduct.symbolsFileUrl.lastPathComponent)"))

        XCTAssert(!FileManager.default.fileExists(atPath: "\(testFrameworkSharedCacheDir)/\(testFrameworkProduct.frameworkDirUrl.lastPathComponent)"))
        XCTAssert(!FileManager.default.fileExists(atPath: "\(testFrameworkSharedCacheDir)/\(testFrameworkProduct.symbolsFileUrl.lastPathComponent)"))
    }

    func testCachingProductWithSharedCachePath() {
        let frameworkCachingService = FrameworkCachingService(sharedCachePath: sharedCachePath)

        let testFrameworkLocalCacheDir: String = "\(Constants.localCachePath)/\(testFramework.scheme)/\(testFramework.commit)/\(Platform.iOS.rawValue)"
        let testFrameworkSharedCacheDir: String = "\(sharedCachePath)/\(testFramework.scheme)/\(testFramework.commit)/\(Platform.iOS.rawValue)"

        var cachedProduct: FrameworkProduct? = try! frameworkCachingService.cachedProduct(framework: testFramework, platform: .iOS)
        XCTAssertNil(cachedProduct)

        XCTAssert(!FileManager.default.fileExists(atPath: "\(testFrameworkLocalCacheDir)/\(testFrameworkProduct.frameworkDirUrl.lastPathComponent)"))
        XCTAssert(!FileManager.default.fileExists(atPath: "\(testFrameworkLocalCacheDir)/\(testFrameworkProduct.symbolsFileUrl.lastPathComponent)"))

        XCTAssert(!FileManager.default.fileExists(atPath: "\(testFrameworkSharedCacheDir)/\(testFrameworkProduct.frameworkDirUrl.lastPathComponent)"))
        XCTAssert(!FileManager.default.fileExists(atPath: "\(testFrameworkSharedCacheDir)/\(testFrameworkProduct.symbolsFileUrl.lastPathComponent)"))

        try! frameworkCachingService.cache(product: testFrameworkProduct, framework: testFramework, platform: .iOS)

        cachedProduct = try! frameworkCachingService.cachedProduct(framework: testFramework, platform: .iOS)
        XCTAssertNotNil(cachedProduct)

        XCTAssert(FileManager.default.fileExists(atPath: "\(testFrameworkLocalCacheDir)/\(testFrameworkProduct.frameworkDirUrl.lastPathComponent)"))
        XCTAssert(FileManager.default.fileExists(atPath: "\(testFrameworkLocalCacheDir)/\(testFrameworkProduct.symbolsFileUrl.lastPathComponent)"))

        XCTAssert(FileManager.default.fileExists(atPath: "\(testFrameworkSharedCacheDir)/\(testFrameworkProduct.frameworkDirUrl.lastPathComponent)"))
        XCTAssert(FileManager.default.fileExists(atPath: "\(testFrameworkSharedCacheDir)/\(testFrameworkProduct.symbolsFileUrl.lastPathComponent)"))
    }
}
