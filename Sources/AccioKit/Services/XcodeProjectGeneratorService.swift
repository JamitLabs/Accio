import Foundation

final class XcodeProjectGeneratorService {
    static let shared = XcodeProjectGeneratorService()

    func generateXcodeProject(framework: Framework) throws {
        print("Generating Xcode project at \(framework.xcodeProjectPath) using SwiftPM ...", level: .info)
        try bash("swift package --package-path \(framework.projectDirectory) generate-xcodeproj")
        print("Generated Xcode project at \(framework.xcodeProjectPath) using SwiftPM.", level: .info)
    }
}
