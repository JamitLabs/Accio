# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/) and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## [0.3.0]
### Added
- None.
### Changed
- Add support for Swift 5 and Xcode 10.2.
- Separate cached frameworks by Swift tools version.
### Deprecated
- None.
### Removed
- Drop support for Swift 4.2 and Xcode <=10.1.
### Fixed
- None.
### Security
- None.

## [0.2.2]
### Fixed
- Fixed an issue with some frameworks sym-linking to themselves.

## [0.2.1]
### Added
- Support for setting a default `shared-cache-path` via configuration.
- New sub command `set-shared-cache` for setting the shared cache path.
### Fixed
- Also correctly recognize scheme names like "SwiftyBeaver (iOS)".

## [0.2.0]
### Added
- Initial working release with `init`, `install`, `update`, `clean` and `clear-cache` sub commands
