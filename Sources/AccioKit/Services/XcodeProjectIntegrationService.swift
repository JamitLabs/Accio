import Foundation

final class XcodeProjectIntegrationService {
    static let shared = XcodeProjectIntegrationService()

    func updateDependencies(with frameworkProductsPerTarget: [String: [FrameworkProduct]]) throws {
        // TODO: copy the framework products to the Constants.dependenciesPath directory
        // TODO: link frameworks in App target
        // TODO: update Carthage copy build phase
    }
}
