@testable import AccioKit
import PathKit
import XcodeProj
import XCTest

class XcodeProjectIntegrationServiceTests: XCTestCase {
    private let testResourcesDir: URL = FileManager.userCacheDirUrl.appendingPathComponent("AccioTestResources")
    private let testFrameworks: [(name: String, includeBundleVersion: Bool)] = [
        ("Alamofire", true), ("HandySwift", true), ("HandyUIKit", false), ("MungoHealer", false)
    ]

    private let regularTarget: AppTarget = AppTarget(projectName: "TestProject", targetName: "TestProject-iOS", dependentLibraryNames: [], targetType: .app)
    private let testTarget: AppTarget = AppTarget(projectName: "TestProject", targetName: "TestProject-iOSTests", dependentLibraryNames: [], targetType: .test)

    private var xcodeProjectResource: Resource {
        return Resource(
            url: testResourcesDir.appendingPathComponent("TestProject.xcodeproj/project.pbxproj"),
            contents: ResourceData.iOSProjectFileContents
        )
    }

    private var frameworkProductsResources: [Resource] {
        return testFrameworks.flatMap {
            return [
                Resource(url: testResourcesDir.appendingPathComponent(Constants.buildPath).appendingPathComponent("iOS/\($0.name).framework/keep"), contents: ""),
                Resource(url: testResourcesDir.appendingPathComponent(Constants.buildPath).appendingPathComponent("iOS/\($0.name).framework.dSYM"), contents: "")
            ]
        }
    }

    private var frameworkProducts: [FrameworkProduct] {
        return testFrameworks.map {
            FrameworkProduct(
                frameworkDirPath: testResourcesDir.appendingPathComponent(Constants.buildPath).appendingPathComponent("iOS/\($0.name).framework").path,
                symbolsFilePath: testResourcesDir.appendingPathComponent(Constants.buildPath).appendingPathComponent("iOS/\($0.name).framework.dSYM").path,
                commitHash: "abc"
            )
        }
    }

    private var copiedFrameworkProducts: [FrameworkProduct] {
        return testFrameworks.map {
            FrameworkProduct(
                frameworkDirPath: testResourcesDir.appendingPathComponent(Constants.dependenciesPath).appendingPathComponent("iOS/\($0.name).framework").path,
                symbolsFilePath: testResourcesDir.appendingPathComponent(Constants.dependenciesPath).appendingPathComponent("iOS/\($0.name).framework.dSYM").path,
                commitHash: "abc"
            )
        }
    }

    override func setUp() {
        super.setUp()

        clean()
    }

    private func createInfoPlist(frameworkName: String, includeBundleVersion: Bool) {
        let plistURL = testResourcesDir.appendingPathComponent(Constants.buildPath).appendingPathComponent("iOS/\(frameworkName).framework/Info.plist")
        let plist = includeBundleVersion ? ["CFBundleVersion": "1"] : [:]
        let data = try! PropertyListSerialization.data(fromPropertyList: plist, format: .binary, options: 0)
        try! data.write(to: plistURL, options: .atomic)
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

                testFrameworks.forEach { frameworkName, includeBundleVersion in
                    createInfoPlist(frameworkName: frameworkName, includeBundleVersion: includeBundleVersion)
                }

                try! xcodeProjectIntegrationService.updateDependencies(of: appTarget, for: .iOS, with: frameworkProducts)

                // test CFBundleVersion in Info.plist
                frameworkProducts.forEach { product in
                    let frameworkPath = product.frameworkDirPath.replacingOccurrences(of: "/.accio/", with: "/Dependencies/")
                    let plistURL = URL(fileURLWithPath: frameworkPath).appendingPathComponent("Info.plist")
                    let data = try! Data(contentsOf: plistURL)
                    var format: PropertyListSerialization.PropertyListFormat = .binary
                    var plist = try! PropertyListSerialization.propertyList(from: data, options: [.mutableContainersAndLeaves], format: &format) as! [String: Any]

                    print(plistURL)
                    print(plist)
                    XCTAssertNotNil(plist["CFBundleVersion"])
                }

                // test copyFrameworkProducts
                for frameworkProduct in copiedFrameworkProducts {
                    XCTAssert(FileManager.default.fileExists(atPath: frameworkProduct.frameworkDirPath))
                    XCTAssert(FileManager.default.fileExists(atPath: frameworkProduct.symbolsFilePath))
                }

                pbxproject = readPbxproject()

                // test linkFrameworks
                targetObject = pbxproject.targets(named: appTarget.targetName).first!
                frameworksBuildPhase = targetObject.buildPhases.first(where: { $0.buildPhase == .frameworks })! as! PBXFrameworksBuildPhase

                XCTAssertEqual(frameworksBuildPhase.files!.count, testFrameworks.count)
                XCTAssertEqual(frameworksBuildPhase.files!.map { $0.file!.name }, testFrameworks.map { "\($0.name).framework" })

                // test updateBuildPhase
                switch appTarget.targetType {
                case .app:
                    let accioBuildScript = targetObject.buildPhases.first { $0.type() == .runScript && ($0 as! PBXShellScriptBuildPhase).name == Constants.copyBuildScript } as! PBXShellScriptBuildPhase

                    XCTAssertEqual(accioBuildScript.inputPaths.count, testFrameworks.count)
                    XCTAssertEqual(accioBuildScript.inputPaths, testFrameworks.map { "$(SRCROOT)/\(Constants.dependenciesPath)/iOS/\($0.name).framework" })

                case .test, .appExtension:
                    let accioBuildScript = targetObject.buildPhases.first { $0.type() == .runScript && ($0 as! PBXShellScriptBuildPhase).name == Constants.copyBuildScript }
                    XCTAssertNil(accioBuildScript)
                }

                // test project navigator integration
                let rootGroup = try! pbxproject.rootGroup()!
                let dependenciesGroup = try! rootGroup.group(named: Constants.xcodeDependenciesGroup) ?? rootGroup.addGroup(named: Constants.xcodeDependenciesGroup, options: .withoutFolder)[0]
                let targetGroup = try! dependenciesGroup.group(named: appTarget.targetName) ?? dependenciesGroup.addGroup(named: appTarget.targetName, options: .withoutFolder)[0]

                XCTAssertEqual(targetGroup.name, appTarget.targetName)
                XCTAssertEqual(targetGroup.children.compactMap { $0.name }, testFrameworks.map { "\($0.name).framework" })

                clean()
            }
        }
    }

    private func readPbxproject() -> PBXProj {
        let projectFile = try! XcodeProj(path: Path(xcodeProjectResource.url.deletingLastPathComponent().path))
        return projectFile.pbxproj
    }
}
