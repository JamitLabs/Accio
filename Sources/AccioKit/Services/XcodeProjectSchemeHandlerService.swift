import Foundation

final class XcodeProjectSchemeHandlerService {
    static let shared = XcodeProjectSchemeHandlerService()

    func removeUnnecessarySharedSchemes(from framework: Framework) throws {
        if try framework.containsXcodeProjectWithLibraryScheme() {
            print("Found shared scheme with exact name '\(framework.libraryName)' – removing others ...", level: .verbose)

            for xcodeProjectPath in try framework.xcodeProjectPaths() {
                let sharedSchemePathsToRemove: [String] = try sharedSchemePaths(in: xcodeProjectPath).filter { $0 != framework.libraryName }
                guard !sharedSchemePathsToRemove.isEmpty else { continue }

                print("Removing unnecessary shared schemes \(sharedSchemePathsToRemove) from project at \(xcodeProjectPath)", level: .verbose)
                for sharedSchemePathToRemove in sharedSchemePathsToRemove {
                    try FileManager.default.removeItem(atPath: sharedSchemePathToRemove)
                }
            }
        } else {
            print("No shared schemes found matching framework '\(framework.libraryName)' – can't remove unnecessary shared schemes, keeping all", level: .warning)
        }
    }

    func sharedSchemePaths(in xcodeProjectPath: String) throws -> [String] {
        let sharedSchemesPath: String = URL(fileURLWithPath: xcodeProjectPath).appendingPathComponent("xcshareddata/xcschemes").path
        guard FileManager.default.fileExists(atPath: sharedSchemesPath) else { return [] }
        return try FileManager.default.contentsOfDirectory(atPath: sharedSchemesPath)
    }
}
