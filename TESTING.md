# AsBuiltReport.Core Testing Guide

This document provides comprehensive information about the testing infrastructure for the AsBuiltReport.Core PowerShell module.

## Overview

The AsBuiltReport.Core module includes a complete testing suite powered by Pester 5, covering:
- **Module manifest and structure validation**
- **Unit tests** for all public functions
- **Integration tests** for module loading and dependencies
- **Code quality tests** for PowerShell best practices
- **Automated CI/CD pipeline** for continuous testing

## Quick Start

### Prerequisites

Ensure you have PowerShell 7.4 or later installed:
```powershell
$PSVersionTable.PSVersion
```

### Install Required Modules

```powershell
# Install Pester 5+
Install-Module -Name Pester -MinimumVersion 5.0.0 -Force

# Install PSScriptAnalyzer for code quality checks
Install-Module -Name PSScriptAnalyzer -Force

# Install PScribo (required by AsBuiltReport.Core)
Install-Module -Name PScribo -MinimumVersion 0.11.1 -Force
```

### Run Tests

The easiest way to run tests is using the included helper script:

```powershell
# Run all tests
.\Tests\Invoke-Tests.ps1

# Run only unit tests
.\Tests\Invoke-Tests.ps1 -TestType Unit

# Run with code coverage
.\Tests\Invoke-Tests.ps1 -CodeCoverage -ShowCodeCoverage

# Run with XML output for CI/CD
.\Tests\Invoke-Tests.ps1 -OutputFormat NUnitXml
```

## Test Structure

```
Tests/
├── AsBuiltReport.Core.Tests.ps1      # Module-level tests
├── Unit/                              # Unit tests for individual functions
│   ├── New-AsBuiltReport.Tests.ps1
│   ├── New-AsBuiltConfig.Tests.ps1
│   └── New-AsBuiltReportConfig.Tests.ps1
├── Integration/                       # Integration tests
│   └── ModuleImport.Tests.ps1
├── Quality/                           # Code quality tests
│   └── CodeQuality.Tests.ps1
└── README.md                          # Detailed test documentation
```

## Test Categories

### 1. Module Tests (`AsBuiltReport.Core.Tests.ps1`)

Tests the overall module structure and configuration:
- ✓ Module manifest validation
- ✓ Correct GUID and version
- ✓ Required dependencies (PScribo)
- ✓ Exported functions
- ✓ Module metadata (tags, URIs, etc.)
- ✓ File structure (Src/Public/Private folders)
- ✓ Language support (en-US and other locales)

### 2. Unit Tests (`Unit/`)

Tests individual functions in isolation:

#### New-AsBuiltReport Tests
- ✓ Parameter validation and types
- ✓ Parameter aliases (Target/Server/IP, etc.)
- ✓ Multiple parameter sets (Credential, Token, InteractiveAuth)
- ✓ Format validation (Word, HTML, Text)
- ✓ Orientation validation (Portrait, Landscape)
- ✓ Help documentation completeness
- ✓ Argument completers
- ✓ Error handling for invalid inputs

#### New-AsBuiltReportConfig Tests
- ✓ Mandatory parameters
- ✓ Parameter aliases
- ✓ Folder path validation
- ✓ Force/Overwrite functionality
- ✓ Help documentation
- ✓ Error handling

#### New-AsBuiltConfig Tests
- ✓ Parameter structure
- ✓ CmdletBinding verification
- ✓ Help documentation
- ✓ Output type validation

### 3. Integration Tests (`Integration/`)

Tests module integration and dependencies:
- ✓ Module imports without errors
- ✓ All public functions load correctly
- ✓ Private functions remain private
- ✓ PScribo dependency loads
- ✓ Version compatibility
- ✓ Language file loading
- ✓ Metadata validation

### 4. Quality Tests (`Quality/`)

Tests code quality and best practices:
- ✓ PowerShell syntax validation (PSParser)
- ✓ AST parsing validation
- ✓ File encoding (UTF-8)
- ✓ Comment-based help for all public functions
- ✓ CmdletBinding on all functions
- ✓ Approved PowerShell verbs
- ✓ Manifest completeness
- ✓ No wildcard exports
- ✓ Documentation files (README, CHANGELOG, LICENSE)
- ✓ Language file consistency across cultures

## CI/CD Pipeline

