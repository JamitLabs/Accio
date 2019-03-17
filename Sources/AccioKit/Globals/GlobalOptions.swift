import SwiftCLI

public enum GlobalOptions {
    static let verbose = Flag("-v", "--verbose", description: "Prints more detailed information about the executed command")
    static let workingDirectory = Key<String>("-d", "--working-directory", description: "The directory to run the subcommand within")

    public static var all: [Option] {
        return [verbose, workingDirectory]
    }
}
