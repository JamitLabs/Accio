@testable import AccioKit
import XCTest

class FrameworkTests: XCTestCase {
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
                        .package(url: "https://github.com/Moya/Moya.git", .upToNextMajor(from: "12.0.0")),
                        .package(url: "https://github.com/ReactiveX/RxSwift.git", .upToNextMajor(from: "4.0.0")),
                    ],
                    targets: [
                        .target(
                            name: "TestProject-iOS",
                            dependencies: [
                                "HandySwift",
                                "Moya",
                                "RxSwift",
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

    func testXcodeProjectPaths() {
        resourcesLoaded([manifestResource, xcodeProjectResource, exampleSwiftFile]) {
            let manifest = try! ManifestHandlerService(workingDirectory: testResourcesDir.path).loadManifest(isDependency: false)
            let dependencyGraph = try! DependencyResolverService(workingDirectory: testResourcesDir.path).dependencyGraph()
            let appTarget = manifest.appTargets.first!

            let frameworks: [Framework] = try! appTarget.frameworkDependencies(manifest: manifest, dependencyGraph: dependencyGraph).flattenedDeepFirstOrder()
            let rxFramework: Framework = frameworks.last!

            XCTAssertEqual(rxFramework.libraryName, "RxSwift")
            XCTAssertEqual(
                try! rxFramework.xcodeProjectPaths(in: rxFramework.projectDirectory).sorted(),
                [
                    "\(rxFramework.projectDirectory)/Preprocessor/Preprocessor.xcodeproj",
                    "\(rxFramework.projectDirectory)/Rx.xcodeproj",
                    "\(rxFramework.projectDirectory)/Rx.xcworkspace",
                    "\(rxFramework.projectDirectory)/RxExample/RxExample.xcodeproj",
                ]
            )
        }
    }
}
