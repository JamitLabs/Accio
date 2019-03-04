import Foundation

final class ManifestReaderService {
    static let shared = ManifestReaderService()

    func frameworksToBuild() -> [Framework] {
        // TODO: read the Package.swift file and check what targets were set for the App target, skip all non-specified targets
        return []
    }
}
