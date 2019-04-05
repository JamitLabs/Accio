import AccioKit
import Foundation
import SwiftCLI

// MARK: - CLI
let cli = CLI(name: "accio", version: "0.5.5", description: "A dependency manager driven by SwiftPM that works for iOS/tvOS/watchOS/macOS projects.")

cli.commands = [InitCommand(), InstallCommand(), UpdateCommand(), CleanCommand(), ClearCacheCommand(), SetSharedCacheCommand()]
cli.globalOptions.append(contentsOf: GlobalOptions.all)
cli.goAndExit()
