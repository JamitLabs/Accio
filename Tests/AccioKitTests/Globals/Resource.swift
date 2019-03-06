import Foundation
import HandySwift

struct Resource {
    let url: URL
    let contents: String

    var data: Data? {
        return contents.data(using: .utf8)
    }

    init(url: URL, contents: String) {
        self.url = url
        self.contents = contents
    }
}
