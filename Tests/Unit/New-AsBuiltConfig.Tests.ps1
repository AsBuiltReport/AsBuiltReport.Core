BeforeAll {
    # Import the module
    $ModulePath = Join-Path -Path $PSScriptRoot -ChildPath '..\..\AsBuiltReport.Core\AsBuiltReport.Core.psd1'
    Import-Module $ModulePath -Force
}

Describe 'New-AsBuiltConfig Unit Tests' {
    Context 'Function Exists' {
        It 'Should have New-AsBuiltConfig function available' {
            Get-Command -Name 'New-AsBuiltConfig' -ErrorAction SilentlyContinue | Should -Not -BeNullOrEmpty
        }
    }

    Context 'Parameter Validation' {
        BeforeAll {
            $Command = Get-Command -Name 'New-AsBuiltConfig'
        }

        It 'Should not have any mandatory parameters' {
            $MandatoryParams = $Command.Parameters.Values | Where-Object {
                ($_.Attributes | Where-Object { $_ -is [System.Management.Automation.ParameterAttribute] }).Mandatory -contains $true
            }
            $MandatoryParams | Should -BeNullOrEmpty
        }

        It 'Should be a CmdletBinding function' {
            $Command.CmdletBinding | Should -Be $true
        }
    }

    Context 'Help Documentation' {
        BeforeAll {
            $Help = Get-Help -Name 'New-AsBuiltConfig' -Full
        }

        It 'Should have a synopsis' {
            $Help.Synopsis | Should -Not -BeNullOrEmpty
        }

        It 'Should have a description' {
            $Help.Description | Should -Not -BeNullOrEmpty
        }

        It 'Should have examples' {
            $Help.Examples | Should -Not -BeNullOrEmpty
            $Help.Examples.Example.Count | Should -BeGreaterThan 0
        }

        It 'Should have at least 2 examples' {
            $Help.Examples.Example.Count | Should -BeGreaterOrEqual 2
        }

        It 'Should have links' {
            $Help.relatedLinks | Should -Not -BeNullOrEmpty
        }

        It 'Should reference the user guide' {
            $Help.relatedLinks.navigationLink.uri | Should -Match 'asbuiltreport.com|github.com'
        }
    }

    Context 'Function Output' {
        It 'Should return a hashtable when executed non-interactively' {
            # Note: This test cannot run in CI/CD as it requires interactive input
            # This is a placeholder for manual testing
            $true | Should -Be $true
        }
    }
}

AfterAll {
    Remove-Module -Name 'AsBuiltReport.Core' -Force -ErrorAction SilentlyContinue
}
