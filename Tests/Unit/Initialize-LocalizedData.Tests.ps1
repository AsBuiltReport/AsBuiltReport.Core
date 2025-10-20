BeforeAll {
    # Import the module
    $ModulePath = Join-Path -Path $PSScriptRoot -ChildPath '..\..\AsBuiltReport.Core\AsBuiltReport.Core.psd1'
    Import-Module $ModulePath -Force
}

Describe 'Initialize-LocalizedData Unit Tests' {
    Context 'Function Exists' {
        It 'Should have Initialize-LocalizedData function available' {
            InModuleScope 'AsBuiltReport.Core' {
                $Function = Get-Command -Name 'Initialize-LocalizedData' -ErrorAction SilentlyContinue
                $Function | Should -Not -BeNullOrEmpty
            }
        }

        It 'Should be a CmdletBinding function' {
            InModuleScope 'AsBuiltReport.Core' {
                $Function = Get-Command -Name 'Initialize-LocalizedData'
                $Function.CmdletBinding | Should -Be $true
            }
        }
    }

    Context 'Parameter Validation' {
        It 'Should have ModuleBasePath parameter' {
            InModuleScope 'AsBuiltReport.Core' {
                $Command = Get-Command -Name 'Initialize-LocalizedData'
                $Command.Parameters.Keys | Should -Contain 'ModuleBasePath'
            }
        }

        It 'Should have LanguageFile parameter' {
            InModuleScope 'AsBuiltReport.Core' {
                $Command = Get-Command -Name 'Initialize-LocalizedData'
                $Command.Parameters.Keys | Should -Contain 'LanguageFile'
            }
        }

        It 'Should have ModuleType parameter' {
            InModuleScope 'AsBuiltReport.Core' {
                $Command = Get-Command -Name 'Initialize-LocalizedData'
                $Command.Parameters.Keys | Should -Contain 'ModuleType'
            }
        }

        It 'Should have Language parameter' {
            InModuleScope 'AsBuiltReport.Core' {
                $Command = Get-Command -Name 'Initialize-LocalizedData'
                $Command.Parameters.Keys | Should -Contain 'Language'
            }
        }

        It 'Should have ModuleName parameter' {
            InModuleScope 'AsBuiltReport.Core' {
                $Command = Get-Command -Name 'Initialize-LocalizedData'
                $Command.Parameters.Keys | Should -Contain 'ModuleName'
            }
        }

        It 'Should have ModuleBasePath as mandatory' {
            InModuleScope 'AsBuiltReport.Core' {
                $Command = Get-Command -Name 'Initialize-LocalizedData'
                $Parameter = $Command.Parameters['ModuleBasePath']
                $Parameter.Attributes.Mandatory | Should -Contain $true
            }
        }

        It 'Should have LanguageFile as mandatory' {
            InModuleScope 'AsBuiltReport.Core' {
                $Command = Get-Command -Name 'Initialize-LocalizedData'
                $Parameter = $Command.Parameters['LanguageFile']
                $Parameter.Attributes.Mandatory | Should -Contain $true
            }
        }

        It 'Should validate ModuleType values' {
            InModuleScope 'AsBuiltReport.Core' {
                $Command = Get-Command -Name 'Initialize-LocalizedData'
                $Parameter = $Command.Parameters['ModuleType']
                $ValidateSet = $Parameter.Attributes.Where({$_ -is [System.Management.Automation.ValidateSetAttribute]})
                $ValidateSet.ValidValues | Should -Contain 'Core'
                $ValidateSet.ValidValues | Should -Contain 'Report'
            }
        }
    }

    Context 'Culture Detection' {
        It 'Should use Get-Culture for Core modules without explicit language' {
            InModuleScope 'AsBuiltReport.Core' {
                Mock Write-Host { }
                Mock Test-Path { $false }
                Mock Import-LocalizedData { @{ TestKey = 'TestValue' } }
                Mock Get-Culture { [System.Globalization.CultureInfo]::GetCultureInfo('en-US') }
                Mock Resolve-Culture { @('en-US') }

                try {
                    Initialize-LocalizedData -ModuleBasePath $PSScriptRoot -LanguageFile 'TestFile' -ModuleType 'Core' -ErrorAction SilentlyContinue 2>$null
                } catch {}

                Should -Invoke Get-Culture
            }
        }

        It 'Should use specified language when provided' {
            InModuleScope 'AsBuiltReport.Core' {
                Mock Write-Host { }
                Mock Test-Path { $false }
                Mock Import-LocalizedData { @{ TestKey = 'TestValue' } }
                Mock Get-Culture { [System.Globalization.CultureInfo]::GetCultureInfo('en-US') }
                Mock Resolve-Culture { @('fr-FR') }

                try {
                    Initialize-LocalizedData -ModuleBasePath $PSScriptRoot -LanguageFile 'TestFile' -Language 'fr-FR' -ErrorAction SilentlyContinue 2>$null
                } catch {}

                Should -Invoke Resolve-Culture -ParameterFilter { $CultureName -eq 'fr-FR' }
            }
        }
    }
}

AfterAll {
    Remove-Module -Name 'AsBuiltReport.Core' -Force -ErrorAction SilentlyContinue
    Remove-Variable -Name 'translate' -Scope Global -ErrorAction SilentlyContinue
    Remove-Variable -Name 'AsBuiltReportLocalizedWarnings' -Scope Global -ErrorAction SilentlyContinue
}
