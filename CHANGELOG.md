# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/) and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## [Unreleased]
### Added
- None.
### Changed
- None.
### Deprecated
- None.
### Removed
- None.
### Fixed
- None.
### Security
- None.

## [0.5.3] - 2019-04-01
### Added
- None.
### Changed
- None.
### Deprecated
- None.
### Removed
- None.
### Fixed
- Fixes an issue where recursive copies of non symbolic links could cause build errors.
### Security
- None.

## [0.5.2] - 2019-04-01
### Added
- None.
### Changed
- None.
### Deprecated
- None.
### Removed
- None.
### Fixed
- Keep symlinks in cached ZIP files for macOS support.
### Security
- None.

## [0.5.1] - 2019-03-31
### Added
- None.
### Changed
- Check if shared cache path is available, else add new build products to local cache.
### Deprecated
- None.
### Removed
- None.
### Fixed
- Fixed an issue with copying unzipped cache build products back to project.
### Security
- None.


## [0.5.0] - 2019-03-30
### Added
- Demo project for integration testing with popular Swift frameworks.
### Changed
- Compress cached build products in a .zip file. Old style cached build products can be deleted.
### Deprecated
- None.
### Removed
- None.
### Fixed
- Multiple issues with paths, names, symbolic links & more.
### Security
- None.

## [0.4.0] - 2019-03-29
### Added
- Add support for test targets.
- Sort `Dependencies` group alphabetically.
### Changed
- Change structure of `Dependencies` folder.
- Delete unneeded groups & references from `Dependencies` group.
- Delete unneeded files & folders from `Dependencies` folder.
- Only link frameworks when not already linked.
- Unlink frameworks that are no longer included.
- Don't save build products to local cache if shared cache is available.
- Cleanup Accio run script phase when target gets removed.
### Deprecated
- None.
### Removed
- None.
### Fixed
- Fix typo in local cache logging.
- Fix missing use of `Constants.xcodeDependenciesGroup` & `Constants.dependenciesPath`.
### Security
- None.

## [0.3.0] - 2019-03-26
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
