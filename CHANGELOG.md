# AsBuiltReport.Core Changelog

## [1.0.3] - 2020-02-27
### Changed
- Updated RequiredModules to use PScribo 0.7.26

### Fixed
- Fixed truncated tables when using text output (Fix #26)

### Added
- Added support for using the -Verbose switch with New-AsBuiltReport as per [Issue 28](https://github.com/AsBuiltReport/AsBuiltReport.Core/issues/28)

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