@testable import AccioKit
import CryptoSwift
import XCTest

class ResolvedManifestCachingServiceTests: XCTestCase {
    private let testResourcesDir: URL = FileManager.userCacheDirUrl.appendingPathComponent("AccioTestResources")

    private var cachedResolvedManifestFileUrl: URL {
        Constants.useTestPaths = true
        let hash: String = resolvedManifestResource.contents.sha1()
        return URL(fileURLWithPath: Constants.localCachePath).appendingPathComponent("ResolvedManifests/\(hash).json")
    }

    private var resolvedManifestResource: Resource {
        return Resource(
            url: testResourcesDir.appendingPathComponent("Package.resolved"),
            contents: """
                {
                  "object": {
                    "pins": [
                      {
                        "package": "HandySwift",
                        "repositoryURL": "https://github.com/Flinesoft/HandySwift.git",
                        "state": {
                          "branch": null,
                          "revision": "f736ec0ab264269cd4df91d6a685b4c78292cd76",
                          "version": "2.8.0"
                        }
                      },
                      {
                        "package": "HandyUIKit",
                        "repositoryURL": "https://github.com/Flinesoft/HandyUIKit.git",
                        "state": {
                          "branch": null,
                          "revision": "9b56780efbc48dd372647729b9750b94b6c47561",
                          "version": "1.9.1"
                        }
                      },
                      {
                        "package": "Imperio",
                        "repositoryURL": "https://github.com/Flinesoft/Imperio.git",
                        "state": {
                          "branch": null,
                          "revision": "238b9bc7de239d3e99a03ba94157d49a4ecd8b61",
                          "version": "3.0.2"
                        }
                      },
                      {
                        "package": "MungoHealer",
                        "repositoryURL": "https://github.com/JamitLabs/MungoHealer.git",
                        "state": {
                          "branch": null,
                          "revision": "132e5e454298958f60ca6f1f34c733bc41f299e0",
                          "version": "0.3.2"
                        }
                      },
                      {
                        "package": "SwiftyBeaver",
                        "repositoryURL": "https://github.com/SwiftyBeaver/SwiftyBeaver.git",
                        "state": {
                          "branch": null,
                          "revision": "ad66cc41c5d8acbd63d9dcdc9d3609f152e08ed1",
                          "version": "1.7.0"
                        }
                      }
                    ]
                  },
                  "version": 1
                }

                """
        )
    }

    override func setUp() {
        super.setUp()

        Constants.useTestPaths = true

        try! bash("rm -rf '\(testResourcesDir.path)'")
        try! bash("mkdir '\(testResourcesDir.path)'")

        try! bash("rm -rf '\(Constants.localCachePath)'")
        try! bash("mkdir '\(Constants.localCachePath)'")
    }

    func testCacheResolvedManifest() {
        let checkCachedResolvedManifestExistence: () -> Bool = {
            return FileManager.default.fileExists(atPath: self.cachedResolvedManifestFileUrl.path)
        }

        resourcesLoaded([resolvedManifestResource]) {
            XCTAssertFalse(checkCachedResolvedManifestExistence())

            try! ResolvedManifestCachingService(sharedCachePath: nil).cacheResolvedManifest(
                at: resolvedManifestResource.url,
                with: []
            )

            XCTAssertTrue(checkCachedResolvedManifestExistence())
        }
    }
}
