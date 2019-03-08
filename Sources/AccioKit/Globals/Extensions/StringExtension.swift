import Foundation
import HandySwift

extension String {
    var lastPathComponent: String {
        return components(separatedBy: "/").last!
    }
}
