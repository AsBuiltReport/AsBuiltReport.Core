# :arrows_clockwise: AsBuiltReport.Core Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.5.0-RC2] - 2025-10-17

### Added
- Improve error handling for localized data import
- Add Pester tests and GitHub workflow
- Add Dependabot configuration for automated dependency updates
- Add Codecov integration for code coverage reporting
- Add comprehensive unit tests for all Private functions

### Changed
- Update GitHub Release action for new folder structures
- Update Stale workflow to mark issues stale after 60 days

## [1.5.0-RC1] - 2025-10-10

### Added
- Add multilingual support for AsBuiltReport Core module
    - `Initialize-LocalizedData` function to handle localization for both Core and Report modules
    - `Resolve-Culture` function with comprehensive culture fallback chains for 135+ culture variants
    - Localized user prompts and messages in `New-AsBuiltConfig` function. Support for all main languages.
    - `ReportLanguage` parameter added to `New-AsBuiltReport` function with dynamic validation based on available languages in individual report modules
    - Support for setting default language in report JSON configuration files using the `Report.Language` property
- Add PowerShell module dependency checking for report modules with `Get-RequiredModule` function
- Add `Draw-AsciiBanner` function to improve user interface in `New-AsBuiltConfig`
- Add `Write-ReportModuleInfo` function to provide information on report modules
- Add `SECURITY.md` and `CODE_OF_CODUCT.md` documentation
- Add `Stale.yml` GitHub workflow to manage GitHub issues
- Add `FUNDING.yml` to provide sponsorship links
- Improve error handling with comprehensive try-catch blocks and meaningful error messages

### Changed
- Core module functions (`New-AsBuiltConfig`, `New-AsBuiltReport`, `New-AsBuiltReportConfig`) now default to user's OS language instead of hardcoded English
- Report modules default to 'en-US' when no other language is supported
- Update parameter validation to use ValidateScript blocks for dynamic language detection
- Update `AsBuiltReport.Core.Style.ps1` script to support language translation
- Enhanced error messages to include specific language and module information
- Improved progress messaging during report generation
- Update all y/n prompts in `New-AsBuiltConfig` to show defaults and handle empty input
- Renamed `MFA` parameter to `UseInteractiveAuth` (`MFA` alias retained for backwards compatibility)
- Update `README.md` and `CONTRIBUTING.md` documentation
- Update `LICENSE`

# Removed
- Remove sample style scripts

## [1.4.3] - 2025-03-08

### Changed
- Updated `RequiredModules` for PScribo 0.11.1

## [1.4.2.1] - 2025-02-22

### Changed
- Update Bluesky post release action to v0.2.0

## [1.4.2] - 2025-01-30

