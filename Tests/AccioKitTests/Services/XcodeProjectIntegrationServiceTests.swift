@testable import AccioKit
import PathKit
import xcodeproj
import XCTest

class XcodeProjectIntegrationServiceTests: XCTestCase {
    private let testResourcesDir: URL = FileManager.userCacheDirUrl.appendingPathComponent("AccioTestResources")
    private let testFrameworkNames: [String] = ["HandySwift", "HandyUIKit", "MungoHealer", "Alamofire"]
    private let testTarget: AppTarget = AppTarget(projectName: "TestProject-iOS", targetName: "TestProject-iOS", dependentLibraryNames: [])

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

    override func setUp() {
        super.setUp()

        try! bash("rm -rf '\(testResourcesDir.path)'")
    }

    func testUpdateDependencies() {
        let xcodeProjectIntegrationService = XcodeProjectIntegrationService(workingDirectory: testResourcesDir.path)

        resourcesLoaded(frameworkProductsResources + [xcodeProjectResource]) {
            // ensure frameworks not yet copied
            for frameworkProduct in copiedFrameworkProducts {
                XCTAssert(!FileManager.default.fileExists(atPath: frameworkProduct.frameworkDirPath))
                XCTAssert(!FileManager.default.fileExists(atPath: frameworkProduct.symbolsFilePath))
            }

            // ensure frameworks not yet linked
            var pbxproject = readPbxproject()
            var targetObject: PBXTarget = pbxproject.targets(named: "TestProject-iOS").first!
            var frameworksBuildPhase: PBXFrameworksBuildPhase = targetObject.buildPhases.first(where: { $0.buildPhase == .frameworks })! as! PBXFrameworksBuildPhase

            XCTAssert(frameworksBuildPhase.files.isEmpty)

            // ensure build phase not yet updated
            XCTAssert(!targetObject.buildPhases.contains { $0.type() == .runScript && ($0 as! PBXShellScriptBuildPhase).name == Constants.copyBuildScript })

            try! xcodeProjectIntegrationService.updateDependencies(of: testTarget, for: .iOS, with: frameworkProducts)

            // test copyFrameworkProducts
            for frameworkProduct in copiedFrameworkProducts {
                XCTAssert(FileManager.default.fileExists(atPath: frameworkProduct.frameworkDirPath))
                XCTAssert(FileManager.default.fileExists(atPath: frameworkProduct.symbolsFilePath))
            }

            // test linkFrameworks
            pbxproject = readPbxproject()
            targetObject = pbxproject.targets(named: "TestProject-iOS").first!
            frameworksBuildPhase = targetObject.buildPhases.first(where: { $0.buildPhase == .frameworks })! as! PBXFrameworksBuildPhase

            XCTAssertEqual(frameworksBuildPhase.files.count, testFrameworkNames.count)
            XCTAssertEqual(frameworksBuildPhase.files.map { $0.file!.name }, testFrameworkNames.map { "\($0).framework" })

            // test updateBuildPhase
            let accioBuldScript = targetObject.buildPhases.first { $0.type() == .runScript && ($0 as! PBXShellScriptBuildPhase).name == Constants.copyBuildScript } as! PBXShellScriptBuildPhase

            XCTAssertEqual(accioBuldScript.inputPaths.count, testFrameworkNames.count)
            XCTAssertEqual(accioBuldScript.inputPaths, testFrameworkNames.map { "$(SRCROOT)/Dependencies/iOS/\($0).framework" })
        }
    }

    private func readPbxproject() -> PBXProj {
        let projectFile = try! XcodeProj(path: Path(xcodeProjectResource.url.deletingLastPathComponent().path))
        return projectFile.pbxproj
    }
}
