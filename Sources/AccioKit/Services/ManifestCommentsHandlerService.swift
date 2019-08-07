import Foundation

/// Possible errors thrown by the ManifestCommentsHandlerService
enum ManifestCommentsHandlerError: Error, Equatable {
    case targetNameCouldNotBeParsed(string: String)
    case invalidValue(key: CommentKey, value: String, possibleValues: [String])
    case dependencyNameWasFoundBeforeEnum(comment: String, dependencyName: String)
    case multipleSpecificationsForTheSameDependency(key: CommentKey, dependencyName: String, specifications: [String])
}

enum CommentKey: String {
    case defaultLinkage
    case customLinkage
    case defaultIntegration
    case customIntegration
}

/// A convenient enum containing logic related with regular expressions
private enum Regex {
    /// Pattern to detect the start of a target
    static let targetPattern = #"( *)\.target\("#
    /// Capture all text that follows the same level of indentation
    static let sameIndentationPattern = #"(\n\1.*)*"#
    /// Regex matching all text at the same indentation level than a target declaration
    static let targetContent = NSRegularExpression("\(targetPattern).*\(sameIndentationPattern)")

    static let enumGroupPattern = #"\.(\w*)"#
    static let commentPattern = #" *// *"#
    static let anythingGroupPattern = #"([^\s].*)"#

