import Foundation
import HandySwift
import SwiftShell

enum SwiftVersionDetectorError: Error {
    case unableToRunSwiftVersionCommand
    case unableToParseSwiftVerisonCommand
}

class SwiftVersionDetectorService {
    static let shared = SwiftVersionDetectorService()

    func getCurrentSwiftVersion() throws -> String {
        let result = run(bash: "swift --version")
        guard result.succeeded else {
            throw SwiftVersionDetectorError.unableToRunSwiftVersionCommand
        }

        return try convertToSwiftVersion(swiftVersionOutput: result.stdout)
    }

    func convertToSwiftVersion(swiftVersionOutput: String) throws -> String {
        do {
            let regex = try Regex(#"Apple Swift version ([\d.]*) \(swiftlang"#)
            guard let versionNumber = regex.firstMatch(in: swiftVersionOutput)?.captures.first ?? nil else {
                throw SwiftVersionDetectorError.unableToParseSwiftVerisonCommand
            }

            return "Swift-\(versionNumber)"
        }
        catch {
            throw SwiftVersionDetectorError.unableToParseSwiftVerisonCommand
        }
    }
}
