# AsBuiltReport.Core Tests

This directory contains comprehensive Pester tests for the AsBuiltReport.Core PowerShell module.

## Test Structure

The tests are organized into the following categories:

### Root Level Tests
- **AsBuiltReport.Core.Tests.ps1**: Main module-level tests including manifest validation, module structure, and exported functions

### Unit Tests (`Unit/`)
Unit tests focus on individual functions in isolation:
- **New-AsBuiltReport.Tests.ps1**: Tests for the main report generation function
- **New-AsBuiltReportConfig.Tests.ps1**: Tests for report configuration creation
- **New-AsBuiltConfig.Tests.ps1**: Tests for As Built configuration creation

### Integration Tests (`Integration/`)
Integration tests verify that components work together correctly:
- **ModuleImport.Tests.ps1**: Tests module loading, dependencies, and initialization

### Quality Tests (`Quality/`)
Quality tests ensure code meets standards and best practices:
- **CodeQuality.Tests.ps1**: Tests for code structure, syntax, documentation, and PowerShell best practices

## Running Tests

### Prerequisites
Ensure you have the following modules installed:
```powershell
Install-Module -Name Pester -MinimumVersion 5.0.0 -Force
Install-Module -Name PSScriptAnalyzer -Force
Install-Module -Name PScribo -MinimumVersion 0.11.1 -Force
```

### Using the Invoke-Tests Helper Script (Recommended)
The easiest way to run tests is using the included helper script:
```powershell
# Run all tests
.\Tests\Invoke-Tests.ps1

# Run specific test category
.\Tests\Invoke-Tests.ps1 -TestType Unit
.\Tests\Invoke-Tests.ps1 -TestType Integration
.\Tests\Invoke-Tests.ps1 -TestType Quality

# Run with code coverage
.\Tests\Invoke-Tests.ps1 -CodeCoverage -ShowCodeCoverage

# Export results to XML
.\Tests\Invoke-Tests.ps1 -OutputFormat NUnitXml
```

### Run Tests Manually with Invoke-Pester
```powershell
# Run all tests with default configuration
Invoke-Pester -Path ./Tests

# Run all tests with detailed output
Invoke-Pester -Path ./Tests -Output Detailed

# Run specific test categories
Invoke-Pester -Path ./Tests/Unit
Invoke-Pester -Path ./Tests/Integration
Invoke-Pester -Path ./Tests/Quality
```

### Run with Code Coverage
```powershell
$PesterConfiguration = New-PesterConfiguration
$PesterConfiguration.Run.Path = './Tests'
$PesterConfiguration.CodeCoverage.Enabled = $true
$PesterConfiguration.CodeCoverage.Path = './AsBuiltReport.Core/**/*.ps1'
$PesterConfiguration.CodeCoverage.OutputFormat = 'JaCoCo'
$PesterConfiguration.CodeCoverage.OutputPath = './coverage.xml'
$PesterConfiguration.Output.Verbosity = 'Detailed'

Invoke-Pester -Configuration $PesterConfiguration
```

### Run with Test Results Export
```powershell
$PesterConfiguration = New-PesterConfiguration
$PesterConfiguration.Run.Path = './Tests'
$PesterConfiguration.TestResult.Enabled = $true
$PesterConfiguration.TestResult.OutputFormat = 'NUnitXml'
$PesterConfiguration.TestResult.OutputPath = './testResults.xml'
$PesterConfiguration.Output.Verbosity = 'Detailed'

Invoke-Pester -Configuration $PesterConfiguration
```

## Continuous Integration

The tests are automatically run on every push and pull request via GitHub Actions. See `.github/workflows/Tests.yml` for the CI/CD pipeline configuration.

### CI/CD Pipeline Features
- **Windows Testing**: Tests run on Windows Server (latest)
- **Uses Invoke-Tests.ps1**: Same script developers use locally
- **Code Coverage**: Automatic code coverage analysis and reporting
- **PSScriptAnalyzer**: Static code analysis for PowerShell best practices
- **Test Result Artifacts**: Test results and coverage uploaded as artifacts

## Test Coverage

The test suite covers:

### Module Structure
- Module manifest validation
- File structure and organization
- Required dependencies
- Version information
- Module metadata

### Public Functions
- Parameter validation
- Parameter aliases
- Help documentation
- Argument completers
- Function behavior
- Error handling

### Code Quality
- PowerShell syntax validation
- Best practices compliance
- Comment-based help
- Approved verb usage
- Language file consistency
- Documentation completeness

### Integration
- Module import/export
- Dependency loading
- Language support
- Function availability

## Writing New Tests

When adding new tests, follow these guidelines:

1. **Use Pester 5 syntax**: Use `BeforeAll`, `It`, `Should` syntax
2. **Organize by category**: Place tests in appropriate folders (Unit, Integration, Quality)
3. **Use descriptive names**: Test names should clearly describe what is being tested
4. **Include cleanup**: Use `AfterAll` to clean up resources
5. **Mock external dependencies**: Use `Mock` for external calls
6. **Test both success and failure paths**: Include positive and negative test cases

### Example Test Template
```powershell
BeforeAll {
    $ModulePath = Join-Path -Path $PSScriptRoot -ChildPath '..\..\AsBuiltReport.Core\AsBuiltReport.Core.psd1'
    Import-Module $ModulePath -Force
}

Describe 'YourFunction Tests' {
    Context 'Parameter Validation' {
        It 'Should have expected parameter' {
            $Command = Get-Command -Name 'YourFunction'
            $Command.Parameters.Keys | Should -Contain 'ParameterName'
        }
    }

    Context 'Function Behavior' {
        It 'Should return expected output' {
            # Your test here
        }
    }
}

AfterAll {
    Remove-Module -Name 'AsBuiltReport.Core' -Force -ErrorAction SilentlyContinue
}
```

## Test Results

Test results are available in multiple formats:
- **Console Output**: Real-time test execution feedback
- **NUnit XML**: Compatible with most CI/CD systems
- **JaCoCo XML**: Code coverage reporting format
- **GitHub Actions Summary**: Visual test results in GitHub UI

## Troubleshooting

### Tests Fail Locally But Pass in CI
- Ensure you have the same PowerShell version (7.4)
- Check module dependencies are installed
- Clear PowerShell module cache: `Remove-Module -Name AsBuiltReport.Core -Force`

### Code Coverage Not Generated
- Verify Pester 5.0+ is installed: `Get-Module -ListAvailable Pester`
- Check file paths in coverage configuration
- Ensure tests are actually executing functions in the module

### PSScriptAnalyzer Errors
- Review PSScriptAnalyzer settings in `.github/workflows/PSScriptAnalyzerSettings.psd1`
- Run locally: `Invoke-ScriptAnalyzer -Path ./AsBuiltReport.Core -Recurse`
- Fix issues identified or update suppression rules if needed

## Contributing

When contributing to AsBuiltReport.Core:
1. Add tests for new functionality
2. Ensure all tests pass before submitting PR
3. Maintain or improve code coverage
4. Follow PowerShell best practices
5. Update this README if adding new test categories

## Resources

- [Pester Documentation](https://pester.dev/)
- [PSScriptAnalyzer Rules](https://github.com/PowerShell/PSScriptAnalyzer)
- [PowerShell Best Practices](https://learn.microsoft.com/en-us/powershell/scripting/developer/cmdlet/strongly-encouraged-development-guidelines)
