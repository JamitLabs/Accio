import Foundation

final class XcodeProjectSchemeHandlerService {
    static let shared = XcodeProjectSchemeHandlerService()

    func removeUnnecessarySharedSchemes(from framework: Framework, platform: Platform) throws {
        let sharedSchemePaths: [String] = try framework.sharedSchemePaths()
        let librarySchemePaths: [String] = framework.librarySchemePaths(in: sharedSchemePaths, framework: framework)

        let expectedSchemeNames: [String] = platform.specifiers.flatMap { platformSpecifier in
            return [
                framework.libraryName,
                "\(framework.libraryName) Framework",
                "\(framework.libraryName) Library",
                "\(framework.libraryName) \(platformSpecifier)",
                "\(framework.libraryName) (\(platformSpecifier))",
                "\(framework.libraryName)-\(platformSpecifier)",
                "\(framework.libraryName)_\(platformSpecifier)",
                "\(framework.libraryName) Framework \(platformSpecifier)",
                "\(framework.libraryName) Library \(platformSpecifier)",
                "\(framework.libraryName) Framework (\(platformSpecifier))",
                "\(framework.libraryName) Library (\(platformSpecifier))",
                "\(framework.libraryName)-Package"
            ].map { $0.lowercased() }
        }
        let matchingSchemePaths: [String] = librarySchemePaths.filter { expectedSchemeNames.contains($0.fileNameWithoutExtension.lowercased()) }
        let matchingSchemeNames: [String] = matchingSchemePaths.map { $0.fileNameWithoutExtension }

        guard !librarySchemePaths.isEmpty else {
            print("No shared scheme(s) found; still resuming build.", level: .warning)
            return
        }

        if !matchingSchemePaths.isEmpty {
            let schemePathsToRemove: [String] = sharedSchemePaths.filter { !matchingSchemePaths.contains($0) }
            print("Found shared scheme(s) \(matchingSchemeNames) matching specified library – removing others: \(schemePathsToRemove.map { $0.fileNameWithoutExtension })", level: .verbose)

            for schemePathToRemove in schemePathsToRemove {
                try FileManager.default.removeItem(atPath: schemePathToRemove)
            }
        } else {
            print("No shared scheme(s) found matching library name '\(framework.libraryName)' – can't remove potentially unnecessary shared schemes, keeping all", level: .warning)
        }
    }
}
