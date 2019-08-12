import Foundation

/// Possible errors thrown by the ManifestCommentsHandlerService
enum ManifestCommentsHandlerError: Error, Equatable {
    case targetNameCouldNotBeParsed(string: String)
    case invalidValue(key: CommentArgument, value: String, possibleValues: [String])
    case dependencyNameWasFoundBeforeEnum(comment: String, dependencyName: String)
    case multipleSpecificationsForTheSameDependency(key: CommentArgument, dependencyName: String, specifications: [String])
}

/// The possible commented arguments that are supported
enum CommentArgument: String {
    case defaultLinkage
    case customLinkage
    case defaultIntegration
    case customIntegration
}

/// A convenient enum containing logic related with regular expressions
private enum Regex {
    /// Pattern to detect the start of a target
    static let targetPattern = #"( *)\.target\("#
    /// Pattern that matches all text that follows the same level of indentation
    static let sameIndentationPattern = #"(\n\1.*)*"#
    /// Pattern that matches a comment
    static let commentPattern = #" *// *"#
    /// Pattern with a group that, when matching, returns the textual part of an enum object
    static let enumGroupPattern = #"\.(\w*)"#
    /// Pattern with a group that, when matching, returns all the matched content
    static let anythingGroupPattern = #"([^\s].*)"#
    /// Regex matching all text at the same indentation level than a target declaration
    static let targetContent = NSRegularExpression("\(targetPattern).*\(sameIndentationPattern)")
    /// Regex with a group that, when matching, returns the target name
    static let targetName = NSRegularExpression(argumentPattern("name") + #""(.*)""#)
    /// Regex that matches the defaultLinkage comment
    static let defaultLinkage = NSRegularExpression(
        commentPattern + argumentPattern(CommentArgument.defaultLinkage.rawValue) + enumGroupPattern
    )
    /// Regex that matches the defaultIntegration comment
    static let defaultIntegration = NSRegularExpression(
        commentPattern + argumentPattern(CommentArgument.defaultIntegration.rawValue) + enumGroupPattern
    )
    /// Regex that matches the customLinkage comment
    static let customLinkage = NSRegularExpression(
        commentPattern + argumentPattern(CommentArgument.customLinkage.rawValue) + anythingGroupPattern
    )
    /// Regex that matches the cutomIntegration comment
    static let cutomIntegration = NSRegularExpression(
        commentPattern + argumentPattern(CommentArgument.customIntegration.rawValue) + anythingGroupPattern
    )
    /// Function that generates a pattern to match a swift function argument
    static func argumentPattern(_ argument: String) -> String {
        return "\(argument) *: *"
    }
}

/// A service that handles all logic related with parsing all the information from the manifest that is passed as accio comments
final class ManifestCommentsHandlerService {
    static let shared = ManifestCommentsHandlerService(workingDirectory: GlobalOptions.workingDirectory.value ?? FileManager.default.currentDirectoryPath)

    private let workingDirectory: URL

    /// A property that stores the result from parsing the comments on the manifest
    private var commentsInformation: [CommentInformation]?

    /// A function that fetches result from parsing the comments on the manifest
    func getCommentsInformation() throws -> [CommentInformation] {
        if let commentsInformation = commentsInformation {
            return commentsInformation
        } else {
            let commentsInformation = try parseManifestComments()
            self.commentsInformation = commentsInformation
            return commentsInformation
        }
    }

    init(workingDirectory: String) {
        self.workingDirectory = URL(fileURLWithPath: workingDirectory)
    }

    /// Convenient function to obtain the linkage information for a dependency
    func linkage(for dependencyName: String, in targetName: String) throws -> LinkageType {
        let targetInformation = try getCommentsInformation()
            .filter { $0.targetName == targetName }
            .first
        return targetInformation?.customLinkage[dependencyName] ?? targetInformation?.defaultLinkage ?? .default
    }

    /// Convenient function to obtain the integration information for a dependency
    func integration(for dependencyName: String, in targetName: String) throws -> IntegrationType {
        let targetInformation = try getCommentsInformation()
            .filter { $0.targetName == targetName }
            .first
        return targetInformation?.customIntegration[dependencyName] ?? targetInformation?.defaultIntegration ?? .binary
    }

    /// Main entry point for the parsing process
    private func parseManifestComments() throws -> [CommentInformation] {
        let rawCommentInformation = try parsingStepOne()
        return try parsingStepTwo(rawCommentInformation)
    }

