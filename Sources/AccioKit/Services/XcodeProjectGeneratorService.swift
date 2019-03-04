import Foundation

final class XcodeProjectGeneratorService {
    static let shared = XcodeProjectGeneratorService()

    func generateXcodeProject(framework: Framework) throws {
        try bash("swift package generate-xcodeproj --package-path \(framework.directory)")
    }
}