### Automated Testing Workflow

The module includes a dedicated GitHub Actions workflow (`.github/workflows/Tests.yml`) that:

1. **Runs on Multiple Events**
   - Push to main/dev/master branches
   - Pull requests to main/dev/master
   - Manual workflow dispatch

2. **Platform**
   - Windows Server (latest)

3. **Test Jobs**
   - **Test Job**: Runs `Tests\Invoke-Tests.ps1` with code coverage
   - **Analyze Job**: Runs PSScriptAnalyzer for code quality

4. **Artifacts**
   - Test results (NUnit XML)
   - Code coverage reports (JaCoCo XML)

### Workflow Features

- ✅ Automatic module dependency installation
- ✅ Code coverage analysis
- ✅ PSScriptAnalyzer static analysis
- ✅ Uses the same test script as local development

### Pipeline Status Badges

Add these to your README.md:

```markdown
![Tests](https://github.com/AsBuiltReport/AsBuiltReport.Core/workflows/Pester%20Tests/badge.svg)
[![codecov](https://codecov.io/gh/AsBuiltReport/AsBuiltReport.Core/branch/master/graph/badge.svg)](https://codecov.io/gh/AsBuiltReport/AsBuiltReport.Core)
```

## Running Tests Manually

### Using Invoke-Pester Directly

```powershell
# Basic test execution
Invoke-Pester -Path ./Tests

# Detailed output
Invoke-Pester -Path ./Tests -Output Detailed

# Specific test file
Invoke-Pester -Path ./Tests/Unit/New-AsBuiltReport.Tests.ps1

# With code coverage
$Config = New-PesterConfiguration
$Config.Run.Path = './Tests'
$Config.CodeCoverage.Enabled = $true
$Config.CodeCoverage.Path = './AsBuiltReport.Core/**/*.ps1'
$Config.Output.Verbosity = 'Detailed'
Invoke-Pester -Configuration $Config
```

### Using the Helper Script

```powershell
# Run all tests with detailed output
.\Tests\Invoke-Tests.ps1

# Run specific test category
.\Tests\Invoke-Tests.ps1 -TestType Unit
.\Tests\Invoke-Tests.ps1 -TestType Integration
.\Tests\Invoke-Tests.ps1 -TestType Quality

# Enable code coverage analysis
.\Tests\Invoke-Tests.ps1 -CodeCoverage -ShowCodeCoverage

# Export results to XML
.\Tests\Invoke-Tests.ps1 -OutputFormat NUnitXml
.\Tests\Invoke-Tests.ps1 -OutputFormat JUnitXml

# Combine options
.\Tests\Invoke-Tests.ps1 -TestType Unit -CodeCoverage -ShowCodeCoverage -OutputFormat NUnitXml
```

## Test Development Guidelines

### Writing New Tests

When adding new tests, follow these best practices:

1. **Use Pester 5 Syntax**
   ```powershell
   BeforeAll {
       # Setup code
   }

   Describe 'Feature Name' {
       Context 'Specific Scenario' {
           It 'Should do something specific' {
               # Test code
               $Result | Should -Be $Expected
           }
       }
   }

   AfterAll {
       # Cleanup code
   }
   ```

2. **Organize Tests Logically**
   - Place unit tests in `Tests/Unit/`
   - Place integration tests in `Tests/Integration/`
   - Place quality tests in `Tests/Quality/`

3. **Use Descriptive Names**
   ```powershell
   # Good
   It 'Should throw error when OutputFolderPath does not exist'

   # Bad
   It 'Test 1'
   ```

4. **Test Both Positive and Negative Cases**
   ```powershell
   It 'Should accept valid format parameter' {
       # Positive test
   }

   It 'Should reject invalid format parameter' {
       # Negative test
   }
   ```

5. **Clean Up After Tests**
   ```powershell
   AfterAll {
       Remove-Module -Name 'AsBuiltReport.Core' -Force -ErrorAction SilentlyContinue
       if (Test-Path $TestFolder) {
           Remove-Item -Path $TestFolder -Recurse -Force
       }
   }
   ```

6. **Mock External Dependencies**
   ```powershell
   BeforeAll {
       Mock -CommandName 'Get-ExternalData' -MockWith {
           return @{ Status = 'Success' }
       }
   }
   ```

