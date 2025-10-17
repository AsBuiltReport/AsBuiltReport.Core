BeforeAll {
    # Import the module
    $ModulePath = Join-Path -Path $PSScriptRoot -ChildPath '..\..\AsBuiltReport.Core\AsBuiltReport.Core.psd1'
    Import-Module $ModulePath -Force
}

Describe 'Write-ReportModuleInfo Unit Tests' {
    Context 'Function Exists' {
        It 'Should have Write-ReportModuleInfo function available' {
            InModuleScope 'AsBuiltReport.Core' {
                $Function = Get-Command -Name 'Write-ReportModuleInfo' -ErrorAction SilentlyContinue
                $Function | Should -Not -BeNullOrEmpty
            }
        }

        It 'Should be a CmdletBinding function' {
            InModuleScope 'AsBuiltReport.Core' {
                $Function = Get-Command -Name 'Write-ReportModuleInfo'
                $Function.CmdletBinding | Should -Be $true
            }
        }
    }

    Context 'Parameter Validation' {
        It 'Should have ModuleName parameter' {
            InModuleScope 'AsBuiltReport.Core' {
                $Command = Get-Command -Name 'Write-ReportModuleInfo'
                $Command.Parameters.Keys | Should -Contain 'ModuleName'
            }
        }

        It 'Should have ModuleName as mandatory parameter' {
            InModuleScope 'AsBuiltReport.Core' {
                $Command = Get-Command -Name 'Write-ReportModuleInfo'
                $Parameter = $Command.Parameters['ModuleName']
                $Parameter.Attributes.Mandatory | Should -Contain $true
            }
        }
    }

    Context 'Basic Functionality' {
        It 'Should call Write-Host in non-verbose mode' {
            InModuleScope 'AsBuiltReport.Core' {
                Mock Write-Host { }
                Mock Get-Module { }
                Mock Find-Module { }

                $global:VerbosePreference = 'SilentlyContinue'
                $global:translate = @{
                    ReportModuleInfo1 = 'Documentation for {0} report module'
                    ReportModuleInfo2 = 'https://github.com/AsBuiltReport/AsBuiltReport.{0}'
                    ReportModuleInfo3 = 'For more information visit'
                    ProjectWebsite = 'https://www.asbuiltreport.com'
                    CommunityProject = 'AsBuiltReport is a community project'
                }

                { Write-ReportModuleInfo -ModuleName 'TestModule' } | Should -Not -Throw

                Should -Invoke Write-Host -Times 5 -Exactly
            }
        }

        It 'Should check for installed module version' {
            InModuleScope 'AsBuiltReport.Core' {
                Mock Write-Host { }
                Mock Get-Module { }
                Mock Find-Module { }
                $global:VerbosePreference = 'SilentlyContinue'
                $global:translate = @{
                    ReportModuleInfo1 = 'Documentation for {0} report module'
                    ReportModuleInfo2 = 'https://github.com/AsBuiltReport/AsBuiltReport.{0}'
                    ReportModuleInfo3 = 'For more information visit'
                    ProjectWebsite = 'https://www.asbuiltreport.com'
                    CommunityProject = 'AsBuiltReport is a community project'
                }

                Write-ReportModuleInfo -ModuleName 'TestModule'
                Should -Invoke Get-Module -ParameterFilter {
                    $Name -eq 'AsBuiltReport.TestModule' -and $ListAvailable -eq $true
                }
            }
        }

        It 'Should construct full module name correctly' {
            InModuleScope 'AsBuiltReport.Core' {
                Mock Write-Host { }
                Mock Get-Module { }
                Mock Find-Module { }
                $global:VerbosePreference = 'SilentlyContinue'
                $global:translate = @{
                    ReportModuleInfo1 = 'Documentation for {0} report module'
                    ReportModuleInfo2 = 'https://github.com/AsBuiltReport/AsBuiltReport.{0}'
                    ReportModuleInfo3 = 'For more information visit'
                    ProjectWebsite = 'https://www.asbuiltreport.com'
                    CommunityProject = 'AsBuiltReport is a community project'
                }

                Write-ReportModuleInfo -ModuleName 'VMware.vSphere'
                Should -Invoke Get-Module -ParameterFilter {
                    $Name -eq 'AsBuiltReport.VMware.vSphere'
                }
            }
        }
    }
}

AfterAll {
    Remove-Module -Name 'AsBuiltReport.Core' -Force -ErrorAction SilentlyContinue
    Remove-Variable -Name 'translate' -Scope Global -ErrorAction SilentlyContinue
    $global:VerbosePreference = 'SilentlyContinue'
}
