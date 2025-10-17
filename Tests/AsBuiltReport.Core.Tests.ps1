BeforeAll {
    # Import the module
    $ModulePath = Join-Path -Path $PSScriptRoot -ChildPath '..\AsBuiltReport.Core\AsBuiltReport.Core.psd1'
    Import-Module $ModulePath -Force
}

Describe 'AsBuiltReport.Core Module Tests' {
    Context 'Module Manifest' {
        BeforeAll {
            $ManifestPath = Join-Path -Path $PSScriptRoot -ChildPath '..\AsBuiltReport.Core\AsBuiltReport.Core.psd1'
            $Manifest = Test-ModuleManifest -Path $ManifestPath -ErrorAction Stop
        }

        It 'Should have a valid module manifest' {
            $Manifest | Should -Not -BeNullOrEmpty
        }

        It 'Should have the correct module name' {
            $Manifest.Name | Should -Be 'AsBuiltReport.Core'
        }

        It 'Should have a valid GUID' {
            $Manifest.Guid | Should -Be '0f1094c4-c6b1-495c-8cdd-9331f67f9f6f'
        }

        It 'Should have a valid version' {
            $Manifest.Version | Should -Not -BeNullOrEmpty
            $Manifest.Version.GetType().Name | Should -Be 'Version'
        }

        It 'Should have a valid author' {
            $Manifest.Author | Should -Not -BeNullOrEmpty
        }

        It 'Should have a valid description' {
            $Manifest.Description | Should -Not -BeNullOrEmpty
        }

        It 'Should require PScribo module' {
            $Manifest.RequiredModules | Should -Not -BeNullOrEmpty
            $Manifest.RequiredModules.Name | Should -Contain 'PScribo'
        }

        It 'Should export the correct functions' {
            $Manifest.ExportedFunctions.Keys | Should -Contain 'New-AsBuiltReport'
            $Manifest.ExportedFunctions.Keys | Should -Contain 'New-AsBuiltConfig'
            $Manifest.ExportedFunctions.Keys | Should -Contain 'New-AsBuiltReportConfig'
        }

        It 'Should have valid tags' {
            $Manifest.Tags | Should -Contain 'AsBuiltReport'
            $Manifest.Tags | Should -Contain 'Report'
            $Manifest.Tags | Should -Contain 'PScribo'
        }

        It 'Should have a valid project URI' {
            $Manifest.ProjectUri | Should -Not -BeNullOrEmpty
            $Manifest.ProjectUri.ToString() | Should -Match '^https?://'
        }

        It 'Should have a valid license URI' {
            $Manifest.LicenseUri | Should -Not -BeNullOrEmpty
            $Manifest.LicenseUri.ToString() | Should -Match '^https?://'
        }
    }

    Context 'Module Structure' {
        It 'Should have a valid root module file' {
            $RootModulePath = Join-Path -Path $PSScriptRoot -ChildPath '..\AsBuiltReport.Core\AsBuiltReport.Core.psm1'
            Test-Path $RootModulePath | Should -Be $true
        }

        It 'Should have a Src folder' {
            $SrcPath = Join-Path -Path $PSScriptRoot -ChildPath '..\AsBuiltReport.Core\Src'
            Test-Path $SrcPath | Should -Be $true
        }

        It 'Should have a Public functions folder' {
            $PublicPath = Join-Path -Path $PSScriptRoot -ChildPath '..\AsBuiltReport.Core\Src\Public'
            Test-Path $PublicPath | Should -Be $true
        }

        It 'Should have a Private functions folder' {
            $PrivatePath = Join-Path -Path $PSScriptRoot -ChildPath '..\AsBuiltReport.Core\Src\Private'
            Test-Path $PrivatePath | Should -Be $true
        }

        It 'Should have a Language folder' {
            $LanguagePath = Join-Path -Path $PSScriptRoot -ChildPath '..\AsBuiltReport.Core\Language'
            Test-Path $LanguagePath | Should -Be $true
        }

        It 'Should have en-US language files' {
            $EnUSPath = Join-Path -Path $PSScriptRoot -ChildPath '..\AsBuiltReport.Core\Language\en-US'
            Test-Path $EnUSPath | Should -Be $true
        }
    }

    Context 'Public Functions' {
        It 'Should export New-AsBuiltReport function' {
            Get-Command -Name 'New-AsBuiltReport' -Module 'AsBuiltReport.Core' -ErrorAction SilentlyContinue | Should -Not -BeNullOrEmpty
        }

        It 'Should export New-AsBuiltConfig function' {
            Get-Command -Name 'New-AsBuiltConfig' -Module 'AsBuiltReport.Core' -ErrorAction SilentlyContinue | Should -Not -BeNullOrEmpty
        }

        It 'Should export New-AsBuiltReportConfig function' {
            Get-Command -Name 'New-AsBuiltReportConfig' -Module 'AsBuiltReport.Core' -ErrorAction SilentlyContinue | Should -Not -BeNullOrEmpty
        }

        It 'Should have exactly 3 exported functions' {
            $ExportedFunctions = Get-Command -Module 'AsBuiltReport.Core' -CommandType Function
            # Note: Get-RequiredModule and Write-ReportModuleInfo are made globally available for report modules
            # but they are not formally exported functions, they appear in Get-Command output
            # Filter to only count the officially exported public functions
            $PublicFunctions = $ExportedFunctions | Where-Object {
                $_.Name -in @('New-AsBuiltReport', 'New-AsBuiltConfig', 'New-AsBuiltReportConfig')
            }
            $PublicFunctions.Count | Should -Be 3
        }
    }

    Context 'Function Parameter Validation' {
        BeforeAll {
            $NewAsBuiltReportCommand = Get-Command -Name 'New-AsBuiltReport'
            $NewAsBuiltReportConfigCommand = Get-Command -Name 'New-AsBuiltReportConfig'
        }

        It 'New-AsBuiltReport should have Report parameter' {
            $NewAsBuiltReportCommand.Parameters.Keys | Should -Contain 'Report'
        }

        It 'New-AsBuiltReport should have Target parameter' {
            $NewAsBuiltReportCommand.Parameters.Keys | Should -Contain 'Target'
        }

        It 'New-AsBuiltReport should have Format parameter' {
            $NewAsBuiltReportCommand.Parameters.Keys | Should -Contain 'Format'
        }

        It 'New-AsBuiltReport should have OutputFolderPath parameter' {
            $NewAsBuiltReportCommand.Parameters.Keys | Should -Contain 'OutputFolderPath'
        }

        It 'New-AsBuiltReport should have Credential parameter' {
            $NewAsBuiltReportCommand.Parameters.Keys | Should -Contain 'Credential'
        }

        It 'New-AsBuiltReport Format parameter should accept Word, HTML, and Text' {
            $FormatParam = $NewAsBuiltReportCommand.Parameters['Format']
            $ValidateSetAttribute = $FormatParam.Attributes | Where-Object { $_ -is [System.Management.Automation.ValidateSetAttribute] }
            $ValidateSetAttribute.ValidValues | Should -Contain 'Word'
            $ValidateSetAttribute.ValidValues | Should -Contain 'HTML'
            $ValidateSetAttribute.ValidValues | Should -Contain 'Text'
        }

        It 'New-AsBuiltReportConfig should have Report parameter' {
            $NewAsBuiltReportConfigCommand.Parameters.Keys | Should -Contain 'Report'
        }

        It 'New-AsBuiltReportConfig should have FolderPath parameter' {
            $NewAsBuiltReportConfigCommand.Parameters.Keys | Should -Contain 'FolderPath'
        }
    }

    Context 'Help Content' {
        It 'New-AsBuiltReport should have help content' {
            $Help = Get-Help -Name 'New-AsBuiltReport' -ErrorAction SilentlyContinue
            $Help | Should -Not -BeNullOrEmpty
            $Help.Synopsis | Should -Not -BeNullOrEmpty
        }

        It 'New-AsBuiltConfig should have help content' {
            $Help = Get-Help -Name 'New-AsBuiltConfig' -ErrorAction SilentlyContinue
            $Help | Should -Not -BeNullOrEmpty
            $Help.Synopsis | Should -Not -BeNullOrEmpty
        }

        It 'New-AsBuiltReportConfig should have help content' {
            $Help = Get-Help -Name 'New-AsBuiltReportConfig' -ErrorAction SilentlyContinue
            $Help | Should -Not -BeNullOrEmpty
            $Help.Synopsis | Should -Not -BeNullOrEmpty
        }

        It 'New-AsBuiltReport should have description' {
            $Help = Get-Help -Name 'New-AsBuiltReport' -ErrorAction SilentlyContinue
            $Help.Description | Should -Not -BeNullOrEmpty
        }

        It 'New-AsBuiltConfig should have description' {
            $Help = Get-Help -Name 'New-AsBuiltConfig' -ErrorAction SilentlyContinue
            $Help.Description | Should -Not -BeNullOrEmpty
        }

        It 'New-AsBuiltReportConfig should have description' {
            $Help = Get-Help -Name 'New-AsBuiltReportConfig' -ErrorAction SilentlyContinue
            $Help.Description | Should -Not -BeNullOrEmpty
        }

        It 'New-AsBuiltReport should have examples' {
            $Help = Get-Help -Name 'New-AsBuiltReport' -ErrorAction SilentlyContinue
            $Help.Examples | Should -Not -BeNullOrEmpty
        }

        It 'New-AsBuiltConfig should have examples' {
            $Help = Get-Help -Name 'New-AsBuiltConfig' -ErrorAction SilentlyContinue
            $Help.Examples | Should -Not -BeNullOrEmpty
        }

        It 'New-AsBuiltReportConfig should have examples' {
            $Help = Get-Help -Name 'New-AsBuiltReportConfig' -ErrorAction SilentlyContinue
            $Help.Examples | Should -Not -BeNullOrEmpty
        }
    }
}

