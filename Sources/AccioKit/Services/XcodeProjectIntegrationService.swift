import Foundation
import PathKit
import xcodeproj

enum XcodeProjectIntegrationError: Error {
    case targetNotFound
}

final class XcodeProjectIntegrationService {
    static let shared = XcodeProjectIntegrationService(workingDirectory: FileManager.default.currentDirectoryPath)

    private let workingDirectory: String

    init(workingDirectory: String) {
        self.workingDirectory = workingDirectory
    }

    func updateDependencies(of target: Target, in projectName: String, with frameworkProducts: [FrameworkProduct]) throws {
        let dependenciesPlatformPath = "\(workingDirectory)/\(Constants.dependenciesPath)/\(target.platform.rawValue)"
        let copiedFrameworkProducts: [FrameworkProduct] = try copyFrameworkProducts(frameworkProducts, to: dependenciesPlatformPath)
        try linkFrameworks(copiedFrameworkProducts, with: target, in: projectName)
        try updateBuildPhase(of: target, in: projectName, with: copiedFrameworkProducts)
    }

    private func copyFrameworkProducts(_ frameworkProducts: [FrameworkProduct], to targetPath: String) throws -> [FrameworkProduct] {
        try bash("mkdir -p \(targetPath)")
        var copiedFrameworkProducts: [FrameworkProduct] = []

        for frameworkProduct in frameworkProducts {
            let frameworkDirPath = "\(targetPath)/\(frameworkProduct.frameworkDirUrl.lastPathComponent)"
            let symbolsFilePath = "\(targetPath)/\(frameworkProduct.symbolsFileUrl.lastPathComponent)"

            try bash("cp -R \(frameworkProduct.frameworkDirPath) \(frameworkDirPath)")
            try bash("cp -R \(frameworkProduct.symbolsFilePath) \(symbolsFilePath)")

            copiedFrameworkProducts.append(FrameworkProduct(frameworkDirPath: frameworkDirPath, symbolsFilePath: symbolsFilePath))
        }

        return copiedFrameworkProducts
    }

    private func linkFrameworks(_ frameworkProducts: [FrameworkProduct], with target: Target, in projectName: String) throws {
        let xcodeProjectPath = "\(workingDirectory)/\(projectName).xcodeproj"
        let projectFile = try XcodeProj(path: Path(xcodeProjectPath))

        guard let targetObject = projectFile.pbxproj.targets(named: target.name).first else {
            print("Could not find any target named '\(target.name)' at Xcode project path '\(xcodeProjectPath)'.", level: .error)
            throw XcodeProjectIntegrationError.targetNotFound
        }

        // TODO: not yet implemented
    }

    private func updateBuildPhase(of target: Target, in projectName: String, with frameworkProducts: [FrameworkProduct]) throws {
        let xcodeProjectPath = "\(workingDirectory)/\(projectName).xcodeproj"
        let projectFile = try XcodeProj(path: Path(xcodeProjectPath))

        guard let targetObject = projectFile.pbxproj.targets(named: target.name).first else {
            print("Could not find any target named '\(target.name)' at Xcode project path '\(xcodeProjectPath)'.", level: .error)
            throw XcodeProjectIntegrationError.targetNotFound
        }

        // TODO: not yet implemented
    }
}
