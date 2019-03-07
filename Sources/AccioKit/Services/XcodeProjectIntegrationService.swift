import Foundation

final class XcodeProjectIntegrationService {
    static let shared = XcodeProjectIntegrationService()

    func updateDependencies(with frameworkProductsPerTarget: [Target: [FrameworkProduct]]) throws {
        try copyDependencies(from: frameworkProductsPerTarget)
        linkFrameworks()
        updateBuildPhase()
    }

    func copyDependencies(from frameworkProductsPerTarget: [Target: [FrameworkProduct]]) throws {
        for (target, frameworkProducts) in frameworkProductsPerTarget {
            let dependenciesPlatformPath = "\(Constants.dependenciesPath)/\(target.platform.rawValue)"
            try bash("mkdir -p \(dependenciesPlatformPath)")

            for frameworkProduct in frameworkProducts {
                let frameworkDirPath = "\(dependenciesPlatformPath)/\(frameworkProduct.frameworkDirUrl.lastPathComponent)"
                let symbolsFilePath = "\(dependenciesPlatformPath)/\(frameworkProduct.symbolsFileUrl.lastPathComponent)"

                try bash("cp -R \(frameworkProduct.frameworkDirPath) \(frameworkDirPath)")
                try bash("cp -R \(frameworkProduct.symbolsFilePath) \(symbolsFilePath)")
            }
        }
    }

    func linkFrameworks() {
        // TODO: link frameworks in App target
    }

    func updateBuildPhase() {
        // TODO: update Carthage copy build phase
    }
}
