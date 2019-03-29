import Foundation
import Rainbow
import SwiftShell

/// The print level type.
enum PrintLevel {
    /// Print (potentially) long data or less interesting information. Only printed if tool executed in vebose mode.
    case verbose

    /// Print any kind of information potentially interesting to users.
    case info

    /// Print information that might potentially be problematic.
    case warning

    /// Print information that probably is problematic.
    case error
}

/// Prints a message to command line with proper formatting based on level, source & output target.
///
/// - Parameters:
///   - message: The message to be printed. Don't include `Error!`, `Warning!` or similar information at the beginning.
///   - level: The level of the print statement.
func print(_ message: String, level: PrintLevel) {
    if TestHelper.shared.isStartedByUnitTests {
        TestHelper.shared.printOutputs.append((message, level))
    }

    switch level {
    case .verbose:
        if GlobalOptions.verbose.value {
            print("✨ ", message.lightCyan)
        }

    case .info:
        print("✨ ", message.lightBlue)

    case .warning:
        print("⚠️ ", message.yellow)

    case .error:
        print("❌ ", message.red)
    }
}

/// Executes a bash command on the command line and shows both the executed commands and its outputs.
///
/// - Parameters:
///   - command: The bash command to be executed on the command line.
func bash(_ command: String) throws {
    if GlobalOptions.verbose.value {
        print("⏳ Executing '\(command.italic.lightYellow)'".bold)
    }

    try runAndPrint(bash: command)
}
