import Foundation

final class XcodeProjectSchemeHandlerService {
    static let shared = XcodeProjectSchemeHandlerService()

    func removeUnnecessarySharedSchemes(from framework: Framework, platform: Platform) throws {
        let sharedSchemePaths: [String] = try framework.sharedSchemePaths()
        let librarySchemePaths: [String] = framework.librarySchemePaths(in: sharedSchemePaths, framework: framework)

        let expectedSchemeNames: [String] = [
            framework.libraryName,
            "\(framework.libraryName) \(platform.rawValue)",
            "\(framework.libraryName) (\(platform.rawValue))",
            "\(framework.libraryName)-\(platform.rawValue)",
            "\(framework.libraryName)_\(platform.rawValue)",
            "\(framework.libraryName)-Package"
        ]
        let matchingSchemePaths: [String] = librarySchemePaths.filter { expectedSchemeNames.contains($0.fileNameWithoutExtension) }

        if !matchingSchemePaths.isEmpty {
            let schemePathsToRemove: [String] = sharedSchemePaths.filter { !matchingSchemePaths.contains($0) }
            print("Found shared scheme with exact name '\(framework.libraryName)' – removing others: \(schemePathsToRemove.map { $0.fileNameWithoutExtension })", level: .verbose)

            for schemePathToRemove in schemePathsToRemove {
                try FileManager.default.removeItem(atPath: schemePathToRemove)
            }
        } else {
            print("No shared schemes found matching framework '\(framework.libraryName)' – can't remove unnecessary shared schemes, keeping all", level: .warning)
        }
    }
}
