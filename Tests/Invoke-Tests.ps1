<#
.SYNOPSIS
    Helper script to run AsBuiltReport.Core Pester tests locally.

.DESCRIPTION
    This script provides an easy way to run Pester tests for the AsBuiltReport.Core module.
    It handles module installation, test execution, and result reporting.

.PARAMETER TestType
    Specifies which tests to run. Options: All, Unit, Integration, Quality
    Default: All

.PARAMETER CodeCoverage
    Enable code coverage analysis.

.PARAMETER OutputFormat
    Specifies the output format for test results. Options: Console, NUnitXml, JUnitXml
    Default: Console

.PARAMETER ShowCodeCoverage
    Display code coverage results after test execution.

.EXAMPLE
    .\Invoke-Tests.ps1
    Runs all tests with console output.

.EXAMPLE
    .\Invoke-Tests.ps1 -TestType Unit
    Runs only unit tests.

.EXAMPLE
    .\Invoke-Tests.ps1 -CodeCoverage -ShowCodeCoverage
    Runs all tests with code coverage analysis and displays coverage report.

.EXAMPLE
    .\Invoke-Tests.ps1 -TestType Quality -OutputFormat NUnitXml
    Runs quality tests and exports results to NUnit XML format.
#>

[CmdletBinding()]
param(
    [Parameter()]
    [ValidateSet('All', 'Unit', 'Integration', 'Quality')]
    [string]$TestType = 'All',

    [Parameter()]
    [switch]$CodeCoverage,

    [Parameter()]
    [ValidateSet('Console', 'NUnitXml', 'JUnitXml')]
    [string]$OutputFormat = 'Console',

    [Parameter()]
    [switch]$ShowCodeCoverage
)

# Set strict mode
Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

# Script variables
$ScriptRoot = Split-Path -Path $PSScriptRoot -Parent
$TestsPath = $PSScriptRoot
$ModulePath = Join-Path -Path $ScriptRoot -ChildPath 'AsBuiltReport.Core'

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "  AsBuiltReport.Core Test Runner" -ForegroundColor Cyan
Write-Host "========================================`n" -ForegroundColor Cyan

# Check if Tests directory exists
if (-not (Test-Path $TestsPath)) {
    Write-Error "Tests directory not found at: $TestsPath"
    exit 1
}

# Check PowerShell version
Write-Host "PowerShell Version: $($PSVersionTable.PSVersion)" -ForegroundColor Yellow

# Check if running in PowerShell 7+
if ($PSVersionTable.PSVersion.Major -lt 7) {
    Write-Warning "These tests are designed for PowerShell 7+. You are running PowerShell $($PSVersionTable.PSVersion). Some tests may fail."
}

# Install required modules
Write-Host "`nChecking required modules..." -ForegroundColor Cyan

$RequiredModules = @(
    @{ Name = 'Pester'; MinimumVersion = '5.0.0' }
    @{ Name = 'PSScriptAnalyzer'; MinimumVersion = '1.0.0' }
    @{ Name = 'PScribo'; MinimumVersion = '0.11.1' }
)

foreach ($Module in $RequiredModules) {
    $InstalledModule = Get-Module -ListAvailable -Name $Module.Name |
        Where-Object { $_.Version -ge [Version]$Module.MinimumVersion } |
        Sort-Object Version -Descending |
        Select-Object -First 1

    if ($InstalledModule) {
        Write-Host "  [OK] $($Module.Name) v$($InstalledModule.Version)" -ForegroundColor Green
    } else {
        Write-Host "  [MISSING] $($Module.Name) (minimum version: $($Module.MinimumVersion))" -ForegroundColor Yellow
        Write-Host "  Installing $($Module.Name)..." -ForegroundColor Yellow

        try {
            Install-Module -Name $Module.Name -MinimumVersion $Module.MinimumVersion -Force -SkipPublisherCheck -Scope CurrentUser
            Write-Host "  [OK] $($Module.Name) installed" -ForegroundColor Green
        } catch {
            Write-Error "Failed to install $($Module.Name): $_"
            exit 1
        }
    }
}

# Import Pester
Import-Module Pester -MinimumVersion 5.0.0 -Force

# Determine test path based on TestType
$TestPath = switch ($TestType) {
    'Unit' { Join-Path -Path $TestsPath -ChildPath 'Unit' }
    'Integration' { Join-Path -Path $TestsPath -ChildPath 'Integration' }
    'Quality' { Join-Path -Path $TestsPath -ChildPath 'Quality' }
    'All' { $TestsPath }
}

if (-not (Test-Path $TestPath)) {
    Write-Warning "Test path not found: $TestPath"
    Write-Host "Creating directory: $TestPath"
    New-Item -Path $TestPath -ItemType Directory -Force | Out-Null
}

Write-Host "`nTest Configuration:" -ForegroundColor Cyan
Write-Host "  Test Type: $TestType" -ForegroundColor White
Write-Host "  Test Path: $TestPath" -ForegroundColor White
Write-Host "  Code Coverage: $($CodeCoverage.IsPresent)" -ForegroundColor White
Write-Host "  Output Format: $OutputFormat" -ForegroundColor White

# Configure Pester
$PesterConfiguration = New-PesterConfiguration

# Set test path
$PesterConfiguration.Run.Path = $TestPath
$PesterConfiguration.Run.PassThru = $true
$PesterConfiguration.Output.Verbosity = 'Detailed'