### Test Coverage Goals

- **Overall Coverage**: Target 80%+ code coverage
- **Public Functions**: 100% parameter validation coverage
- **Critical Paths**: 100% coverage for core functionality
- **Error Handling**: All error paths should be tested

## Troubleshooting

### Common Issues

#### Tests Fail with "Module Not Found"

**Solution**: Ensure the module path is correct in your test files:
```powershell
$ModulePath = Join-Path -Path $PSScriptRoot -ChildPath '..\..\AsBuiltReport.Core\AsBuiltReport.Core.psd1'
Import-Module $ModulePath -Force
```

#### Code Coverage Shows 0%

**Solution**: Verify the coverage path includes your module files:
```powershell
$Config.CodeCoverage.Path = './AsBuiltReport.Core/**/*.ps1'
```

#### PSScriptAnalyzer Errors

**Solution**: Run PSScriptAnalyzer locally to identify issues:
```powershell
Invoke-ScriptAnalyzer -Path ./AsBuiltReport.Core -Recurse
```

#### Tests Pass Locally But Fail in CI

**Possible Causes**:
- PowerShell version differences
- Module dependencies not installed
- Platform-specific code (Windows vs Linux)
- File path case sensitivity (Linux/macOS)

**Solution**:
- Check the CI logs for specific errors
- Test on multiple platforms locally using Docker
- Ensure all dependencies are in the workflow YAML

### Debug Failed Tests

```powershell
# Run specific test with detailed output
Invoke-Pester -Path ./Tests/Unit/New-AsBuiltReport.Tests.ps1 -Output Detailed

# Run with debug output
$DebugPreference = 'Continue'
Invoke-Pester -Path ./Tests/Unit/New-AsBuiltReport.Tests.ps1

# Run single test
Invoke-Pester -Path ./Tests/Unit/New-AsBuiltReport.Tests.ps1 -FullNameFilter '*Should have Report parameter*'
```

## Performance Considerations

### Test Execution Time

- **Unit Tests**: ~10-30 seconds
- **Integration Tests**: ~5-10 seconds
- **Quality Tests**: ~30-60 seconds
- **Total Suite**: ~1-2 minutes

### Optimization Tips

1. **Use `BeforeAll` for expensive setup operations**
2. **Mock external calls to avoid network delays**
3. **Clean up resources in `AfterAll` instead of `AfterEach`**
4. **Use `-Skip` for tests that don't apply to current environment**

## Best Practices

### Do's ✅
- ✅ Write tests before fixing bugs (TDD)
- ✅ Test edge cases and boundary conditions
- ✅ Use meaningful test descriptions
- ✅ Keep tests independent and isolated
- ✅ Clean up resources after tests
- ✅ Update tests when changing functionality
- ✅ Aim for high code coverage

### Don'ts ❌
- ❌ Don't test PowerShell itself
- ❌ Don't make tests dependent on each other
- ❌ Don't use hardcoded file paths
- ❌ Don't skip cleanup steps
- ❌ Don't ignore failing tests
- ❌ Don't commit test artifacts (XML files, coverage reports)

## Resources

### Documentation
- [Pester Documentation](https://pester.dev/)
- [Pester Quick Start](https://pester.dev/docs/quick-start)
- [PSScriptAnalyzer Rules](https://github.com/PowerShell/PSScriptAnalyzer)
- [PowerShell Best Practices](https://learn.microsoft.com/en-us/powershell/scripting/developer/cmdlet/strongly-encouraged-development-guidelines)

### GitHub Actions
- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [PowerShell in GitHub Actions](https://docs.github.com/en/actions/automating-builds-and-tests/building-and-testing-powershell)

### Code Coverage
- [Codecov Documentation](https://docs.codecov.com/)
- [JaCoCo Format](https://www.jacoco.org/jacoco/trunk/doc/)

## Support

For issues, questions, or contributions:
- **Issues**: [GitHub Issues](https://github.com/AsBuiltReport/AsBuiltReport.Core/issues)
- **Discussions**: [GitHub Discussions](https://github.com/AsBuiltReport/AsBuiltReport.Core/discussions)
- **Documentation**: [AsBuiltReport.com](https://www.asbuiltreport.com/)

## License

This testing infrastructure is part of the AsBuiltReport.Core project and follows the same license.
