<p align="center">
    <img src="https://raw.githubusercontent.com/JamitLabs/Accio/stable/Logo.png"
      width=704>
</p>

<p align="center">
    <a href="https://app.bitrise.io/app/cf0587a25c78c7d4">
        <img src="https://app.bitrise.io/app/cf0587a25c78c7d4/status.svg?token=AlujqlsL_IVwxMLJJGPKvA&branch=stable"
             alt="Build Status">
    </a>
    <a href="https://codebeat.co/projects/github-com-jamitlabs-accio-stable">
        <img src="https://codebeat.co/badges/15b30938-aa93-4d43-a35c-e18105ea8b48"
             alt="Codebeat Badge">
    </a>
    <a href="https://github.com/JamitLabs/Accio/releases">
        <img src="https://img.shields.io/badge/Version-0.5.5-blue.svg"
             alt="Version: 0.5.5">
    </a>
    <img src="https://img.shields.io/badge/Swift-5.0-FFAC45.svg"
         alt="Swift: 5.0">
    <img src="https://img.shields.io/badge/Platforms-macOS-FF69B4.svg"
        alt="Platforms: macOS">
    <a href="https://github.com/JamitLabs/Accio/blob/stable/LICENSE">
        <img src="https://img.shields.io/badge/License-MIT-lightgrey.svg"
              alt="License: MIT">
    </a>
</p>

<p align="center">
    <a href="#installation">Installation</a>
  • <a href="#usage">Usage</a>
  • <a href="#contributing">Contributing</a>
  • <a href="#license">License</a>
</p>

# Accio

A dependency manager driven by SwiftPM that works for iOS/tvOS/watchOS/macOS projects.

## Requirements

