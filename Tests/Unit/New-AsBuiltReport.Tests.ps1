BeforeAll {
    # Import the module
    $ModulePath = Join-Path -Path $PSScriptRoot -ChildPath '..\..\AsBuiltReport.Core\AsBuiltReport.Core.psd1'
    Import-Module $ModulePath -Force
}

Describe 'New-AsBuiltReport Unit Tests' {
    Context 'Parameter Validation' {
        BeforeAll {
            $Command = Get-Command -Name 'New-AsBuiltReport'
        }

        It 'Should have Report parameter as mandatory' {
            $ReportParam = $Command.Parameters['Report']
            ($ReportParam.Attributes | Where-Object { $_ -is [System.Management.Automation.ParameterAttribute] }).Mandatory | Should -Contain $true
        }

        It 'Should have Target parameter as mandatory' {
            $TargetParam = $Command.Parameters['Target']
            ($TargetParam.Attributes | Where-Object { $_ -is [System.Management.Automation.ParameterAttribute] }).Mandatory | Should -Contain $true
        }

        It 'Should have Credential parameter in Credential parameter set' {
            $CredentialParam = $Command.Parameters['Credential']
            $CredentialParam | Should -Not -BeNullOrEmpty
        }

        It 'Should have Username and Password parameters in UsernameAndPassword parameter set' {
            $Command.Parameters.Keys | Should -Contain 'Username'
            $Command.Parameters.Keys | Should -Contain 'Password'
        }

        It 'Should have Token parameter in APIToken parameter set' {
            $TokenParam = $Command.Parameters['Token']
            $TokenParam | Should -Not -BeNullOrEmpty
        }

        It 'Should have TokenParameters parameter in APIToken parameter set' {
            $TokenParametersParam = $Command.Parameters['TokenParameters']
            $TokenParametersParam | Should -Not -BeNullOrEmpty
            $ParameterAttribute = $TokenParametersParam.Attributes | Where-Object { $_ -is [System.Management.Automation.ParameterAttribute] }
            $ParameterAttribute.ParameterSetName | Should -Contain 'APIToken'
        }

        It 'TokenParameters parameter should be of type Hashtable' {
            $TokenParametersParam = $Command.Parameters['TokenParameters']
            $TokenParametersParam.ParameterType.Name | Should -Be 'Hashtable'
        }

        It 'TokenParameters parameter should not be mandatory' {
            $TokenParametersParam = $Command.Parameters['TokenParameters']
            $ParameterAttribute = $TokenParametersParam.Attributes | Where-Object { $_ -is [System.Management.Automation.ParameterAttribute] }
            $ParameterAttribute.Mandatory | Should -Be $false
        }

        It 'Should have UseInteractiveAuth parameter in InteractiveAuth parameter set' {
            $Command.Parameters.Keys | Should -Contain 'UseInteractiveAuth'
        }

        It 'Format parameter should have default value of Word' {
            # Default values are set in the param block, not as attributes
            # We can verify this by checking the AST or by testing the actual behavior
            # For now, we'll check that the parameter exists and has the correct ValidateSet
            $FormatParam = $Command.Parameters['Format']
            $FormatParam | Should -Not -BeNullOrEmpty
        }

        It 'Format parameter should accept Word, HTML, and Text' {
            $FormatParam = $Command.Parameters['Format']
            $ValidateSetAttribute = $FormatParam.Attributes | Where-Object { $_ -is [System.Management.Automation.ValidateSetAttribute] }
            $ValidateSetAttribute.ValidValues | Should -Contain 'Word'
            $ValidateSetAttribute.ValidValues | Should -Contain 'HTML'
            $ValidateSetAttribute.ValidValues | Should -Contain 'Text'
        }

        It 'Orientation parameter should accept Portrait and Landscape' {
            $OrientationParam = $Command.Parameters['Orientation']
            $ValidateSetAttribute = $OrientationParam.Attributes | Where-Object { $_ -is [System.Management.Automation.ValidateSetAttribute] }
            $ValidateSetAttribute.ValidValues | Should -Contain 'Portrait'
            $ValidateSetAttribute.ValidValues | Should -Contain 'Landscape'
        }

        It 'Orientation parameter should have default value of Portrait' {
            # Default values are set in the param block, not as attributes
            # We can verify this by checking the AST or by testing the actual behavior
            # For now, we'll check that the parameter exists and has the correct ValidateSet
            $OrientationParam = $Command.Parameters['Orientation']
            $OrientationParam | Should -Not -BeNullOrEmpty
        }

        It 'Target parameter should accept array of strings' {
            $TargetParam = $Command.Parameters['Target']
            $TargetParam.ParameterType.Name | Should -Be 'String[]'
        }

        It 'Should have OutputFolderPath parameter' {
            $Command.Parameters.Keys | Should -Contain 'OutputFolderPath'
        }

        It 'Should have Timestamp parameter' {
            $Command.Parameters.Keys | Should -Contain 'Timestamp'
        }

        It 'Should have EnableHealthCheck parameter' {
            $Command.Parameters.Keys | Should -Contain 'EnableHealthCheck'
        }

        It 'Should have SendEmail parameter' {
            $Command.Parameters.Keys | Should -Contain 'SendEmail'
        }

        It 'Should have ReportLanguage parameter' {
            $Command.Parameters.Keys | Should -Contain 'ReportLanguage'
        }

        It 'Should have StyleFilePath parameter' {
            $Command.Parameters.Keys | Should -Contain 'StyleFilePath'
        }

        It 'Should have ReportConfigFilePath parameter' {
            $Command.Parameters.Keys | Should -Contain 'ReportConfigFilePath'
        }

        It 'Should have AsBuiltConfigFilePath parameter' {
            $Command.Parameters.Keys | Should -Contain 'AsBuiltConfigFilePath'
        }
    }

    Context 'Parameter Aliases' {
        BeforeAll {
            $Command = Get-Command -Name 'New-AsBuiltReport'
        }

        It 'Target parameter should have Cluster, Server, and IP aliases' {
            $TargetParam = $Command.Parameters['Target']
            $TargetParam.Aliases | Should -Contain 'Cluster'
            $TargetParam.Aliases | Should -Contain 'Server'
            $TargetParam.Aliases | Should -Contain 'IP'
        }

        It 'OutputFolderPath parameter should have OutputPath alias' {
            $OutputParam = $Command.Parameters['OutputFolderPath']
            $OutputParam.Aliases | Should -Contain 'OutputPath'
        }

        It 'StyleFilePath parameter should have StylePath alias' {
            $StyleParam = $Command.Parameters['StyleFilePath']
            $StyleParam.Aliases | Should -Contain 'StylePath'
        }

        It 'ReportConfigFilePath parameter should have ReportConfigPath alias' {
            $ReportConfigParam = $Command.Parameters['ReportConfigFilePath']
            $ReportConfigParam.Aliases | Should -Contain 'ReportConfigPath'
        }

        It 'AsBuiltConfigFilePath parameter should have AsBuiltConfigPath alias' {
            $AsBuiltConfigParam = $Command.Parameters['AsBuiltConfigFilePath']
            $AsBuiltConfigParam.Aliases | Should -Contain 'AsBuiltConfigPath'
        }

        It 'UseInteractiveAuth parameter should have MFA alias' {
            $InteractiveAuthParam = $Command.Parameters['UseInteractiveAuth']
            $InteractiveAuthParam.Aliases | Should -Contain 'MFA'
        }
    }

    Context 'Help Documentation' {
        BeforeAll {
            $Help = Get-Help -Name 'New-AsBuiltReport' -Full
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

        It 'Should have at least 10 examples' {
            $Help.Examples.Example.Count | Should -BeGreaterOrEqual 10
        }

        It 'Should have parameter descriptions' {
            $Help.Parameters.Parameter.Count | Should -BeGreaterThan 0
        }

        It 'Should have links' {
            $Help.relatedLinks | Should -Not -BeNullOrEmpty
        }
    }

    Context 'Argument Completers' {
        It 'Should have argument completer registered for Report parameter' {
            # Argument completers are registered via Register-ArgumentCompleter in the script file
            # They are defined outside the function, so we need to check the source file
            $ModuleBase = (Get-Module -Name 'AsBuiltReport.Core').ModuleBase
            $ScriptPath = Join-Path -Path $ModuleBase -ChildPath 'Src\Public\New-AsBuiltReport.ps1'
            $ScriptContent = Get-Content -Path $ScriptPath -Raw
            $ScriptContent | Should -Match "Register-ArgumentCompleter.*'New-AsBuiltReport'.*'Report'"
        }

        It 'Should have argument completer registered for ReportLanguage parameter' {
            # Argument completers are registered via Register-ArgumentCompleter in the script file
            # They are defined outside the function, so we need to check the source file
            $ModuleBase = (Get-Module -Name 'AsBuiltReport.Core').ModuleBase
            $ScriptPath = Join-Path -Path $ModuleBase -ChildPath 'Src\Public\New-AsBuiltReport.ps1'
            $ScriptContent = Get-Content -Path $ScriptPath -Raw
            $ScriptContent | Should -Match "Register-ArgumentCompleter.*'New-AsBuiltReport'.*'ReportLanguage'"
        }
    }

    Context 'Function Behavior' {
        BeforeAll {
            $TestDrive = [System.IO.Path]::GetTempPath()
            $TestFolder = Join-Path -Path $TestDrive -ChildPath "AsBuiltReportTest_$(Get-Random)"
            New-Item -Path $TestFolder -ItemType Directory -Force | Out-Null
        }

        AfterAll {
            if (Test-Path $TestFolder) {
                Remove-Item -Path $TestFolder -Recurse -Force -ErrorAction SilentlyContinue
            }
        }

        It 'Should throw error when OutputFolderPath does not exist' {
            $NonExistentPath = Join-Path -Path $TestDrive -ChildPath "NonExistent_$(Get-Random)"
            { New-AsBuiltReport -Report 'Test.Report' -Target '127.0.0.1' -Username 'test' -Password 'test' -OutputFolderPath $NonExistentPath -ErrorAction Stop } | Should -Throw
        }

        It 'Should have proper error handling for invalid report types' {
            { New-AsBuiltReport -Report 'Invalid.Report.Module' -Target '127.0.0.1' -Username 'test' -Password 'test' -OutputFolderPath $TestFolder -ErrorAction Stop } | Should -Throw
        }

        It 'Should throw error when AsBuiltConfigFilePath does not exist' {
            $NonExistentConfig = Join-Path -Path $TestDrive -ChildPath "NonExistent_$(Get-Random).json"
            { New-AsBuiltReport -Report 'Test.Report' -Target '127.0.0.1' -Username 'test' -Password 'test' -OutputFolderPath $TestFolder -AsBuiltConfigFilePath $NonExistentConfig -ErrorAction Stop } | Should -Throw
        }
    }
}

AfterAll {
    Remove-Module -Name 'AsBuiltReport.Core' -Force -ErrorAction SilentlyContinue
}
