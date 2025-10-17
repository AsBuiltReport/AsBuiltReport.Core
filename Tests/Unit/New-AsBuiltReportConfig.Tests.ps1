BeforeAll {
    # Import the module
    $ModulePath = Join-Path -Path $PSScriptRoot -ChildPath '..\..\AsBuiltReport.Core\AsBuiltReport.Core.psd1'
    Import-Module $ModulePath -Force
}

Describe 'New-AsBuiltReportConfig Unit Tests' {
    Context 'Parameter Validation' {
        BeforeAll {
            $Command = Get-Command -Name 'New-AsBuiltReportConfig'
        }

        It 'Should have Report parameter as mandatory' {
            $ReportParam = $Command.Parameters['Report']
            ($ReportParam.Attributes | Where-Object { $_ -is [System.Management.Automation.ParameterAttribute] }).Mandatory | Should -Contain $true
        }

        It 'Should have FolderPath parameter as mandatory' {
            $FolderPathParam = $Command.Parameters['FolderPath']
            ($FolderPathParam.Attributes | Where-Object { $_ -is [System.Management.Automation.ParameterAttribute] }).Mandatory | Should -Contain $true
        }

        It 'Should have Filename parameter as optional' {
            $FilenameParam = $Command.Parameters['Filename']
            $MandatoryAttributes = ($FilenameParam.Attributes | Where-Object { $_ -is [System.Management.Automation.ParameterAttribute] }).Mandatory
            $MandatoryAttributes | Should -Not -Contain $true
        }

        It 'Should have Force parameter' {
            $Command.Parameters.Keys | Should -Contain 'Force'
        }

        It 'Force parameter should be a switch' {
            $ForceParam = $Command.Parameters['Force']
            $ForceParam.ParameterType.Name | Should -Be 'SwitchParameter'
        }

        It 'Should have Path alias for FolderPath' {
            $FolderPathParam = $Command.Parameters['FolderPath']
            $FolderPathParam.Aliases | Should -Contain 'Path'
        }

        It 'Should have Name alias for Filename' {
            $FilenameParam = $Command.Parameters['Filename']
            $FilenameParam.Aliases | Should -Contain 'Name'
        }

        It 'Should have Overwrite alias for Force' {
            $ForceParam = $Command.Parameters['Force']
            $ForceParam.Aliases | Should -Contain 'Overwrite'
        }
    }

    Context 'Function Behavior' {
        BeforeAll {
            # Create a temporary test directory
            $TestDrive = [System.IO.Path]::GetTempPath()
            $TestFolder = Join-Path -Path $TestDrive -ChildPath "AsBuiltReportTest_$(Get-Random)"
            New-Item -Path $TestFolder -ItemType Directory -Force | Out-Null
        }

        AfterAll {
            # Clean up test directory
            if (Test-Path $TestFolder) {
                Remove-Item -Path $TestFolder -Recurse -Force -ErrorAction SilentlyContinue
            }
        }

        It 'Should throw error when FolderPath does not exist' {
            $NonExistentPath = Join-Path -Path $TestDrive -ChildPath "NonExistent_$(Get-Random)"
            { New-AsBuiltReportConfig -Report 'Test.Report' -FolderPath $NonExistentPath -ErrorAction Stop } | Should -Throw
        }

        It 'Should have proper error handling for invalid report types' {
            { New-AsBuiltReportConfig -Report 'Invalid.Report.Module' -FolderPath $TestFolder -ErrorAction Stop } | Should -Throw
        }
    }

    Context 'Help Documentation' {
        BeforeAll {
            $Help = Get-Help -Name 'New-AsBuiltReportConfig' -Full
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

        It 'Should have parameter descriptions for Report' {
            ($Help.Parameters.Parameter | Where-Object { $_.Name -eq 'Report' }).Description | Should -Not -BeNullOrEmpty
        }

        It 'Should have parameter descriptions for FolderPath' {
            ($Help.Parameters.Parameter | Where-Object { $_.Name -eq 'FolderPath' }).Description | Should -Not -BeNullOrEmpty
        }

        It 'Should have parameter descriptions for Filename' {
            ($Help.Parameters.Parameter | Where-Object { $_.Name -eq 'Filename' }).Description | Should -Not -BeNullOrEmpty
        }

        It 'Should have parameter descriptions for Force' {
            ($Help.Parameters.Parameter | Where-Object { $_.Name -eq 'Force' }).Description | Should -Not -BeNullOrEmpty
        }

        It 'Should have links' {
            $Help.relatedLinks | Should -Not -BeNullOrEmpty
        }
    }

    Context 'Argument Completer' {
        It 'Should have argument completer registered for Report parameter' {
            # Argument completers are registered via Register-ArgumentCompleter in the script file
            # They are defined outside the function, so we need to check the source file
            $ModuleBase = (Get-Module -Name 'AsBuiltReport.Core').ModuleBase
            $ScriptPath = Join-Path -Path $ModuleBase -ChildPath 'Src\Public\New-AsBuiltReportConfig.ps1'
            $ScriptContent = Get-Content -Path $ScriptPath -Raw
            $ScriptContent | Should -Match "Register-ArgumentCompleter.*'New-AsBuiltReportConfig'.*'Report'"
        }
    }
}

AfterAll {
    Remove-Module -Name 'AsBuiltReport.Core' -Force -ErrorAction SilentlyContinue
}
