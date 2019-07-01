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

        let regex = try Regex(#"Apple Swift version ([\d.]*) \(swiftlang"#)
        guard let versionNumber = regex.firstMatch(in: result.stdout)?.captures.first ?? nil else {
            throw SwiftVersionDetectorError.unableToParseSwiftVerisonCommand
        }

        return "Swift-\(versionNumber)"
    }
}
