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

## [0.6.4] - 2019-09-01
### Fixed
- Adjusted the bundle version fallback to support both macOS and iOS frameworks
  Issue: [#76](https://github.com/JamitLabs/Accio/issues/76) | PR: [#77](https://github.com/JamitLabs/Accio/pull/77) | Author: [Torsten Curdt](https://github.com/tcurdti)

## [0.6.3] - 2019-07-12
### Fixed
- Fix mixed caching of frameworks with different Swift versions.  
  Issue: [#61](https://github.com/JamitLabs/Accio/issues/61) | PR: [#62](https://github.com/JamitLabs/Accio/pull/62) | Author: [Frederick Pietschmann](https://github.com/fredpi)
- Fix missing CFBundleVersion in Info.plist of build Frameworks by adding it implicity with the default value "1"
  Issue: [#69](https://github.com/JamitLabs/Accio/issues/69) | PR: [#70](https://github.com/JamitLabs/Accio/pull/70) | Author: [Murat Yilmaz](https://github.com/mrylmz)

## [0.6.2] - 2019-06-20
### Fixed
- Redownload dependencies as a fallback when previously checked out repositories are broken.  
  Issue: [#27](https://github.com/JamitLabs/Accio/issues/27) | PR: [#40](https://github.com/JamitLabs/Accio/pull/40) | Author: [Frederick Pietschmann](https://github.com/fredpi)
- Avoid misleading output when building via Carthage.  
  Issue: [#56](https://github.com/JamitLabs/Accio/issues/56) | PR: [#57](https://github.com/JamitLabs/Accio/pull/57) | Author: [Frederick Pietschmann](https://github.com/fredpi)
- Warn properly when no schemes can be found.  
  PR: [#59](https://github.com/JamitLabs/Accio/pull/59) | Author: [Frederick Pietschmann](https://github.com/fredpi)
- Remove duplicated processing of frameworks referenced by multiple other frameworks.  
  Issue: [#51](https://github.com/JamitLabs/Accio/issues/51) | PR: [#53](https://github.com/JamitLabs/Accio/pull/53) | Author: [Frederick Pietschmann](https://github.com/fredpi)

## [0.6.1] - 2019-04-26
### Added
- Adds several popular GitHub projects for official integration support testing to the Demo project.  
  PR: [#10](https://github.com/JamitLabs/Accio/pull/10) | Author: [Cihat Gündüz](https://github.com/Dschee)
### Fixed
- Fixes an issue where two or more targets for the same platform would cause project linking issues.  
  Issue: [#29](https://github.com/JamitLabs/Accio/issues/29) | PR: [#34](https://github.com/JamitLabs/Accio/pull/34) | Author: [Murat Yilmaz](https://github.com/mrylmz)
- Fixes an issue where temporary changes to SwiftPM-only frameworks would be reset before building.  
  Issue: [#35](https://github.com/JamitLabs/Accio/issues/35) | PR: [#36](https://github.com/JamitLabs/Accio/pull/36) | Author: [Cihat Gündüz](https://github.com/Dschee)

## [0.6.0] - 2019-04-19
### Added
- Correctly recognizes App Extensions and doesn't add build phases for them. Fixes [#25](https://github.com/JamitLabs/Accio/issues/25).
- Points to detailed information about conflicting name issues with SwiftPM. Fixes [#26](https://github.com/JamitLabs/Accio/issues/26).
- The `init` command now properly detects test targets and lists them as such in the created manifest file. Fixes [#23](https://github.com/JamitLabs/Accio/issues/23).
### Changed
- Improves reading of supported deployment targets.
- Improves init command by treating empty manifest files like non-existing ones. Fixes [#24](https://github.com/JamitLabs/Accio/issues/24).
### Fixed
- Fixes an issue where Accio commands where failing when Git resets failed.
- Fixes an issue where Accio didn't reset changed files untracked by Git.

## [0.5.6] - 2019-04-09
### Added
- Adds support for automatically finding schemes named like 'MBProgressHUD Framework tvOS'.
### Changed
- Some improvements that make the output information on the console more precise.
### Fixed
- Fixes the broken cleanup command of temporary frameworks after completing install.
- Fixes an issue with multiple targets linking a single framework with schemes named after their platforms.
- Fixes an issue with different platform specifiers used in scheme names.

## [0.5.5] - 2019-04-05
### Changed
- The framework copy build phase now optimizes "dirty" build timing by specifying the output files. [#13](https://github.com/JamitLabs/Accio/issues/13)
### Fixed
- Fixes an issue where broken previous install attempt leftovers cause errors on subsequent installs. [#12](https://github.com/JamitLabs/Accio/issues/12)

## [0.5.4] - 2019-04-03
### Fixed
- Fix symbolic linking of .framework and .dSYM files.

## [0.5.3] - 2019-04-01
### Fixed
- Fixes an issue where recursive copies of non symbolic links could cause build errors.

## [0.5.2] - 2019-04-01
### Fixed
- Keep symlinks in cached ZIP files for macOS support.

## [0.5.1] - 2019-03-31
### Changed
- Check if shared cache path is available, else add new build products to local cache.
### Fixed
- Fixed an issue with copying unzipped cache build products back to project.

## [0.5.0] - 2019-03-30
### Added
- Demo project for integration testing with popular Swift frameworks.
### Changed
- Compress cached build products in a .zip file. Old style cached build products can be deleted.
### Fixed
- Multiple issues with paths, names, symbolic links & more.

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
### Fixed
- Fix typo in local cache logging.
- Fix missing use of `Constants.xcodeDependenciesGroup` & `Constants.dependenciesPath`.

## [0.3.0] - 2019-03-26
### Changed
- Add support for Swift 5 and Xcode 10.2.
- Separate cached frameworks by Swift tools version.
### Removed
- Drop support for Swift 4.2 and Xcode <=10.1.

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
