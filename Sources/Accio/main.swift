import AccioKit
import Foundation
import SwiftCLI

// MARK: - CLI
let cli = CLI(name: "accio", version: "0.1.0", description: "A dependency manager driven by SwiftPM that works for iOS/tvOS/watchOS/macOS projects.")

cli.commands = [InitCommand(), InstallCommand(), UpdateCommand(), CleanCommand()]
cli.globalOptions.append(contentsOf: GlobalOptions.all)
cli.goAndExit()
//cli.debugGo(with: "accio update -d /Users/Arbeit/Code/GitLab/EFFIT/FitterYOU-iOS -v")
