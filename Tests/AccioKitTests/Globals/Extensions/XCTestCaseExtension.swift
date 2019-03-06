@testable import AccioKit
import XCTest

extension XCTestCase {
    func resourcesLoaded(_ resources: [Resource], testCode: () -> Void) {
        removeResourcesIfNeeded(resources)

        for resource in resources {
            try! FileManager.default.createFile(atPath: resource.url.path, withIntermediateDirectories: true, contents: resource.data, attributes: nil)
        }

        testCode()
        removeResourcesIfNeeded(resources)
    }

    private func removeResourcesIfNeeded(_ resources: [Resource]) {
        for resource in resources {
            if FileManager.default.fileExists(atPath: resource.url.path) {
                try! FileManager.default.removeItem(atPath: resource.url.path)
            }
        }
    }
}
