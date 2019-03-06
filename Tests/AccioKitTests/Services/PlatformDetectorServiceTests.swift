@testable import AccioKit
import XCTest

class PlatformDetectorServiceTests: XCTestCase {
    private let testProjectsDir: URL = FileManager.userCacheDirUrl.appendingPathComponent("AccioTestProjects")

    private var iOSTestProjectFile: Resource {
        return Resource(
            url: testProjectsDir.appendingPathComponent("TestProject-iOS.xcodeproj/project.pbxproj"),
            contents: ResourceData.iOSProjectFileContents
        )
    }

    private var macOSTestProjectFile: Resource {
        return Resource(
            url: testProjectsDir.appendingPathComponent("TestProject-macOS.xcodeproj/project.pbxproj"),
            contents: ResourceData.macOSProjectFileContents
        )
    }

    private var tvOSTestProjectFile: Resource {
        return Resource(
            url: testProjectsDir.appendingPathComponent("TestProject-tvOS.xcodeproj/project.pbxproj"),
            contents: ResourceData.tvOSProjectFileContents
        )
    }

    private var watchOSTestProjectFile: Resource {
        return Resource(
            url: testProjectsDir.appendingPathComponent("TestProject-watchOS.xcodeproj/project.pbxproj"),
            contents: ResourceData.watchOSProjectFileContents
        )
    }

    func testDetectPlatformWithDifferentPlatforms() {
        resourcesLoaded([iOSTestProjectFile]) {
            let xcodeProjectPath = iOSTestProjectFile.url.deletingLastPathComponent().path
            let detectedPlatform = try! PlatformDetectorService.shared.detectPlatform(xcodeProjectPath: xcodeProjectPath, scheme: "TestProject-iOS")
            XCTAssertEqual(detectedPlatform, Platform.iOS)
        }

        resourcesLoaded([macOSTestProjectFile]) {
            let xcodeProjectPath = macOSTestProjectFile.url.deletingLastPathComponent().path
            let detectedPlatform = try! PlatformDetectorService.shared.detectPlatform(xcodeProjectPath: xcodeProjectPath, scheme: "TestProject-macOS")
            XCTAssertEqual(detectedPlatform, Platform.macOS)
        }

        resourcesLoaded([tvOSTestProjectFile]) {
            let xcodeProjectPath = tvOSTestProjectFile.url.deletingLastPathComponent().path
            let detectedPlatform = try! PlatformDetectorService.shared.detectPlatform(xcodeProjectPath: xcodeProjectPath, scheme: "TestProject-tvOS")
            XCTAssertEqual(detectedPlatform, Platform.tvOS)
        }

        resourcesLoaded([watchOSTestProjectFile]) {
            let xcodeProjectPath = watchOSTestProjectFile.url.deletingLastPathComponent().path
            let detectedPlatform = try! PlatformDetectorService.shared.detectPlatform(xcodeProjectPath: xcodeProjectPath, scheme: "TestProject-watchOS WatchKit App")
            XCTAssertEqual(detectedPlatform, Platform.watchOS)
        }
    }
}
