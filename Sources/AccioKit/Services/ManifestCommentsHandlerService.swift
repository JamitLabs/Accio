import Foundation
import SwiftShell

/// Possible errors thrown by the ManifestCommentsHandlerService
enum ManifestCommentsHandlerError: Error, Equatable {
    case sameKeyAppearsMoreThanOnceInTheSameComment(count: Int)
    case keyWithoutValue(key: CommentKey)
    case invalidValue(key: CommentKey, value: String, possibleValues: [String])
    case commentWithoutKnownKeys(comment: String, possibleKeys: [String])
}

private enum Regex {
    /// Pattern to detect an accio comment
    private static let accioPattern = #"(.*)//\s*accio"#
    /// Capture all text that follows the same level of indentation
    private static let sameIndentationPattern = #"(\n\1.*)*"#
    /// Regex matching all text that starts with an accio comment and has the same indentation level
    static let accioComment = NSRegularExpression("\(accioPattern).*\(sameIndentationPattern)")

    /// Swift string regex. From: https://stackoverflow.com/questions/171480/regex-grabbing-values-between-quotation-marks
    private static let quotedString = NSRegularExpression(#"(["'])(?:(?=(\\?))\2.)*?\1"#)
    /// Parses multiple quoted strings
    static func parseQuotedStrings(_ string: String) -> [String] {
        return string.matches(for: quotedString)
            .map { $0.replacingOccurrences(of: "\"|'", with: "", options: .regularExpression) }
    }
}

/// A service that handles all logic related with parsing all the information from the manifest that is passed as accio comments
final class ManifestCommentsHandlerService {
    static let shared = ManifestCommentsHandlerService(workingDirectory: GlobalOptions.workingDirectory.value ?? FileManager.default.currentDirectoryPath)

    private let workingDirectory: URL

    init(workingDirectory: String) {
        self.workingDirectory = URL(fileURLWithPath: workingDirectory)
    }

    /// Returns all the information from the manifest that is passed as accio comments
    func loadManifestComments() throws -> [ManifestComment] {
        let packageManifestPath = workingDirectory.appendingPathComponent("Package.swift")
        let packageManifestContent = try String(contentsOf: packageManifestPath)
        let matches = packageManifestContent.nestedMatches(for: Regex.accioComment)
        let comments: [RawComment] = matches.map {
            var lines = $0.lines()
            let firstLine = lines.removeFirst()
            return RawComment(header: firstLine, content: lines.joined(separator: "\n"))
        }

        return try comments.flatMap { comment -> [ManifestComment] in
            return try parse(comment: comment)
        }
    }

    /// Parses a raw comment, returning the information that it contains
    private func parse(comment: RawComment) throws -> [ManifestComment] {
        let results: [ManifestComment] = try CommentKey.allCases.compactMap { commentKey in
            let regex = NSRegularExpression(commentKey.rawValue)
            if comment.header.matches(regex) {
                return try commentKey.parse(comment)
            } else {
                // Do nothing
                return nil
            }
        }
        guard !results.isEmpty else {
            throw ManifestCommentsHandlerError.commentWithoutKnownKeys(
                comment: comment.header,
                possibleKeys: CommentKey.allCases.map { $0.rawValue }
            )
        }

        return results
    }
}

/// A raw comment
struct RawComment {
    let header: String
    let content: String
}

/// The possible comment keys accepted in the manifest
enum CommentKey: String, CaseIterable {
    case productType = "product-type"
    case integrationType = "integration-type"

    /// The pattern used to identify key and value
    var pattern: String {
        return "\(self.rawValue)" + #":[^\s]+"#
    }

    /// Parses the comment, extracting all the information associated with a key
    func parse(_ comment: RawComment) throws -> ManifestComment {
        guard let value = try getValue(from: comment.header) else {
            throw ManifestCommentsHandlerError.keyWithoutValue(key: self)
        }

        switch self {
        case .productType:
            guard let productType = ProductType(rawValue: value) else {
                throw ManifestCommentsHandlerError.invalidValue(key: self, value: value, possibleValues: ProductType.allCases.map { $0.rawValue })
            }

            let dependencies = Regex.parseQuotedStrings(comment.content)
            return ManifestComment.productType(productType: productType, dependencies: dependencies)

        case .integrationType:
            guard let integrationType = IntegrationType(rawValue: value) else {
                throw ManifestCommentsHandlerError.invalidValue(key: self, value: value, possibleValues: IntegrationType.allCases.map { $0.rawValue })
            }

            let dependencies = Regex.parseQuotedStrings(comment.content)
            return ManifestComment.integrationType(integrationType: integrationType, dependencies: dependencies)
        }
    }

    /// Extracts the value for a key from the string
    private func getValue(from string: String) throws -> String? {
        let regex = NSRegularExpression(pattern)
        let matches = string.matches(for: regex)
        guard let match = matches.first else {
            // The accio comment does not include the comment key
            return nil
        }

        guard matches.count == 1 else {
            throw ManifestCommentsHandlerError.sameKeyAppearsMoreThanOnceInTheSameComment(count: matches.count)
        }

        let value = match.components(separatedBy: ":")[1]
        return value
    }
}

/// The configuration in the manifest that is passed as comments
enum ManifestComment: Equatable {
    /// Product type to be used when generating the dependency products
    case productType(productType: ProductType, dependencies: [String])
    /// Integration type to be used when integrating the dependencies in the Xcode project
    case integrationType(integrationType: IntegrationType, dependencies: [String])
}

/// The type of the product to be generated for a dependency
enum ProductType: String, CaseIterable {
    /// The default one: generate the product as the author of the dependency has configured it
    case `default`
    /// Generate a static framework
    case staticFramework = "static-framework"
    /// Generate a dynamic framework
    case dynamicFramework = "dynamic-framework"
}

/// The type of integration to be used when adding the dependencies to the Xcode project
enum IntegrationType: String, CaseIterable {
    /// The default one: adding the dependencies to the Xcode project
    case `default`
    /// Adding the dependencies to a cocoapods setup
    case cocoapods
}

/// MARK: helper extension to match strings with regular expressions

private extension String {
    /// Get all matches of the regex from the string
    func matches(for regex: NSRegularExpression) -> [String] {
        let results = regex.matches(in: self, range: NSRange(self.startIndex..., in: self))
        return results.map {
            String(self[Range($0.range, in: self)!])
        }
    }

    func nestedMatches(for regex: NSRegularExpression) -> [String] {
        return nestedMatches(for: regex, in: fullNSRange)
    }

    /// Get all matches of the regex from the string, including nested matching patterns
    private func nestedMatches(for regex: NSRegularExpression, in range: NSRange) -> [String] {
        let results = regex.matches(in: self, range: range)
        return results.flatMap { result -> [String] in
            let string = String(self[Range(result.range, in: self)!])
            let firstLineRange = string.lineRange(for: string.startIndex ..< string.index(after: string.startIndex))
            // Match nested text after the first line, that is where the accio comment is
            let newRange = string.index(after: firstLineRange.upperBound) ..< string.endIndex
            let newNSRange = NSRange(newRange, in: string)
            return [string] + string.nestedMatches(for: regex, in: newNSRange)
        }
    }

    /// Tells is the string matches the regex
    func matches(_ regex: NSRegularExpression) -> Bool {
        let results = regex.matches(in: self, range: NSRange(self.startIndex..., in: self))
        return !results.isEmpty
    }
}

extension NSRegularExpression {
    convenience init(_ pattern: String) {
        do {
            try self.init(pattern: pattern, options: [.caseInsensitive])
        } catch {
            preconditionFailure("Illegal regular expression: \(pattern).")
        }
    }
}