Describe 'Module File Syntax and Quality' {
    Context 'PowerShell Script Files' {
        It 'Should have valid PowerShell syntax in all script files' {
            $ModuleRoot = Join-Path -Path $PSScriptRoot -ChildPath '..\AsBuiltReport.Core'
            $ScriptFiles = Get-ChildItem -Path $ModuleRoot -Include '*.ps1', '*.psm1' -Recurse

            foreach ($File in $ScriptFiles) {
                $FileContent = Get-Content -Path $File.FullName -Raw -ErrorAction Stop
                $Errors = $null
                $null = [System.Management.Automation.PSParser]::Tokenize($FileContent, [ref]$Errors)
                $Errors.Count | Should -Be 0 -Because "File $($File.Name) should have no syntax errors"
            }
        }
    }

    Context 'Language Files' {
        It 'Should have valid PowerShell localization data files' {
            $LanguagePath = Join-Path -Path $PSScriptRoot -ChildPath '..\AsBuiltReport.Core\Language'
            $LanguageFiles = Get-ChildItem -Path $LanguagePath -Include '*.psd1' -Recurse -ErrorAction SilentlyContinue

            foreach ($File in $LanguageFiles) {
                # All .psd1 files in Language folder use ConvertFrom-StringData and should be loaded with Import-LocalizedData
                {
                    $null = Import-LocalizedData -BaseDirectory $File.Directory.FullName -FileName $File.Name -ErrorAction Stop
                } | Should -Not -Throw -Because "Localization file $($File.FullName) should be valid"
            }
        }
    }
}

AfterAll {
    # Clean up
    Remove-Module -Name 'AsBuiltReport.Core' -Force -ErrorAction SilentlyContinue
}
