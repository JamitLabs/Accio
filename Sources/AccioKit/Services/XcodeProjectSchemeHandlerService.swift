import Foundation

final class XcodeProjectSchemeHandlerService {
    static let shared = XcodeProjectSchemeHandlerService()

    func removeUnnecessarySharedSchemes(from framework: Framework) throws {
        let sharedSchemePaths: [String] = try framework.sharedSchemePaths()

        let expectedSchemeNames: [String] = [framework.libraryName, "\(framework.libraryName)-Package"]
        let sharedSchemePathsToRemove: [String] = sharedSchemePaths.filter { !expectedSchemeNames.contains($0.fileNameWithoutExtension) }

        if sharedSchemePathsToRemove.count < sharedSchemePaths.count {
            print("Found shared scheme with exact name '\(framework.libraryName)' – removing others: \(sharedSchemePathsToRemove.map { $0.fileNameWithoutExtension })", level: .verbose)

            for sharedSchemePathToRemove in sharedSchemePathsToRemove {
                try FileManager.default.removeItem(atPath: sharedSchemePathToRemove)
            }
        } else {
            print("No shared schemes found matching framework '\(framework.libraryName)' – can't remove unnecessary shared schemes, keeping all", level: .warning)
        }
    }
}