# Configure code coverage
if ($CodeCoverage) {
    $PesterConfiguration.CodeCoverage.Enabled = $true
    # Get all .ps1 and .psm1 files in the module (excluding Tests directory)
    $CoverageFiles = Get-ChildItem -Path $ModulePath -Include '*.ps1', '*.psm1' -Recurse | Where-Object { $_.FullName -notmatch '\\Tests\\' }
    if ($CoverageFiles) {
        $PesterConfiguration.CodeCoverage.Path = $CoverageFiles.FullName
        $PesterConfiguration.CodeCoverage.OutputFormat = 'JaCoCo'
        $PesterConfiguration.CodeCoverage.OutputPath = Join-Path -Path $ScriptRoot -ChildPath 'coverage.xml'
    } else {
        Write-Warning "No files found for code coverage analysis in: $ModulePath"
        $CodeCoverage = $false
        $PesterConfiguration.CodeCoverage.Enabled = $false
    }
}

# Configure test results output
if ($OutputFormat -ne 'Console') {
    $PesterConfiguration.TestResult.Enabled = $true
    $PesterConfiguration.TestResult.OutputFormat = $OutputFormat
    $OutputFileName = "testResults.$(if ($OutputFormat -eq 'NUnitXml') { 'xml' } else { 'xml' })"
    $PesterConfiguration.TestResult.OutputPath = Join-Path -Path $ScriptRoot -ChildPath $OutputFileName
}

# Run Pester tests
Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "  Running Tests" -ForegroundColor Cyan
Write-Host "========================================`n" -ForegroundColor Cyan

try {
    $TestResults = Invoke-Pester -Configuration $PesterConfiguration
} catch {
    Write-Error "Test execution failed: $_"
    exit 1
}

# Display results summary
Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "  Test Results Summary" -ForegroundColor Cyan
Write-Host "========================================`n" -ForegroundColor Cyan

Write-Host "Total Tests:  $($TestResults.TotalCount)" -ForegroundColor White
Write-Host "Passed:       $($TestResults.PassedCount)" -ForegroundColor Green
Write-Host "Failed:       $($TestResults.FailedCount)" -ForegroundColor $(if ($TestResults.FailedCount -gt 0) { 'Red' } else { 'Green' })
Write-Host "Skipped:      $($TestResults.SkippedCount)" -ForegroundColor Yellow
Write-Host "Not Run:      $($TestResults.NotRunCount)" -ForegroundColor Gray

if ($TestResults.Duration) {
    Write-Host "Duration:     $($TestResults.Duration.ToString('mm\:ss\.fff'))" -ForegroundColor White
}

# Display failed tests
if ($TestResults.FailedCount -gt 0) {
    Write-Host "`n========================================" -ForegroundColor Red
    Write-Host "  Failed Tests" -ForegroundColor Red
    Write-Host "========================================`n" -ForegroundColor Red

    foreach ($FailedTest in $TestResults.Failed) {
        Write-Host "  $($FailedTest.ExpandedName)" -ForegroundColor Red
        if ($FailedTest.ErrorRecord) {
            Write-Host "    Error: $($FailedTest.ErrorRecord.Exception.Message)" -ForegroundColor Yellow
        }
    }
}

# Display code coverage
if ($CodeCoverage -and $ShowCodeCoverage) {
    Write-Host "`n========================================" -ForegroundColor Cyan
    Write-Host "  Code Coverage" -ForegroundColor Cyan
    Write-Host "========================================`n" -ForegroundColor Cyan

    $Coverage = $TestResults.CodeCoverage
    if ($Coverage) {
        # Pester 5 CodeCoverage object structure
        # The coverage info is displayed by Pester itself during test run
        # We can access: CoveragePercent, AnalyzedFiles, ExecutedCommands, MissedCommands

        try {
            if ($Coverage.CoveragePercent) {
                $CoveragePercent = [math]::Round($Coverage.CoveragePercent, 2)
                $CoverageColor = if ($CoveragePercent -ge 80) { 'Green' } elseif ($CoveragePercent -ge 60) { 'Yellow' } else { 'Red' }
                Write-Host "Coverage:       $CoveragePercent%" -ForegroundColor $CoverageColor
            }

            if ($Coverage.AnalyzedFiles) {
                Write-Host "Files Analyzed: $($Coverage.AnalyzedFiles.Count)" -ForegroundColor White
            }

            if ($Coverage.MissedCommands) {
                $MissedCount = $Coverage.MissedCommands.Count
                Write-Host "Missed Commands: $MissedCount" -ForegroundColor $(if ($MissedCount -eq 0) { 'Green' } else { 'Yellow' })
            }
        } catch {
            Write-Host "Code coverage was enabled. See output above for details." -ForegroundColor Cyan
        }
    } else {
        Write-Host "No code coverage data available" -ForegroundColor Yellow
    }
}

# Display output file locations
if ($OutputFormat -ne 'Console') {
    Write-Host "`n========================================" -ForegroundColor Cyan
    Write-Host "  Output Files" -ForegroundColor Cyan
    Write-Host "========================================`n" -ForegroundColor Cyan

    $OutputFile = Join-Path -Path $ScriptRoot -ChildPath $OutputFileName
    if (Test-Path $OutputFile) {
        Write-Host "Test Results: $OutputFile" -ForegroundColor White
    }

    if ($CodeCoverage) {
        $CoverageFile = Join-Path -Path $ScriptRoot -ChildPath 'coverage.xml'
        if (Test-Path $CoverageFile) {
            Write-Host "Code Coverage: $CoverageFile" -ForegroundColor White
        }
    }
}

# Exit with appropriate code
Write-Host ""
if ($TestResults.FailedCount -eq 0) {
    Write-Host "All tests passed!" -ForegroundColor Green
    exit 0
} else {
    Write-Host "Some tests failed!" -ForegroundColor Red
    exit 1
}
