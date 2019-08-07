@testable import AccioKit
import XCTest

class ManifestCommentsHandlerServiceTests: XCTestCase {
    private let testResourcesDir: URL = FileManager.userCacheDirUrl.appendingPathComponent("AccioTestResources")
    private let possibleProductKeys = ["product-type", "integration-type"]
    private let possibleIntegrationValues = ["default", "source", "cocoapods"]
    private let manifestResourceTopContent = """
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
    """

    private var manifestResourceWithoutComments: Resource {
        return Resource(
            url: testResourcesDir.appendingPathComponent("Package.swift"),
            contents: """
                \(manifestResourceTopContent)
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

    private var manifestResourceWithEmptyComment: Resource {
        return Resource(
            url: testResourcesDir.appendingPathComponent("Package.swift"),
            contents: """
                \(manifestResourceTopContent)
                    targets: [
                        .target(
                            name: "TestProject-iOS",
                            dependencies: [
                              "HandySwift",
                              "HandyUIKit",
                              "Imperio",
                              // accio
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

    private var manifestResourceWithUnknownKey: Resource {
        return Resource(
            url: testResourcesDir.appendingPathComponent("Package.swift"),
            contents: """
                \(manifestResourceTopContent)
                    targets: [
                        .target(
                            name: "TestProject-iOS",
                            dependencies: [
                              "HandySwift",
                              "HandyUIKit",
                              "Imperio",
                              // accio unknown-key
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

    private var manifestResourceWithInvalidValue: Resource {
        return Resource(
            url: testResourcesDir.appendingPathComponent("Package.swift"),
            contents: """
                \(manifestResourceTopContent)
                    targets: [
                        .target(
                            name: "TestProject-iOS",
                            dependencies: [
                              "HandySwift",
                              "HandyUIKit",
                              "Imperio",
                              // accio integration-type:invalid-value
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

    private var manifestResourceWithSameKeyMultipleTimesInTheSameComment: Resource {
        return Resource(
            url: testResourcesDir.appendingPathComponent("Package.swift"),
            contents: """
                \(manifestResourceTopContent)
                    targets: [
                        .target(
                            name: "TestProject-iOS",
                            dependencies: [
                              // accio product-type:static-framework product-type:dynamic-framework
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

    private var manifestResourceWithValidComments: Resource {
        return Resource(
            url: testResourcesDir.appendingPathComponent("Package.swift"),
            contents: """
                \(manifestResourceTopContent)
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
                            // defaultLinkage: .static,
                            // customLinkage: [.dynamic: ["SwiftyBeaver", "SwiftyUserDefaults"]],
                            // defaultIntegration: .binary,
                            // customIntegration: [.binary: ["HandySwift", "MungoHealer"], .cocoapods: ["HandyUIKit"]],
                        )
                    ]
                )

                """
        )
    }

    override func setUp() {
        super.setUp()

        try! bash("rm -rf '\(testResourcesDir.path)'")
        try! bash("mkdir '\(testResourcesDir.path)'")
    }

    func testWithoutComments() {
        resourcesLoaded([manifestResourceWithoutComments]) {
            let sut = ManifestCommentsHandlerService(workingDirectory: testResourcesDir.path)
            let manifestComments = try! sut.manifestComments()
            XCTAssertEqual(manifestComments, [])

            XCTAssertEqual(try! sut.additionalConfiguration(for: "HandySwift"), .default)
            XCTAssertEqual(try! sut.additionalConfiguration(for: "HandyUIKit"), .default)
            XCTAssertEqual(try! sut.additionalConfiguration(for: "Imperio"), .default)
            XCTAssertEqual(try! sut.additionalConfiguration(for: "MungoHealer"), .default)
            XCTAssertEqual(try! sut.additionalConfiguration(for: "SwiftyBeaver"), .default)
        }
    }

    func testWithEmptyComment() {
        resourcesLoaded([manifestResourceWithEmptyComment]) {
            let expectedError = ManifestCommentsHandlerError.commentWithoutKnownKeys(
                comment: "// accio",
                possibleKeys: possibleProductKeys
            )
            do {
                _ = try ManifestCommentsHandlerService(workingDirectory: testResourcesDir.path).manifestComments()
                XCTFail("Function was expected to throw")
            } catch {
                XCTAssertEqual(error as? ManifestCommentsHandlerError, expectedError)
            }
        }
    }

    func testWithUnknownKey() {
        resourcesLoaded([manifestResourceWithUnknownKey]) {
            let expectedError = ManifestCommentsHandlerError.commentWithoutKnownKeys(
                comment: "// accio unknown-key",
                possibleKeys: possibleProductKeys
            )
            do {
                _ = try ManifestCommentsHandlerService(workingDirectory: testResourcesDir.path).manifestComments()
                XCTFail("Function was expected to throw")
            } catch {
                XCTAssertEqual(error as? ManifestCommentsHandlerError, expectedError)
            }
        }
    }

    func testWithInvalidValue() {
        resourcesLoaded([manifestResourceWithInvalidValue]) {
            let expectedError = ManifestCommentsHandlerError.invalidValue(
                comment: "// accio integration-type:invalid-value",
                key: .integrationType,
                value: "invalid-value",
                possibleValues: possibleIntegrationValues
            )
            do {
                _ = try ManifestCommentsHandlerService(workingDirectory: testResourcesDir.path).manifestComments()
                XCTFail("Function was expected to throw")
            } catch {
                XCTAssertEqual(error as? ManifestCommentsHandlerError, expectedError)
            }
        }
    }

    func testWithSameKeyMultipleTimesInTheSameComment() {
        resourcesLoaded([manifestResourceWithSameKeyMultipleTimesInTheSameComment]) {
            let expectedError = ManifestCommentsHandlerError.sameKeyAppearsMoreThanOnceInTheSameComment(
                comment: "// accio product-type:static-framework product-type:dynamic-framework",
                count: 2
            )
            do {
                _ = try ManifestCommentsHandlerService(workingDirectory: testResourcesDir.path).manifestComments()
                XCTFail("Function was expected to throw")
            } catch {
                XCTAssertEqual(error as? ManifestCommentsHandlerError, expectedError)
            }
        }
    }

    func testValidComments() {
        resourcesLoaded([manifestResourceWithValidComments]) {
            let sut = ManifestCommentsHandlerService(workingDirectory: testResourcesDir.path)
            let manifestComments = try! sut.manifestComments()
            
            XCTAssertEqual(manifestComments, [
                ManifestComment.linkageType(
                    linkageType: .static,
                    dependencies: ["HandySwift", "HandyUIKit", "Imperio", "MungoHealer", "SwiftyBeaver"]
                ),
                ManifestComment.integrationType(
                    integrationType: .cocoapods,
                    dependencies: ["Imperio", "MungoHealer", "SwiftyBeaver"]
                ),
                ManifestComment.integrationType(
                    integrationType: .binary,
                    dependencies: ["MungoHealer", "SwiftyBeaver"]
                ),
            ])

            XCTAssertEqual(try! sut.additionalConfiguration(for: "HandySwift"), AdditionalConfiguration(linkageType: .static, integrationType: .binary))
            XCTAssertEqual(try! sut.additionalConfiguration(for: "HandyUIKit"), AdditionalConfiguration(linkageType: .static, integrationType: .binary))
            XCTAssertEqual(try! sut.additionalConfiguration(for: "Imperio"), AdditionalConfiguration(linkageType: .static, integrationType: .cocoapods))
            XCTAssertEqual(try! sut.additionalConfiguration(for: "MungoHealer"), AdditionalConfiguration(linkageType: .static, integrationType: .binary))
            XCTAssertEqual(try! sut.additionalConfiguration(for: "SwiftyBeaver"), AdditionalConfiguration(linkageType: .static, integrationType: .binary))
        }
    }
}
