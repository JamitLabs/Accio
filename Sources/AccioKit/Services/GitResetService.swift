import Foundation

final class GitResetService {
    static let shared = GitResetService()

    private init() { }

    func resetGit(atPath directory: String, performfdXReset: Bool = true) throws {
        try bash("git -C '\(directory)' reset HEAD --hard --quiet 2> /dev/null")
        try bash("git -C '\(directory)' clean -fd --quiet 2> /dev/null")

        if performfdXReset {
            try bash("git -C '\(directory)' clean -fdX --quiet 2> /dev/null")
        }
    }
}
