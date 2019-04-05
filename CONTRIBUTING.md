# Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/JamitLabs/Accio. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## Getting Started

This section will tell you how you can get started contributing to Accio.

### Prerequisites

Before you start developing, please make sure you have the following tools installed on your machine:

- Xcode 10+
- [SwiftLint](https://github.com/realm/SwiftLint)

### Useful Commands

In order to generate the **Xcode project** to develop within, run this command:

```
swift package generate-xcodeproj
```

To check if all **tests** are passing correctly:

```
swift test
```

To check if the integration tests in the Demo project pass successfully:

```
cd Demo
accio update
open Demo.xcodeproj/
```

Then build & run the tests via `Cmd+U` for each of the available schemes schemes (iOS / tvOS / macOS).

To check if the **linter** shows any warnings or errors:

```
swiftlint
```

Alternatively you can also add `swiftlint` as a build script to the target `AccioKit` so warnings & errors show off right within Xcode when building. (Recommended)

### Development Tips

#### Debugging with Xcode
To run the Accio tool right from within Xcode for testing, replace the line

```swift
cli.goAndExit()
```

from the file at path `Sources/Accio/main.swift` with something like:

```swift
cli.debugGo(with: "accio update -d /Users/You/path/to/Accio/Demo -v")
```

Note that the `-d` option specified the path from within to run Accio and `-v` makes sure the logging level is set to `verbose`.

### Commit Messages

Please also try to follow the same syntax and semantic in your **commit messages** (see rationale [here](http://chris.beams.io/posts/git-commit/)).
