# :arrows_counterclockwise: AsBuiltReport.Core Changelog

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
- `AsBuiltReport.Core` module created to provide core as built report functionality

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
- `New-AsbuiltConfig` cmdlet to generate a base As Built Report JSON configuration file
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
  - if `AsBuiltConfigPath` parameter is not specified, user is prompted for As Built report configuration information
  - `New-AsBuiltConfig.ps1` & `Config.json` files are no longer required
