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
                        .package(url: "https://github.com/Moya/Moya.git", .upToNextMajor(from: "12.0.0")),
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
            XCTAssert(moyaDependency.path.hasPrefix(testResourcesDir.appendingPathComponent("\(Constants.buildPath)/checkouts/Moya.git-").path))
            XCTAssertEqual(moyaDependency.dependencies.count, 4)
            XCTAssertEqual(moyaDependency.dependencies.map { $0.name }.sorted(), ["Alamofire", "ReactiveSwift", "Result", "RxSwift"])
        }
    }
}