- Xcode 10.2+ and Swift 5.0+
- Xcode Command Line Tools (see [here](http://stackoverflow.com/a/9329325/3451975) for installation instructions)
- Carthage 0.32+ (install from [here](https://github.com/Carthage/Carthage))

## Installation

### Via [Homebrew](https://brew.sh):

To **install** Accio the first time, run these commands:

```bash
brew tap JamitLabs/Accio https://github.com/JamitLabs/Accio.git
brew install accio
```

To **update** it to the latest version, run this instead:

```bash
brew upgrade accio
```

## Why should I use this?

**TL;DR**: It's an improvement over Carthage, both regarding supported features & community openness. Also, it's targeted towards official SwiftPM's support for Apple platforms.

<details>
<summary>
Detailed Explanation
</summary>

For developers on Apple platforms there are already well established dependency managers, namely [CocoaPods](https://github.com/CocoaPods/CocoaPods) & [Carthage](https://github.com/Carthage/Carthage). If you like how CocoaPods deals with things, you probably won't ever need to use Accio. It doesn't do anything that CocoaPods doesn't.

But if you are like the many developers who prefer to use Carthage because it's written in Swift (not Ruby) and it doesn't create an Xcode workspace but is rather unintrusive, you might find that Accio solves some of the problems you might have come across with Carthage. Namely:

1. Carthage doesn't support cached builds *across projects*
2. Carthage always builds *all* shared schemes of a dependency
3. You need to *manually* link/unlink dependencies at two different places (project hierarchy & copy build phase)

While for some users these missing features might not make a huge difference at all, there's also many who really suffer from them. So adding these to Carthage might sound like the most obvious step to take from here and wouldn't need yet another tool. And there actually have been attempts to tackle each of the above issues within Carthage. But Carthage doesn't have a particularly welcoming community so they all failed. Apart from the fact that the project is written in [ReactiveSwift](https://github.com/ReactiveCocoa/ReactiveSwift), which is not bad in itself but still prevents many developers from being able to contribute new features, the main maintainer(s) don't take much responsibility in the concerns of the community. Here's what I mean:

For example problem #2 is tracked in [this](https://github.com/Carthage/Carthage/issues/1227) issue since March 2016 and has many upvotes. But the maintainers seem not to care about it at all. There was even [this PR](https://github.com/Carthage/Carthage/pull/1990)  attempting to fix the issue that was very well received by the community and has (currently) 38 👍s and 14 ❤s. But after ignoring it for a year, the [main maintainers reaction](https://github.com/Carthage/Carthage/pull/1990#issuecomment-407409116) basically was "this is insufficient" and "I don't think we should solve this problem", earning 6 👎s for this comment alone. There was even an earlier approach to fix this issue in [this PR](https://github.com/Carthage/Carthage/pull/1616), but again, the main maintainer [basically said](https://github.com/Carthage/Carthage/pull/1616#issuecomment-271125684) "this is a minor case" and "Apple should fix this in Xcode".

The manual linking problem (#3) was reported several times (for example [here](https://github.com/Carthage/Carthage/issues/1131), [here](https://github.com/Carthage/Carthage/issues/2605) and [here](https://github.com/Carthage/Carthage/issues/145)). While it might have been ["an intentional design decision"](https://github.com/Carthage/Carthage/issues/145#issuecomment-64676821) at the beginning, it is nowadays agreed on to be a bad decision (even by the [main maintainer](https://github.com/Carthage/Carthage/issues/1131#issuecomment-185209513)). But there's no solution to the problem implemented as of now. The most recent attempt to *kind of* fix this was in [this PR](https://github.com/Carthage/Carthage/issues/2477) which was opened in June 2018 and didn't make any real progress since.

Problem #1 is tracked [here](https://github.com/Carthage/Carthage/issues/2400) since April 2018 and was actually tackled recently by [this PR](https://github.com/Carthage/Carthage/pull/2716). But only god knows if and when it will be merged.

The unwelcomingness (is there such a word?) of the Carthage community is so much so that developers tended to rather write another tool than to add the feature to Carthage itself. [Rome](https://github.com/blender/Rome) which attempts to fix the caching problem and [Carting](https://github.com/artemnovichkov/Carting) trying to fix the linking problem are two such examples. But more tools means higher chances that something could break over time and also complicates the configuration for both each developer and also the CI setup.

That's why Accio was designed as the all-in-one tool for any improvements you might need for managing dependencies using Carthage. It's explicitly open for new features from the community as long as they improve aspects of dependency management for the Apple developer community. Also, the implementation of Accio is pretty straight-forward, without the need to learn any reactive programming.

Additionally, the core of Accio was designed to use [SwiftPM](https://github.com/apple/swift-package-manager) as much as possible because we think it will at some point replace the need for an extra dependency manager completely. Until that time, making an open source project "Accio compliant" basically means adding a manifest file that exactly matches that of `SwiftPM`. This way Accio is trying to fill the gap between now and the time when Xcode properly supports `SwiftPM` for Apple platform projects (which we guess to be at WWDC 2020) and most Accio compatible projects might already be compatible out of the box when the time comes.

</details>

## Usage

### Getting Started

This section describes on how to get started with Accio.

### Deintegrating Carthage (optional)

If you want to migrate your Carthage-driven project to Accio, here are the steps to deintegrate Carthage:

1. Remove any linked dependency frameworks in the project hierarchy (this will automatically unlink from any targets)
2. Delete the Carthage copy build phase
3. Delete any files beginning with `Cartfile`
4. Remove the `Carthage` directory entirely
5. Remove Carthage entries like `$(PROJECT_DIR)/Carthage/Build/iOS` from the `FRAMEWORK_SEARCH_PATHS` within the build settings

### Initialization

To configure Accio in a new project, simply run the `init` command and provide both the name of the Xcode project file (without extension) and your App target(s) (separate multiple targets by a comma). For example:

```bash
accio init -p "XcodeProjectName" -t "AppTargetName"
```

This step will create a template `Package.swift` file and set some `.gitignore` entries to keep your repository clean. Please note that if your source code files aren't placed within directories named after the targets, you will need to explicitly set the `path` parameters within the targets in the `Package.swift` file to the correct paths. Also note that the specified `path` must be a directory recursively containing at least one Swift file – but mixing with other languages like (Objective-)C(++) is not supported, so they shouldn't be within the specified directory. The files in there will not be built, they just need to exist in order for SwifPM to work properly, so you could point this anywhere Swift-only code.

Please note that you should not provide any test targets with the `-t` parameter of the `init` command. Add them manually to the `Package.swift` using `.testTarget` instead of `.target` since integration of frameworks needs to be done a little differently for test targets. See [this example](https://github.com/JamitLabs/NewProjectTemplate-iOS/blob/stable/Package.swift) manifest file for an always up-to-date real world reference. Alternatively, check the Demo projects [manifest file](https://github.com/JamitLabs/Accio/blob/stable/Demo/Package.swift).

Run `accio init help` to get a list of all available options.

#### Adding Dependencies

Accio uses the [official SwiftPM manifest format](https://github.com/apple/swift-package-manager/blob/master/Documentation/PackageDescriptionV4.md) for specifying dependencies. So in order to add a dependency, you will need to do two things:

1. Add a `.package` entry to the `dependencies` array of your `Package`
2. Add all scheme/library names you want to build to the `dependencies` section of the appropriate target(s)

Here's an example `Package.swift` file with multiple dependencies specified:

```swift
// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "XcodeProjectName",
    products: [],
    dependencies: [
        .package(url: "https://github.com/Flinesoft/HandySwift.git", .upToNextMajor(from: "2.8.0")),
        .package(url: "https://github.com/Flinesoft/HandyUIKit.git", .upToNextMajor(from: "1.9.1")),
        .package(url: "https://github.com/JamitLabs/MungoHealer.git", .upToNextMajor(from: "0.3.2")),
        .package(url: "https://github.com/SwiftyBeaver/SwiftyBeaver.git", from: "1.6.2"),
        .package(url: "https://github.com/radex/SwiftyUserDefaults.git", .branch("master")),
    ],
    targets: [
        .target(
            name: "AppTargetName",
            dependencies: [
                "HandySwift",
                "HandyUIKit",
                "MungoHealer",
                "SwiftyBeaver",
                "SwiftyUserDefaults",
            ],
            path: "AppTargetName"
        ),
    ]
)
```

### Installing Dependencies

To install the dependencies, you can use either the `install` or `update` command. The only difference is, that `install` won't update any dependency versions if they were already previously resolved. `update` will always update to the latest version within the specified range. For example:

```bash
accio install
```

When running this the first time in a project, the following steps will be taken:

1. Checkout all dependencies (using [SwiftPM](https://github.com/apple/swift-package-manager)) & build them (using [Carthage](https://github.com/Carthage/Carthage))
2. Cache all build products to a local cache directory for future reuse in other projects
3. Create a folder named `Dependencies` with the build products
4. Create a group in Xcode named `Dependencies` with the build products correctly linked to the appropriate targets
5. Add a copy build script phase named `Accio` to the configured targets & update the input paths appropriately

On future runs, both `install` and `update` will make sure all these created directories & build scripts are kept up-to-date so you don't ever need to change them manually. Actually, you shouldn't change their contents, reordering is fine though.

_Please note that before running any of the install commands, you should **close your project** if you have it open in Xcode. Otherwise some unexpected problems could occur when Accio rewrites the project file._

Additionally, for both install commands you can provide a path to a **shared cache** to copy the build products to instead of the local cache. For example:

```bash
accio install -c '/Volumes/GoogleDrive/Team Share/AccioSharedCache'
```

Specifying this can drastically cut your teams total dependencies building time since each commit of a dependency will be built only once by only one person in the team.

_Please note that a **global cache** is planned to be added as an opt-in option in the near future for those who trust our CI setup regarding security. Details will follow._

Run `accio install help` or `accio update help` to get a list of all available options.

### Configuring Accio's default behavior

You can configure Accio to always **automatically** use a shared cache path without the need to specify it as an option by writing it into the Accio config file like so:

```bash
accio set-shared-cache /Volumes/GoogleDrive/TeamShare/AccioCache
```

Note that the config file is saved to `/Users/<Name>/Library/Application Support/Accio/config.json`. Simply delete it to reset all configuration options.

### Clearing local Cache

Since Accio automatically caches any build products locally on your machine, this can result in the cache taking up quite some space after a while. So you might want to clear up the local cache from time to time by running the `clear-cache` command:

```bash
accio clear-cache
```

This will remove all build products from the cache and tell you how much file size was freed up. Please note that there's currently no way of clearing a shared cache to prevent any accidental deletes by a single team member. Please do this manually if your shared space gets too filled up.

Note: There is also a `clean` command which this should not be confused with. The `clean` command will only remove the files within the `.accio` build path leading to all dependencies being freshly checked out on next install. Also it deletes any temporary leftover files from failed or cancelled runs of Accio.

## Adding support for Accio

Most libraries that are compatible with SwiftPM should automatically work with Accio. There's also a Demo project with integration tests on the CI to ensure most Swift frameworks on GitHub with [at least 1,000 stars](https://github.com/search?q=stars%3A%3E1000+language%3Aswift&type=Repositories) support Accio. Libraries that are compatible with Carthage can be easily made compatible with Accio by simply adding a `Package.swift` file similar to this:

```swift
// swift-tools-version:4.2
import PackageDescription

let package = Package(
    name: "LibraryName",
    // platforms: [.iOS("8.0"), .macOS("10.10"), .tvOS("9.0"), .watchOS("2.0")],
    products: [
        .library(name: "LibraryName", targets: ["LibraryName"])
    ],
    targets: [
        .target(
            name: "LibraryName",
            path: "LibraryName"
        )
    ]
)
```

Please note that the commented `platforms` parameter line can be uncommented if the library only supports Swift 5 or up (it was added to Swift Package Manager via [proposal SE-0236](https://github.com/apple/swift-evolution/blob/master/proposals/0236-package-manager-platform-deployment-settings.md)). But it is currently recommended to keep the line commented out for Swift 4.2 compatibility – Accio will take care of specifying the target versions manually if the line is commented out.

If the library has subdependencies, link the projects within the `dependencies` array of the target and the library names in the `dependencies` array of the targets. For example:

```swift
// swift-tools-version:4.2
import PackageDescription

let package = Package(
    name: "LibraryName",
    // platforms: [.iOS("8.0"), .macOS("10.10"), .tvOS("9.0"), .watchOS("2.0")],
    products: [
        .library(name: "LibraryName", targets: ["LibraryName"])
    ],
    dependencies: [
        .package(url: "https://github.com/Alamofire/Alamofire.git", .upToNextMajor(from: "4.1.0")),
        .package(url: "https://github.com/antitypical/Result.git", .upToNextMajor(from: "4.0.0")),
    ],
    targets: [
        .target(
            name: "LibraryName",
            dependencies: ["Alamofire", "Result"],
            path: "LibraryName"
        )
    ]
)
```

Refer to the [official Package manifest documentation](https://github.com/apple/swift-package-manager/blob/master/Documentation/PackageDescriptionV4.md) for details on how it can be configured, for example the other options for the version range specification of dependencies.

If you come across any issues with a dependency that you expect to work with Accio, please [open an issue on GitHub](https://github.com/JamitLabs/Accio/issues).

### Official Badge

[![Accio supported](https://img.shields.io/badge/Accio-supported-0A7CF5.svg?style=flat)](https://github.com/JamitLabs/Accio)

To hint that your project supports installation via Accio, add the following to the top of your `README.md`:

```markdown
[![Accio supported](https://img.shields.io/badge/Accio-supported-0A7CF5.svg?style=flat)](https://github.com/JamitLabs/Accio)
```

## Contributing

See the file [CONTRIBUTING.md](https://github.com/JamitLabs/Accio/blob/stable/CONTRIBUTING.md).

## License
This library is released under the [MIT License](http://opensource.org/licenses/MIT). See LICENSE for details.

Logo Design by [Dogan Duran](https://twitter.com/Dodu_Doodle).