### Fixed
- Fix password shown in plain text (Fix [#55](https://github.com/AsBuiltReport/AsBuiltReport.Core/issues/55))
- Prevent execution from Windows PowerShell ISE (Fix [#52](https://github.com/AsBuiltReport/AsBuiltReport.Core/issues/52))

## [1.4.1] - 2024-12-02

### Changed
- Update GitHub release workflow to add post to Bluesky social platform

### Fixed
- Set `$OutputFolderPath` variable as Global variable (Fix [#53](https://github.com/AsBuiltReport/AsBuiltReport.Core/issues/53))

## [1.4.0] - 2024-03-29

### Added

- Add AsBuiltReport default style script to resolve [#44](https://github.com/AsBuiltReport/AsBuiltReport.Core/issues/44)
- Add Core module version check and verbose reporting

### Changed

- Improve bug and feature request templates
- Increase actions/checkout to v4
- Update MIT License copyright year
- Code cleanup to remove outdated code and comments
- Update heading styles in sample style scripts

### Fixed

- Fix ReadMe AsBuiltReport logo URL
- Fix [#45](https://github.com/AsBuiltReport/AsBuiltReport.Core/issues/45)

## [1.3.0] - 2022-10-22

### Added
- Added two sample style scripts
### Changed
- Updated `RequiredModules` for PScribo 0.10.0
- Updated installation instructions in `README.md`
- Updated contributing guide in `CONTRIBUTING.md`
- Updated PSScriptAnalyzer settings
- Updated GitHub issue templates
- Updated comment based help for AsBuiltReport cmdlets
- Improved command functionality for macOS and Linux users

## [1.2.0] - 2022-02-11
### Added
* Added new `Token` and `MFA` parameters and subsequent parameter sets to `New-AsBuiltReport` cmdlet to allow alternative authentication methods

### Changed
* Updated GitHub Action release workflow to send automated tweets on each release
## [1.1.0] - 2020-08-16
### Changed
- Updated `New-AsBuiltReport` parameter names to provide clarity of input requirements. Aliases used to prevent breaking changes.
    - `OutputPath` now an alias for `OutputFolderPath`
    - `StylePath` now an alias for `StyleFilePath`
    - `ReportConfigPath` now an alias for `ReportConfigFilePath`
    - `AsBuiltConfigPath` now an alias for `AsBuiltConfigFilePath`
- Updated `New-AsBuiltReportConfig` parameter names to provide clarity of input requirements. Aliases used to prevent breaking changes.
    - `Path` now an alias for `FolderPath`
    - `Name` now an alias for `Filename`
    - `Overwrite` now an alias for `Force`
- Updated `RequiredModules` for PScribo 0.9.1
- Custom style scripts are now executed from `New-AsBuiltReport` to allow use of new PScribo features

### Added
- Added `Filename` parameter to `New-AsBuiltReport`
- Added error check for incorrect `AsBuiltConfigFilePath`
- Improvements to verbose logging

## [1.0.5] - 2020-07-16
### Changed
- Updated `RequiredModules` for PScribo 0.9.0

### Removed
- Removed XML format option as it is scheduled to be deprecated from PScribo

## [1.0.4] - 2020-04-01
### Added
- Added support for using the `-Verbose` switch with `New-AsBuiltReport` as per (Fix #28)

### Changed
- Updated RequiredModules for PScribo 0.8.0

### Fixed
- Fixed "Unable to determine the identity of the domain" issue. Resolved in PScribo 0.8.0 (Fix #17)

## [1.0.3] - 2020-02-27
### Changed
- Updated RequiredModules to use PScribo 0.7.26

### Fixed
- Fixed truncated tables when using text output (Fix #26)

## [1.0.2] - 2019-06-21
### Changed
- Updated module manifest icon and release notes URI

## [1.0.1] - 2019-05-17
### Added
- Added DefaultParameterSetName to `New-AsBuiltReport` so a user can run the cmdlet without any parameters
- Check if `OutputPath` parameter for `New-AsBuiltReport` exists before running the report script and error if it doesn't exist

### Fixed
- Fixed issues when multiple versions of the same AsBuiltReport report module is installed (Fix #21)

## [1.0.0] - 2019-03-26
### Added
- `AsBuiltReport.Core` module created to provide core AsBuiltReport functionality

### Changed
- `AsBuiltReport` module simply becomes a manifest to install required core and report modules
- Made `-OutputPath` parameter mandatory on `New-AsBuiltReport`, update help comments accordingly
- Resolve issue with `New-AsBuiltReportConfig` cmdlet generating custom report configuration files
- Update version to `1.0.0` for the module to signify a major release milestone

## [0.4.1] - 2019-03-16
### Changed
- Implemented `-ListAvailable` parameter on `Get-Module` validation in `New-AsBuiltReport` and `New-AsbuiltReportConfig`

## [0.4.0] - 2019-03-16
### Added
- `New-AsbuiltConfig` cmdlet to generate a base AsBuiltReport JSON configuration file
- `New-AsBuiltReport` cmdlet to generate a report JSON configuration file
- Username and Password parameters on `New-AsBuiltReport`
- Support for setting the document orientation for the output report
- ReportConfigPath parameter to `New-AsBuiltReport`

### Changed
- Full refactor of the project to support modules
- Rewrote the menu prompting process and system to analyse read-host responses
- Renamed several parameters on `New-AsBuiltReport` to be consistent and provide more meaning

## 0.3.0
### Changed
- This minor version contains a complete refactor of the project so that it is now an official PowerShell module.
- We will now aim to host this module on PSGallery in the near future to allow for easier installation and usage.

## 0.2.0
### Added
- New As-Built JSON configuration structure
  - new `AsBuiltConfigPath` parameter
  - allows unique configuration files to be created and saved
  - if `AsBuiltConfigPath` parameter is not specified, user is prompted for AsBuiltReport configuration information
  - `New-AsBuiltConfig.ps1` & `Config.json` files are no longer required
