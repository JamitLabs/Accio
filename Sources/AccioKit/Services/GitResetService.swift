import Foundation

final class GitResetService {
    static let shared = GitResetService()

    private init() { }

    func resetGit(atPath directory: String) throws {
        try bash("git -C '\(directory)' reset HEAD --hard --quiet 2> /dev/null")
        try bash("git -C '\(directory)' clean -fd --quiet 2> /dev/null")
    }
}
