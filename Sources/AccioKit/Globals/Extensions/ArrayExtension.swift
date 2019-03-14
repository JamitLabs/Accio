import Foundation
import xcodeproj

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
