import Foundation
import SwiftShell

final class ManifestHandlerService {
    static let shared = ManifestHandlerService(workingDirectory: GlobalOptions.workingDirectory.value ?? FileManager.default.currentDirectoryPath)

    private let workingDirectory: String

    init(workingDirectory: String) {
        self.workingDirectory = workingDirectory
    }

    func loadManifest(isDependency: Bool) throws -> Manifest {
        print("Reading package manifest at \(workingDirectory)/Package.swift ...", level: isDependency ? .verbose : .info)
        let contextSpecifiers = "--package-path '\(workingDirectory)' --build-path '\(workingDirectory)/\(Constants.buildPath)'"
        let manifestJson = run(bash: "swift package \(contextSpecifiers) dump-package").stdout
        return try JSONDecoder.swiftPM.decode(Manifest.self, from: manifestJson.data(using: .utf8)!)
    }

    func createManifestFromDefaultTemplateIfNeeded(projectName: String, targetNames: [String]) throws {
        let packageManifestPath = URL(fileURLWithPath: workingDirectory).appendingPathComponent("Package.swift").path

        if FileManager.default.fileExists(atPath: packageManifestPath) {
            guard let manifestContents = try? String(contentsOfFile: packageManifestPath), manifestContents.isBlank else {
                print("A non-empty Package.swift file already exists, skipping template based creation.", level: .warning)
                return
            }

            try FileManager.default.removeItem(atPath: packageManifestPath)
        }

        let targetsContents = try self.targetsContents(workingDirectory: workingDirectory, projectName: projectName, targetNames: targetNames)
        let manifestTemplate = self.manifestTemplate(projectName: projectName, targetsContents: targetsContents)

        FileManager.default.createFile(atPath: packageManifestPath, contents: manifestTemplate.data(using: .utf8), attributes: nil)
        print("Created manifest file Package.swift from template.", level: .info)
    }

    private func manifestTemplate(projectName: String, targetsContents: String) -> String {
        return """
            // swift-tools-version:5.0
            import PackageDescription

            let package = Package(
                name: \"\(projectName)\",
                products: [],
                dependencies: [
                    // add your dependencies here, for example:
                    // .package(url: \"https://github.com/User/Project.git\", .upToNextMajor(from: \"1.0.0\")),
                ],
                targets: [
            \(targetsContents)    ]
            )

            """
    }

    private func targetsContents(workingDirectory: String, projectName: String, targetNames: [String]) throws -> String {
        return try targetNames.reduce("") { result, targetName in
            let targetTypeDetectorService = TargetTypeDetectorService(workingDirectory: workingDirectory)
            let targetType: AppTarget.TargetType = try targetTypeDetectorService.detectTargetType(ofTarget: targetName, in: projectName)
            return result + """
                        .\(targetType.packageSpecifier)(
                            name: \"\(targetName)\",
                            dependencies: [
                                // add your dependencies scheme names here, for example:
                                // \"Project\",
                            ],
                            path: \"\(targetName)\"
                        ),

                """
        }
    }
}
