import Foundation

final class XcodeProjectSchemeHandlerService {
    static let shared = XcodeProjectSchemeHandlerService()

    func removeUnnecessarySharedSchemes(from framework: Framework, platform: Platform) throws {
        let sharedSchemePaths: [String] = try framework.sharedSchemePaths()
        let librarySchemePaths: [String] = framework.librarySchemePaths(in: sharedSchemePaths, framework: framework)

        let expectedSchemeNames: [String] = platform.specifiers.flatMap { platformSpecifier in
            return [
                framework.libraryName,
                "\(framework.libraryName) \(platformSpecifier)",
                "\(framework.libraryName) (\(platformSpecifier))",
                "\(framework.libraryName)-\(platformSpecifier)",
                "\(framework.libraryName)_\(platformSpecifier)",
                "\(framework.libraryName)-Package"
            ].map { $0.lowercased() }
        }
        let matchingSchemePaths: [String] = librarySchemePaths.filter { expectedSchemeNames.contains($0.fileNameWithoutExtension.lowercased()) }

        if !matchingSchemePaths.isEmpty {
            let schemePathsToRemove: [String] = sharedSchemePaths.filter { !matchingSchemePaths.contains($0) }
            print("Found shared scheme(s) with exact name '\(framework.libraryName)' – removing others: \(schemePathsToRemove.map { $0.fileNameWithoutExtension })", level: .verbose)

            for schemePathToRemove in schemePathsToRemove {
                try FileManager.default.removeItem(atPath: schemePathToRemove)
            }
        } else {
            print("No shared scheme(s) found matching framework '\(framework.libraryName)' – can't remove unnecessary shared schemes, keeping all", level: .warning)
        }
    }
}
