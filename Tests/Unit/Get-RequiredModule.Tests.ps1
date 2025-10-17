BeforeAll {
    # Import the module
    $ModulePath = Join-Path -Path $PSScriptRoot -ChildPath '..\..\AsBuiltReport.Core\AsBuiltReport.Core.psd1'
    Import-Module $ModulePath -Force
}

Describe 'Get-RequiredModule Unit Tests' {
    Context 'Function Exists' {
        It 'Should have Get-RequiredModule function available' {
            InModuleScope 'AsBuiltReport.Core' {
                $Function = Get-Command -Name 'Get-RequiredModule' -ErrorAction SilentlyContinue
                $Function | Should -Not -BeNullOrEmpty
            }
        }

        It 'Should be a CmdletBinding function' {
            InModuleScope 'AsBuiltReport.Core' {
                $Function = Get-Command -Name 'Get-RequiredModule'
                $Function.CmdletBinding | Should -Be $true
            }
        }
    }

    Context 'Parameter Validation' {
        It 'Should have Name parameter' {
            InModuleScope 'AsBuiltReport.Core' {
                $Command = Get-Command -Name 'Get-RequiredModule'
                $Command.Parameters.Keys | Should -Contain 'Name'
            }
        }

        It 'Should have Version parameter' {
            InModuleScope 'AsBuiltReport.Core' {
                $Command = Get-Command -Name 'Get-RequiredModule'
                $Command.Parameters.Keys | Should -Contain 'Version'
            }
        }

        It 'Should have Name as mandatory parameter' {
            InModuleScope 'AsBuiltReport.Core' {
                $Command = Get-Command -Name 'Get-RequiredModule'
                $Parameter = $Command.Parameters['Name']
                $Parameter.Attributes.Mandatory | Should -Contain $true
            }
        }

        It 'Should have Version as mandatory parameter' {
            InModuleScope 'AsBuiltReport.Core' {
                $Command = Get-Command -Name 'Get-RequiredModule'
                $Parameter = $Command.Parameters['Version']
                $Parameter.Attributes.Mandatory | Should -Contain $true
            }
        }
    }

    Context 'Module Version Checking' -Skip:($PSVersionTable.PSEdition -ne 'Core') {
        It 'Should pass when module version meets requirement' {
            InModuleScope 'AsBuiltReport.Core' {
                Mock Get-Module {
                    [PSCustomObject]@{
                        Name = 'TestModule'
                        Version = [Version]'2.0.0'
                    }
                }
                $global:translate = @{
                    RequiredModuleNotInstalled = 'Module {0} version {1} or higher is required'
                    RequiredModuleTooOld = 'Module {0} version {1} is installed, but version {2} or higher is required'
                }
                { Get-RequiredModule -Name 'TestModule' -Version '1.0.0' } | Should -Not -Throw
            }
        }

        It 'Should pass when module version exactly matches requirement' {
            InModuleScope 'AsBuiltReport.Core' {
                Mock Get-Module {
                    [PSCustomObject]@{
                        Name = 'TestModule'
                        Version = [Version]'2.0.0'
                    }
                }
                $global:translate = @{
                    RequiredModuleNotInstalled = 'Module {0} version {1} or higher is required'
                    RequiredModuleTooOld = 'Module {0} version {1} is installed, but version {2} or higher is required'
                }
                { Get-RequiredModule -Name 'TestModule' -Version '2.0.0' } | Should -Not -Throw
            }
        }

        It 'Should throw when module is not installed' {
            InModuleScope 'AsBuiltReport.Core' {
                Mock Get-Module { $null }
                $global:translate = @{
                    RequiredModuleNotInstalled = 'Module {0} version {1} or higher is required'
                    RequiredModuleTooOld = 'Module {0} version {1} is installed, but version {2} or higher is required'
                }
                { Get-RequiredModule -Name 'NonExistentModule' -Version '1.0.0' } | Should -Throw
            }
        }

        It 'Should throw when module version is too old' {
            InModuleScope 'AsBuiltReport.Core' {
                Mock Get-Module {
                    [PSCustomObject]@{
                        Name = 'TestModule'
                        Version = [Version]'1.0.0'
                    }
                }
                $global:translate = @{
                    RequiredModuleNotInstalled = 'Module {0} version {1} or higher is required'
                    RequiredModuleTooOld = 'Module {0} version {1} is installed, but version {2} or higher is required'
                }
                { Get-RequiredModule -Name 'TestModule' -Version '2.0.0' } | Should -Throw
            }
        }

        It 'Should call Get-Module with correct parameters' {
            InModuleScope 'AsBuiltReport.Core' {
                Mock Get-Module {
                    [PSCustomObject]@{
                        Name = 'TestModule'
                        Version = [Version]'2.0.0'
                    }
                }
                $global:translate = @{
                    RequiredModuleNotInstalled = 'Module {0} version {1} or higher is required'
                    RequiredModuleTooOld = 'Module {0} version {1} is installed, but version {2} or higher is required'
                }
                Get-RequiredModule -Name 'TestModule' -Version '1.0.0'
                Should -Invoke Get-Module -ParameterFilter {
                    $ListAvailable -eq $true -and $Name -eq 'TestModule'
                }
            }
        }
    }
}

AfterAll {
    Remove-Module -Name 'AsBuiltReport.Core' -Force -ErrorAction SilentlyContinue
    Remove-Variable -Name 'translate' -Scope Global -ErrorAction SilentlyContinue
}
