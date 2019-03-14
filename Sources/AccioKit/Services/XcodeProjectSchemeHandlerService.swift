import Foundation

final class XcodeProjectSchemeHandlerService {
    static let shared = XcodeProjectSchemeHandlerService()

    func removeUnnecessarySharedSchemes(from framework: Framework) throws {
        print("Removing any unnecessary schemes from framework at '\(framework.projectDirectory)' ...", level: .verbose)

        let xcodeSchemesDirectoryUrl = URL(fileURLWithPath: framework.xcodeProjectPath).appendingPathComponent("xcshareddata/xcschemes")
        let allSchemeFileNames: [String] = try FileManager.default.contentsOfDirectory(atPath: xcodeSchemesDirectoryUrl.path).filter { $0.hasSuffix(".xcscheme") }

        guard allSchemeFileNames.count > 1 else { return }
        let allSchemeNames: [String] = allSchemeFileNames.map { $0.replacingOccurrences(of: ".xcscheme", with: "") }

        if allSchemeNames.contains(framework.libraryName) {
            let schemeNamesToRemove: [String] = allSchemeNames.filter({ $0 != framework.libraryName })
            print("Found shared scheme with exact name '\(framework.libraryName)' – removing others: \(schemeNamesToRemove)", level: .verbose)

            for schemeNameToRemove in schemeNamesToRemove {
                try bash("rm -f '\(xcodeSchemesDirectoryUrl.appendingPathComponent("\(schemeNameToRemove).xcscheme").path)'")
            }
        } else {
            print("No shared scheme found with exact name '\(framework.libraryName)' – can't determine unnecessary shared scheme to delete, keeping all", level: .verbose)
        }
    }
}