    /// Step one of the parsing: get a type safe representation of the information in the comments
    private func parsingStepOne() throws -> [RawCommentInformation] {
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

            return RawCommentInformation(
                targetName: targetName,
                defaultLinkage: defaultLinkage,
                customLinkage: customLinkage,
                defaultIntegration: defaultIntegration,
                customIntegration: customIntegration
            )
        }
    }

    /// Parses a string containing the value for the custom parameters
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

    /// Step two of the parsing: get the final type safe representation of the information in the comments
    private func parsingStepTwo(_ rawCommentInformations: [RawCommentInformation]) throws -> [CommentInformation] {
        return try rawCommentInformations.map { rawCommentInformation in
            let defaultLinkage: LinkageType? = try initializeEnumFrom(
                string: rawCommentInformation.defaultLinkage,
                key: .defaultLinkage
            )

            let defaultIntegration: IntegrationType? = try initializeEnumFrom(
                string: rawCommentInformation.defaultIntegration,
                key: .defaultIntegration
            )

            let customLinkage: [String: LinkageType] = try parseCustomValues(
                rawCommentInformation.customLinkage,
                key: .customLinkage
            )

            let customIntegration: [String: IntegrationType] = try parseCustomValues(
                rawCommentInformation.customIntegration,
                key: .customIntegration
            )

            return CommentInformation(
                targetName: rawCommentInformation.targetName,
                defaultLinkage: defaultLinkage,
                customLinkage: customLinkage,
                defaultIntegration: defaultIntegration,
                customIntegration: customIntegration
            )
        }
    }

    /// Parses the raw information about custom parameters, returning a dictionary that matches the dependency
    /// name with the corresponding enum
    func parseCustomValues<T: RawRepresentable & CaseIterable>(
        _ rawCustomValues: [(enum: String, values: [String])],
        key: CommentArgument
        ) throws -> [String: T] where T.RawValue == String {
        var result: [String: T] = [:]
        try rawCustomValues.forEach { rawCustomValue in
            guard let enumValue = T.init(rawValue: rawCustomValue.enum) else {
                throw ManifestCommentsHandlerError.invalidValue(
                    key: key,
                    value: rawCustomValue.enum,
                    possibleValues: T.allCases.map { "\($0)" }
                )
            }
            try rawCustomValue.values.forEach { dependencyName in
                if let existingValue = result[dependencyName], existingValue == enumValue {
                    throw ManifestCommentsHandlerError.multipleSpecificationsForTheSameDependency(
                        key: key,
                        dependencyName: dependencyName,
                        specifications: T.allCases.map { "\($0)" }
                    )
                }
                result[dependencyName] = enumValue
            }
        }
        return result
    }

    /// Initializes an enum from a string, and throws if the operation fails
    private func initializeEnumFrom<T: RawRepresentable & CaseIterable>(
        string: String?,
        key: CommentArgument
        ) throws -> T? where T.RawValue == String {
        if let rawValue = string {
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

// MARK: types used during the comment parsing process

/// A struct holding the information in the comments inside the manifest
struct CommentInformation: Equatable {
    let targetName: String
    let defaultLinkage: LinkageType?
    let customLinkage: [String: LinkageType]
    let defaultIntegration: IntegrationType?
    let customIntegration: [String: IntegrationType]
}

/// A struct holding the information in the comments inside the manifest, in primitive types (String)
private struct RawCommentInformation {
    let targetName: String
    let defaultLinkage: String?
    let customLinkage: [(enum: String, values: [String])]
    let defaultIntegration: String?
    let customIntegration: [(enum: String, values: [String])]
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

// MARK: convenient extensions

// Extension based on https://stackoverflow.com/questions/25329186/safe-bounds-checked-array-lookup-in-swift-through-optional-bindings
private extension Collection {
    /// Returns the element at the specified index if it is within bounds, otherwise nil
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

    /// Returns the strings matching inside the regex groups
    func groupMatches(for regex: NSRegularExpression) -> [[String]] {
        let result = regex.matches(in: self, range: NSRange(self.startIndex..., in: self))
        return result.map { match in
            (1 ..< match.numberOfRanges).map {
                let rangeBounds = match.range(at: $0)
                guard let range = Range(rangeBounds, in: self) else {
                    fatalError("The range did not match the string that generated it. This must never happen")
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
