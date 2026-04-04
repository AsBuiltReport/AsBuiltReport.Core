# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Is

AsBuiltReport.Core is a PowerShell module that provides the core framework for generating as-built infrastructure documentation (Word/HTML/Text). It is a dependency required by all individual report modules (e.g., `AsBuiltReport.VMware.vSphere`). The primary document engine is [PScribo](https://github.com/iainbrighton/PScribo) (minimum v0.11.1).

## Commands

### Running Tests

```powershell
# Run all tests
.\Tests\Invoke-Tests.ps1

# Run a specific test category
.\Tests\Invoke-Tests.ps1 -TestType Unit
.\Tests\Invoke-Tests.ps1 -TestType Integration
.\Tests\Invoke-Tests.ps1 -TestType Quality

# Run a single test file directly
Invoke-Pester -Path ./Tests/Unit/New-AsBuiltReport.Tests.ps1

# Run a single test by name filter
Invoke-Pester -Path ./Tests/Unit/New-AsBuiltReport.Tests.ps1 -FullNameFilter '*Should have Report parameter*'

# Run with code coverage
.\Tests\Invoke-Tests.ps1 -CodeCoverage -ShowCodeCoverage
```

### Code Quality (PSScriptAnalyzer)

```powershell
# Run PSScriptAnalyzer (uses settings in .github/workflows/PSScriptAnalyzerSettings.psd1)
Invoke-ScriptAnalyzer -Path ./AsBuiltReport.Core -Recurse -Settings ./.github/workflows/PSScriptAnalyzerSettings.psd1
```

### Install Required Modules

```powershell
Install-Module -Name Pester -MinimumVersion 5.0.0 -Force
Install-Module -Name PSScriptAnalyzer -Force
Install-Module -Name PScribo -MinimumVersion 0.11.1 -Force
```

## Architecture

### Module Loading (`AsBuiltReport.Core/AsBuiltReport.Core.psm1`)

The psm1 dot-sources all `.ps1` files from `Src/Public/` and `Src/Private/`, then exports only the public ones. Two private functions — `Write-ReportModuleInfo` and `Get-RequiredModule` — are additionally promoted to the global scope so that individual report modules can call them without importing them directly.

### Public Functions (`Src/Public/`)

- **`New-AsBuiltReport`** — Main entry point. Loads the report module, initializes localization, applies styling, and invokes the report via PScribo.
- **`New-AsBuiltConfig`** — Interactive menu-driven wizard to create the global AsBuiltReport JSON config file (author, email, company, output path, SMTP settings).
- **`New-AsBuiltReportConfig`** — Creates a report-specific JSON config file (InfoLevels, Options, etc.) for a given report module.

### Private Functions (`Src/Private/`)

- **`Initialize-LocalizedData`** — Loads the correct `.psd1` language file into `$global:translate` based on culture with a fallback chain. For Core module UI, uses the user's OS culture (`Get-Culture`). For report modules, defaults to `en-US` unless `ReportLanguage` is specified.
- **`Resolve-Culture`** — Returns the ordered fallback chain for a given culture name (e.g., `fr-CA` → `fr-FR` → `en-US`).
- **`Write-ReportModuleInfo`** — Writes report module version/info output at report start.
- **`Get-RequiredModule`** — Validates that required PowerShell modules are installed for a given report.
- **`Draw-AsciiBanner`** — Renders the ASCII banner at startup.

### Localization (`Language/`)

Each locale folder (e.g., `Language/en-US/`, `Language/fr-FR/`) contains `.psd1` files named after the functions they translate:
- `New-AsBuiltReport.psd1`
- `New-AsBuiltConfig.psd1`
- `New-AsBuiltReportConfig.psd1`
- `AsBuiltReportCoreStyle.psd1`

When adding a new language string, add keys to **all** locale `.psd1` files (at minimum `en-US`). The `Initialize-LocalizedData` function loads translations into `$global:translate` for use throughout the module.

### Test Structure (`Tests/`)

- `Unit/` — Tests for individual functions; these are isolated and fast.
- `Integration/` — Tests module import, public/private function availability, and PScribo dependency.
- `Quality/` — PSScriptAnalyzer, syntax validation, UTF-8 encoding, help completeness, approved verbs, and language file consistency across all locales.
- `AsBuiltReport.Core.Tests.ps1` — Module manifest validation (GUID, version, exports, metadata).
- `Invoke-Tests.ps1` — Wrapper script used both locally and in CI.

## Coding Standards

- Follow the [PowerShell Best Practices and Style Guide](https://github.com/PoshCode/PowerShellPracticeAndStyle).
- Use PascalCasing for all public function names and parameters.
- All functions must have `[CmdletBinding()]` and comment-based help.
- New helper functions belong in `Src/Private/`; do not define functions inside report scripts.
- PSScriptAnalyzer excluded rules are defined in `.github/workflows/PSScriptAnalyzerSettings.psd1` — do not suppress rules outside that file.

## Branch and PR Workflow

- All pull requests target the `dev` branch (not `master`).
- Update `CHANGELOG.md` with added/changed/fixed/removed entries following [Keep a Changelog](https://keepachangelog.com/) conventions.
- CI runs on push/PR via GitHub Actions: Pester tests (`.github/workflows/Pester.yml`) and PSScriptAnalyzer (`.github/workflows/PSScriptAnalyzer.yml`).
