import Foundation
import SwiftShell

/// Possible errors thrown by the ManifestCommentsHandlerService
enum ManifestCommentsHandlerError: Error, Equatable {
    case sameKeyAppearsMoreThanOnceInTheSameComment(comment: String, count: Int)
    case keyWithoutValue(comment: String, key: CommentKey)
    case invalidValue(comment: String, key: CommentKey, value: String, possibleValues: [String])
    case commentWithoutKnownKeys(comment: String, possibleKeys: [String])
}

/// A convenient enum containing logic related with regular expressions
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

    private var cachedManifestComments: [ManifestComment]?
    /// Manifest comments. Fetched once and cached
    func manifestComments() throws -> [ManifestComment] {
        if cachedManifestComments == nil {
            cachedManifestComments = try loadManifestComments()
        }
        return cachedManifestComments!
    }
    
    private var cachedAdditionalConfiguration: [String: AdditionalConfiguration] = [:]
    /// Additional configuration per dependency. Fetched once and cached
    func additionalConfiguration(for dependencyName: String) throws -> AdditionalConfiguration {
        if cachedAdditionalConfiguration[dependencyName] == nil {
            var additionalConfiguration = AdditionalConfiguration.default
            for manifestComment in try manifestComments() {
                switch manifestComment {
                case let .productType(productType, dependencies):
                    if dependencies.contains(dependencyName) {
                        additionalConfiguration.productType = productType
                    }

                case let .integrationType(integrationType, dependencies):
                    if dependencies.contains(dependencyName) {
                        additionalConfiguration.integrationType = integrationType
                    }
                }
            }
            cachedAdditionalConfiguration[dependencyName] = additionalConfiguration
        }
        return cachedAdditionalConfiguration[dependencyName]!
    }

    /// Returns all the information from the manifest that is passed as accio comments
    private func loadManifestComments() throws -> [ManifestComment] {
        let packageManifestPath = workingDirectory.appendingPathComponent("Package.swift")
        let packageManifestContent = try String(contentsOf: packageManifestPath)
        let matches = packageManifestContent.nestedMatches(for: Regex.accioComment)
        let comments: [RawComment] = matches.map {
            var lines = $0.lines()
            let firstLine = lines.removeFirst()
            return RawComment(header: firstLine.trimmingCharacters(in: .whitespaces), content: lines.joined(separator: "\n"))
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
    /// The line containing the accio comment
    let header: String
    /// The lines at the same indentation level as the header
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
        let value = try getValue(from: comment.header)

        switch self {
        case .productType:
            guard let productType = ProductType(rawValue: value) else {
                throw ManifestCommentsHandlerError.invalidValue(
                    comment: comment.header,
                    key: self,
                    value: value,
                    possibleValues: ProductType.allCases.map { $0.rawValue }
                )
            }

            let dependencies = Regex.parseQuotedStrings(comment.content)
            return ManifestComment.productType(productType: productType, dependencies: dependencies)

        case .integrationType:
            guard let integrationType = IntegrationType(rawValue: value) else {
                throw ManifestCommentsHandlerError.invalidValue(
                    comment: comment.header,
                    key: self,
                    value: value,
                    possibleValues: IntegrationType.allCases.map { $0.rawValue }
                )
            }

            let dependencies = Regex.parseQuotedStrings(comment.content)
            return ManifestComment.integrationType(integrationType: integrationType, dependencies: dependencies)
        }
    }

    /// Extracts the value for a key from the string
    private func getValue(from string: String) throws -> String {
        let regex = NSRegularExpression(pattern)
        let matches = string.matches(for: regex)
        guard let match = matches.first else {
            throw ManifestCommentsHandlerError.keyWithoutValue(comment: string, key: self)
        }

        guard matches.count == 1 else {
            throw ManifestCommentsHandlerError.sameKeyAppearsMoreThanOnceInTheSameComment(comment: string, count: matches.count)
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

/// MARK: convenient extensions to work with regular expressions

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
