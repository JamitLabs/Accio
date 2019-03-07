@testable import AccioKit
import XCTest

class XcodeProjectIntegrationServiceTests: XCTestCase {
    private let testResourcesDir: URL = FileManager.userCacheDirUrl.appendingPathComponent("AccioTestResources")
    private let testFrameworkNames: [String] = ["HandySwift", "HandyUIKit", "MungoHealer", "Moya"]
    private let testTarget: Target = Target(name: "TestProject-iOS", platform: .iOS)

    private var xcodeProjectResource: Resource {
        return Resource(
            url: testResourcesDir.appendingPathComponent("TestProject.xcodeproj/project.pbxproj"),
            contents: ResourceData.iOSProjectFileContents
        )
    }

    private var frameworkProductsResources: [Resource] {
        return testFrameworkNames.flatMap {
            return [
                Resource(url: testResourcesDir.appendingPathComponent(Constants.buildPath).appendingPathComponent("iOS/\($0).framework/keep"), contents: ""),
                Resource(url: testResourcesDir.appendingPathComponent(Constants.buildPath).appendingPathComponent("iOS/\($0).framework.dSYM"), contents: "")
            ]
        }
    }

    private var frameworkProducts: [FrameworkProduct] {
        return testFrameworkNames.map {
            FrameworkProduct(
                frameworkDirPath: testResourcesDir.appendingPathComponent(Constants.buildPath).appendingPathComponent("iOS/\($0).framework").path,
                symbolsFilePath: testResourcesDir.appendingPathComponent(Constants.buildPath).appendingPathComponent("iOS/\($0).framework.dSYM").path
            )
        }
    }

    private var copiedFrameworkProducts: [FrameworkProduct] {
        return testFrameworkNames.map {
            FrameworkProduct(
                frameworkDirPath: testResourcesDir.appendingPathComponent(Constants.dependenciesPath).appendingPathComponent("iOS/\($0).framework").path,
                symbolsFilePath: testResourcesDir.appendingPathComponent(Constants.dependenciesPath).appendingPathComponent("iOS/\($0).framework.dSYM").path
            )
        }
    }

    func testUpdateDependencies() {
        let xcodeProjectIntegrationService = XcodeProjectIntegrationService(workingDirectory: testResourcesDir.path)

        resourcesLoaded(frameworkProductsResources + [xcodeProjectResource]) {
            try! xcodeProjectIntegrationService.updateDependencies(of: testTarget, in: "TestProject", with: frameworkProducts)

            // test copyFrameworkProducts
            for frameworkProduct in copiedFrameworkProducts {
                XCTAssert(FileManager.default.fileExists(atPath: frameworkProduct.frameworkDirPath))
                XCTAssert(FileManager.default.fileExists(atPath: frameworkProduct.symbolsFilePath))
            }

            // test linkFrameworks
            // TODO: not yet implemented

            // test updateBuildPhase
            // TODO: not yet implemented
        }
    }
}

