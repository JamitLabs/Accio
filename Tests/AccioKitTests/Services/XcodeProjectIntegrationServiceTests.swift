@testable import AccioKit
import PathKit
import XcodeProj
import XCTest

class XcodeProjectIntegrationServiceTests: XCTestCase {
    private let testResourcesDir: URL = FileManager.userCacheDirUrl.appendingPathComponent("AccioTestResources")
    private let testFrameworkNames: [String] = ["Alamofire", "HandySwift", "HandyUIKit", "MungoHealer"]
    private let regularTarget: AppTarget = AppTarget(projectName: "TestProject", targetName: "TestProject-iOS", dependentLibraryNames: [], targetType: .app)
    private let testTarget: AppTarget = AppTarget(projectName: "TestProject", targetName: "TestProject-iOSTests", dependentLibraryNames: [], targetType: .test)

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
                symbolsFilePath: testResourcesDir.appendingPathComponent(Constants.buildPath).appendingPathComponent("iOS/\($0).framework.dSYM").path,
                commitHash: "abc"
            )
        }
    }

    private var copiedFrameworkProducts: [FrameworkProduct] {
        return testFrameworkNames.map {
            FrameworkProduct(
                frameworkDirPath: testResourcesDir.appendingPathComponent(Constants.dependenciesPath).appendingPathComponent("iOS/\($0).framework").path,
                symbolsFilePath: testResourcesDir.appendingPathComponent(Constants.dependenciesPath).appendingPathComponent("iOS/\($0).framework.dSYM").path,
                commitHash: "abc"
            )
        }
    }

    override func setUp() {
        super.setUp()

        clean()
    }

    private func clean() {
        try! bash("rm -rf '\(testResourcesDir.path)'")
    }

    func testUpdateDependencies() {
        let xcodeProjectIntegrationService = XcodeProjectIntegrationService(workingDirectory: testResourcesDir.path)

        for appTarget in [regularTarget, testTarget] {
            resourcesLoaded(frameworkProductsResources + [xcodeProjectResource]) {
                // ensure frameworks not yet copied

                for frameworkProduct in copiedFrameworkProducts {
                    XCTAssert(!FileManager.default.fileExists(atPath: frameworkProduct.frameworkDirPath))
                    XCTAssert(!FileManager.default.fileExists(atPath: frameworkProduct.symbolsFilePath))
                }

                // ensure frameworks not yet linked
                var pbxproject = readPbxproject()
                var targetObject: PBXTarget = pbxproject.targets(named: appTarget.targetName).first!
                var frameworksBuildPhase: PBXFrameworksBuildPhase = targetObject.buildPhases.first(where: { $0.buildPhase == .frameworks })! as! PBXFrameworksBuildPhase

                XCTAssert(frameworksBuildPhase.files!.isEmpty)

                // ensure build phase not yet updated
                XCTAssert(!targetObject.buildPhases.contains { $0.type() == .runScript && ($0 as! PBXShellScriptBuildPhase).name == Constants.copyBuildScript })

                try! xcodeProjectIntegrationService.updateDependencies(of: appTarget, for: .iOS, with: frameworkProducts)

                // test copyFrameworkProducts
                for frameworkProduct in copiedFrameworkProducts {
                    XCTAssert(FileManager.default.fileExists(atPath: frameworkProduct.frameworkDirPath))
                    XCTAssert(FileManager.default.fileExists(atPath: frameworkProduct.symbolsFilePath))
                }

                pbxproject = readPbxproject()

                // test linkFrameworks
                targetObject = pbxproject.targets(named: appTarget.targetName).first!
                frameworksBuildPhase = targetObject.buildPhases.first(where: { $0.buildPhase == .frameworks })! as! PBXFrameworksBuildPhase

                XCTAssertEqual(frameworksBuildPhase.files!.count, testFrameworkNames.count)
                XCTAssertEqual(frameworksBuildPhase.files!.map { $0.file!.name }, testFrameworkNames.map { "\($0).framework" })

                // test updateBuildPhase
                switch appTarget.targetType {
                case .app:
                    let accioBuildScript = targetObject.buildPhases.first { $0.type() == .runScript && ($0 as! PBXShellScriptBuildPhase).name == Constants.copyBuildScript } as! PBXShellScriptBuildPhase

                    XCTAssertEqual(accioBuildScript.inputPaths.count, testFrameworkNames.count)
                    XCTAssertEqual(accioBuildScript.inputPaths, testFrameworkNames.map { "$(SRCROOT)/\(Constants.dependenciesPath)/iOS/\($0).framework" })

                case .test, .appExtension:
                    let accioBuildScript = targetObject.buildPhases.first { $0.type() == .runScript && ($0 as! PBXShellScriptBuildPhase).name == Constants.copyBuildScript }
                    XCTAssertNil(accioBuildScript)
                }

                // test project navigator integration
                let rootGroup = try! pbxproject.rootGroup()!
                let dependenciesGroup = try! rootGroup.group(named: Constants.xcodeDependenciesGroup) ?? rootGroup.addGroup(named: Constants.xcodeDependenciesGroup, options: .withoutFolder)[0]
                let targetGroup = try! dependenciesGroup.group(named: appTarget.targetName) ?? dependenciesGroup.addGroup(named: appTarget.targetName, options: .withoutFolder)[0]

                XCTAssertEqual(targetGroup.name, appTarget.targetName)
                XCTAssertEqual(targetGroup.children.compactMap { $0.name }, testFrameworkNames.map { "\($0).framework" })

                clean()
            }
        }
    }

    private func readPbxproject() -> PBXProj {
        let projectFile = try! XcodeProj(path: Path(xcodeProjectResource.url.deletingLastPathComponent().path))
        return projectFile.pbxproj
    }
}
