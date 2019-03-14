import Foundation

extension Array where Element == Framework {
    /// Flattens frameworks including subdependencies returns all in correct build order.
    func flattenedDeepFirstOrder() -> [Framework] {
        return flatMap { $0.requiredFrameworks.flattenedDeepFirstOrder() + [$0] }
    }
}
