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
            let xcodeProjectUrl = iOSTestProjectFile.url.deletingLastPathComponent()
            let platformDetectorService = PlatformDetectorService(workingDirectory: xcodeProjectUrl.deletingLastPathComponent().path)
            let detectedPlatform = try! platformDetectorService.detectPlatform(projectName: xcodeProjectUrl.deletingPathExtension().lastPathComponent, targetName: "TestProject-iOS")
            XCTAssertEqual(detectedPlatform, Platform.iOS)
        }

        resourcesLoaded([macOSTestProjectFile]) {
            let xcodeProjectUrl = macOSTestProjectFile.url.deletingLastPathComponent()
            let platformDetectorService = PlatformDetectorService(workingDirectory: xcodeProjectUrl.deletingLastPathComponent().path)
            let detectedPlatform = try! platformDetectorService.detectPlatform(projectName: xcodeProjectUrl.deletingPathExtension().lastPathComponent, targetName: "TestProject-macOS")
            XCTAssertEqual(detectedPlatform, Platform.macOS)
        }

        resourcesLoaded([tvOSTestProjectFile]) {
            let xcodeProjectUrl = tvOSTestProjectFile.url.deletingLastPathComponent()
            let platformDetectorService = PlatformDetectorService(workingDirectory: xcodeProjectUrl.deletingLastPathComponent().path)
            let detectedPlatform = try! platformDetectorService.detectPlatform(projectName: xcodeProjectUrl.deletingPathExtension().lastPathComponent, targetName: "TestProject-tvOS")
            XCTAssertEqual(detectedPlatform, Platform.tvOS)
        }

        resourcesLoaded([watchOSTestProjectFile]) {
            let xcodeProjectUrl = watchOSTestProjectFile.url.deletingLastPathComponent()
            let platformDetectorService = PlatformDetectorService(workingDirectory: xcodeProjectUrl.deletingLastPathComponent().path)
            let detectedPlatform = try! platformDetectorService.detectPlatform(projectName: xcodeProjectUrl.deletingPathExtension().lastPathComponent, targetName: "TestProject-watchOS WatchKit App")
            XCTAssertEqual(detectedPlatform, Platform.watchOS)
        }
    }
}
