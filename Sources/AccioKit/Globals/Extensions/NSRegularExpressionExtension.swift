import Foundation

// See: https://www.hackingwithswift.com/articles/108/how-to-use-regular-expressions-in-swift

extension NSRegularExpression {
    func matches(_ string: String) -> Bool {
        let range = NSRange(location: 0, length: string.utf16.count)
        return firstMatch(in: string, options: [], range: range) != nil
    }
}
