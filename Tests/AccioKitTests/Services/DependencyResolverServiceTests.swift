@testable import AccioKit
import XCTest

class DependencyResolverServiceTests: XCTestCase {
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
                        .package(url: "https://github.com/Moya/Moya.git", .revision("43209d6ac45d244d8be08f4cf6df684b96190616")),
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

    private var exampleObjCFile: Resource {
        return Resource(
            url: testResourcesDir.appendingPathComponent("TestProject-iOS/AppDelegate.m"),
            contents: """
                @interface AppDelegate
                @end

                @implementation AppDelegate
                #end
                """
        )
    }

    override func setUp() {
        super.setUp()

        try! bash("rm -rf '\(testResourcesDir.path)'")
        try! bash("mkdir '\(testResourcesDir.path)'")
    }

    func testDependencyGraph() {
        resourcesLoaded([manifestResource, xcodeProjectResource, exampleSwiftFile]) {
            let dependencyGraph = try! DependencyResolverService(workingDirectory: testResourcesDir.path).dependencyGraph()

            XCTAssertEqual(dependencyGraph.name, "TestProject")
            XCTAssertEqual(dependencyGraph.dependencies.count, 5)


            XCTAssertEqual(dependencyGraph.dependencies.map { $0.name }.sorted(), ["HandySwift", "HandyUIKit", "Imperio", "Moya", "MungoHealer"])

            let moyaDependency = dependencyGraph.dependencies.first { $0.name == "Moya" }!
            XCTAssertEqual(moyaDependency.path, testResourcesDir.appendingPathComponent("\(Constants.buildPath)/checkouts/Moya").path)
            XCTAssertEqual(moyaDependency.dependencies.count, 4)
            XCTAssertEqual(moyaDependency.dependencies.map { $0.name }.sorted(), ["Alamofire", "ReactiveSwift", "Result", "RxSwift"])
        }
    }

    func testMixedProjectOutput() {
        TestHelper.shared.isStartedByUnitTests = true

        resourcesLoaded([manifestResource, xcodeProjectResource, exampleSwiftFile, exampleObjCFile]) {
            do {
                _ = try DependencyResolverService(workingDirectory: testResourcesDir.path).dependencyGraph()
                XCTFail("Expected DependencyResolverService to throw exception.")
            } catch {
                XCTAssertEqual(
                    TestHelper.shared.printOutputs.last?.message,
                    """
                    Please make sure that the 'path' of all targets in Package.swift are set to directories containing only Swift files.
                        For additional details, please see here: https://github.com/JamitLabs/Accio/issues/3")
                    """
                )
                XCTAssertEqual(TestHelper.shared.printOutputs.last?.level, .warning)
            }
        }
    }
}