    static let targetName = NSRegularExpression(argumentPattern("name") + #""(.*)""#)
    static let defaultLinkage = NSRegularExpression(
        commentPattern + argumentPattern(CommentKey.defaultLinkage.rawValue) + enumGroupPattern
    )
    static let defaultIntegration = NSRegularExpression(
        commentPattern + argumentPattern(CommentKey.defaultIntegration.rawValue) + enumGroupPattern
    )
    static let customLinkage = NSRegularExpression(
        commentPattern + argumentPattern(CommentKey.customLinkage.rawValue) + anythingGroupPattern
    )
    static let cutomIntegration = NSRegularExpression(
        commentPattern + argumentPattern(CommentKey.customIntegration.rawValue) + anythingGroupPattern
    )

    static func argumentPattern(_ argument: String) -> String {
        return "\(argument) *: *"
    }
    // defaultLinking: .static,

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
    private var targetsInformation: [Information]?
    private func getTargetsInformation() throws -> [Information] {
        if let targetsInformation = targetsInformation {
            return targetsInformation
        } else {
            let targetsInformation = try parseManifestComments()
            self.targetsInformation = targetsInformation
            return targetsInformation
        }
    }

    init(workingDirectory: String) {
        self.workingDirectory = URL(fileURLWithPath: workingDirectory)
    }

    func linkage(for dependencyName: String, in targetName: String) throws -> LinkageType {
        let targetInformation = try getTargetsInformation()
            .filter { $0.targetName == targetName }
            .first
        return targetInformation?.customLinkage[dependencyName] ?? targetInformation?.defaultLinkage ?? .default
    }

    func integration(for dependencyName: String, in targetName: String) throws -> IntegrationType {
        let targetInformation = try getTargetsInformation()
            .filter { $0.targetName == targetName }
            .first
        return targetInformation?.customIntegration[dependencyName] ?? targetInformation?.defaultIntegration ?? .binary
    }

    func parseManifestComments() throws -> [Information] {
        let rawTargetInformation = try getRawInformation()
        return try getInformation(rawTargetInformation)
    }

    private func getRawInformation() throws -> [RawInformation] {
        let packageManifestPath = workingDirectory.appendingPathComponent("Package.swift")
        let packageManifestContent = try String(contentsOf: packageManifestPath)
        let targetsContent = packageManifestContent.matches(for: Regex.targetContent)
        return try targetsContent.map {
            guard let targetName = $0.groupMatches(for: Regex.targetName).flatMap({ $0 }).first else {
                throw ManifestCommentsHandlerError.targetNameCouldNotBeParsed(string: $0)
            }
            let defaultLinkage = $0.groupMatches(for: Regex.defaultLinkage).flatMap { $0 }.first

            let defaultIntegration = $0.groupMatches(for: Regex.defaultIntegration).flatMap { $0 }.first

            let rawCustomLinkage = $0.groupMatches(for: Regex.customLinkage).flatMap { $0 }.first
            let customLinkage = try parseCustomRawValues(rawCustomLinkage)

            let rawCustomIntegration = $0.groupMatches(for: Regex.cutomIntegration).flatMap { $0 }.first
            let customIntegration = try parseCustomRawValues(rawCustomIntegration)

            return RawInformation(
                targetName: targetName,
                defaultLinkage: defaultLinkage,
                customLinkage: customLinkage,
                defaultIntegration: defaultIntegration,
                customIntegration: customIntegration
            )
        }
    }

    private func parseCustomRawValues(_ string: String?) throws -> [(enum: String, values: [String])] {
        guard let string = string else {
            return []
        }

        let strings = string.components(separatedBy: [",", ":"]).map {
            $0.replacingOccurrences(of: "\"", with: "")
                .replacingOccurrences(of: "[", with: "")
                .replacingOccurrences(of: "]", with: "")
                .trimmingCharacters(in: .whitespacesAndNewlines)
            }.filter { $0.isEmpty == false }

        var result: [(enum: String, values: [String])] = []
        try strings.forEach {
            if $0.hasPrefix(".") {
                result.append((enum: $0.replacingOccurrences(of: ".", with: ""), values: []))
            } else {
                if result.isEmpty == false {
                    result[result.endIndex - 1].values.append($0)
                } else {
                    throw ManifestCommentsHandlerError.dependencyNameWasFoundBeforeEnum(comment: string, dependencyName: $0)
                }
            }
        }

        return result
    }

    private func getInformation(_ rawInformation: [RawInformation]) throws -> [Information] {
        return try rawInformation.map { targetInformation in
            let defaultLinkage: LinkageType? = try initializeFromRaw(
                rawValue: targetInformation.defaultLinkage,
                key: .defaultLinkage
            )

            let defaultIntegration: IntegrationType? = try initializeFromRaw(
                rawValue: targetInformation.defaultIntegration,
                key: .defaultIntegration
            )

            let customLinkage: [String: LinkageType] = try parseCustomValues(
                targetInformation.customLinkage,
                key: .customLinkage
            )

            let customIntegration: [String: IntegrationType] = try parseCustomValues(
                targetInformation.customIntegration,
                key: .customIntegration
            )

            return Information(
                targetName: targetInformation.targetName,
                defaultLinkage: defaultLinkage,
                customLinkage: customLinkage,
                defaultIntegration: defaultIntegration,
                customIntegration: customIntegration
            )
        }
    }

    func parseCustomValues<T: RawRepresentable & CaseIterable>(
        _ values: [(enum: String, values: [String])],
        key: CommentKey
        ) throws -> [String: T] where T.RawValue == String {
        var result: [String: T] = [:]
        try values.forEach {
            guard let enumValue = T.init(rawValue: $0.enum) else {
                throw ManifestCommentsHandlerError.invalidValue(
                    key: key,
                    value: $0.enum,
                    possibleValues: T.allCases.map { "\($0)" }
                )
            }
            try $0.values.forEach {
                if let existingValue = result[$0], existingValue == enumValue {
                    throw ManifestCommentsHandlerError.multipleSpecificationsForTheSameDependency(
                        key: key,
                        dependencyName: $0,
                        specifications: T.allCases.map { "\($0)" }
                    )
                }
                result[$0] = enumValue
            }
        }
        return result
    }

    private func initializeFromRaw<T: RawRepresentable & CaseIterable>(
        rawValue: String?,
        key: CommentKey
        ) throws -> T? where T.RawValue == String {
        if let rawValue = rawValue {
            if let value = T.init(rawValue: rawValue) {
                return value
            } else {
                throw ManifestCommentsHandlerError.invalidValue(
                    key: key,
                    value: rawValue,
                    possibleValues: T.allCases.map { "\($0)" }
                )
            }
        }
        return nil
    }
}

private struct RawInformation {
    let targetName: String
    let defaultLinkage: String?
    let customLinkage: [(enum: String, values: [String])]
    let defaultIntegration: String?
    let customIntegration: [(enum: String, values: [String])]
}

struct Information: Equatable {
    let targetName: String
    let defaultLinkage: LinkageType?
    let customLinkage: [String: LinkageType]
    let defaultIntegration: IntegrationType?
    let customIntegration: [String: IntegrationType]
}

/// The type of linkage to use
enum LinkageType: String, CaseIterable {
    /// Use the linkage that the author of the dependency has configured
    case `default`
    /// Use static linkage
    // case `static` = "static" // TODO: implentation in the future
    /// Use dynamic linkage
    // case dynamic = "dynamic" // TODO: implentation in the future
}

/// The type of integration to be used when adding the dependencies to the Xcode project
enum IntegrationType: String, CaseIterable {
    /// Adding the dependencies to the Xcode project as already compiled binaries (the option by default)
    case binary
    /// Adding the dependencies to the Xcode project as source code
    // case source // TODO: implentation in the future
    /// Adding the dependencies to a cocoapods setup (using the compiled binaries, not source code)
    // case cocoapods // TODO: implentation in the future
}

// Extension based on https://stackoverflow.com/questions/25329186/safe-bounds-checked-array-lookup-in-swift-through-optional-bindings
private extension Collection {
    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
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
            print(firstLineRange)
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

    /// Returns the strings matching inside the regex groups
    func groupMatches(for regex: NSRegularExpression) -> [[String]] {
        let result = regex.matches(in: self, range: NSRange(self.startIndex..., in: self))
        return result.map { match in
            (1 ..< match.numberOfRanges).map {
                let rangeBounds = match.range(at: $0)
                guard let range = Range(rangeBounds, in: self) else {
                    return ""
                }
                return String(self[range])
            }
        }
    }
}

private extension NSRegularExpression {
    convenience init(_ pattern: String) {
        do {
            try self.init(pattern: pattern, options: [.caseInsensitive])
        } catch {
            preconditionFailure("Illegal regular expression: \(pattern).")
        }
    }
}
