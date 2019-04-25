import Foundation
import XcodeProj

extension Array where Element == Framework {
    /// Flattens frameworks including subdependencies returns all in correct build order.
    func flattenedDeepFirstOrder() -> [Framework] {
        return flatMap { $0.requiredFrameworks.flattenedDeepFirstOrder() + [$0] }
    }
}

extension Array where Element == PBXFileElement {
    mutating func removeDuplicates() {
        var uniqElements: [PBXFileElement] = []

        for element in self {
            if !uniqElements.contains(where: { $0.name == element.name }) {
                uniqElements.append(element)
            }
        }

        self = uniqElements
    }
}

extension Array where Element == FrameworkProduct {
    func removingDuplicates() -> [FrameworkProduct] {
        var uniqElements: [FrameworkProduct] = []

        for element in self {
            if !uniqElements.contains(where: { $0.frameworkDirPath == element.frameworkDirPath }) {
                uniqElements.append(element)
            }
        }

        return uniqElements
    }
}
