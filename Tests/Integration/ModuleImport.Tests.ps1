BeforeAll {
    # Remove module if already loaded
    Remove-Module -Name 'AsBuiltReport.Core' -Force -ErrorAction SilentlyContinue
}

Describe 'AsBuiltReport.Core Module Import Integration Tests' {
    Context 'Module Import' {
        It 'Should import the module without errors' {
            $ModulePath = Join-Path -Path $PSScriptRoot -ChildPath '..\..\AsBuiltReport.Core\AsBuiltReport.Core.psd1'
            { Import-Module $ModulePath -Force -ErrorAction Stop } | Should -Not -Throw
        }

        It 'Should have the module loaded' {
            Get-Module -Name 'AsBuiltReport.Core' | Should -Not -BeNullOrEmpty
        }

        It 'Should load all public functions' {
            $Commands = Get-Command -Module 'AsBuiltReport.Core'
            $Commands.Count | Should -BeGreaterThan 0
        }

        It 'Should not expose most private functions' {
            $Commands = Get-Command -Module 'AsBuiltReport.Core' -CommandType Function
            # Note: Get-RequiredModule and Write-ReportModuleInfo are intentionally made global for report modules
            $Commands.Name | Should -Not -Contain 'Initialize-LocalizedData'
            $Commands.Name | Should -Not -Contain 'Resolve-Culture'
            $Commands.Name | Should -Not -Contain 'Draw-AsciiBanner'
        }
    }

    Context 'Module Dependencies' {
        It 'Should have PScribo module as a required module' {
            $Module = Get-Module -Name 'AsBuiltReport.Core'
            $Module.RequiredModules.Name | Should -Contain 'PScribo'
        }

        It 'Should load PScribo module' {
            Get-Module -Name 'PScribo' | Should -Not -BeNullOrEmpty
        }
    }

    Context 'Module Version' {
        It 'Should have a valid semantic version' {
            $Module = Get-Module -Name 'AsBuiltReport.Core'
            $Module.Version | Should -Not -BeNullOrEmpty
            $Module.Version.GetType().Name | Should -Be 'Version'
        }

        It 'Should have version components' {
            $Module = Get-Module -Name 'AsBuiltReport.Core'
            $Module.Version.Major | Should -BeGreaterOrEqual 0
            $Module.Version.Minor | Should -BeGreaterOrEqual 0
        }
    }

    Context 'Module Metadata' {
        BeforeAll {
            $Module = Get-Module -Name 'AsBuiltReport.Core'
        }

        It 'Should have company or author information' {
            $Module.CompanyName -or $Module.Author | Should -Not -BeNullOrEmpty
        }

        It 'Should have copyright information' {
            $Module.Copyright | Should -Not -BeNullOrEmpty
        }

        It 'Should have a description' {
            $Module.Description | Should -Not -BeNullOrEmpty
        }

        It 'Should have a valid GUID' {
            $Module.Guid | Should -Not -BeNullOrEmpty
            [Guid]::TryParse($Module.Guid, [ref][Guid]::Empty) | Should -Be $true
        }
    }

    Context 'Language Support' {
        BeforeAll {
            $ModuleBase = (Get-Module -Name 'AsBuiltReport.Core').ModuleBase
            $LanguagePath = Join-Path -Path $ModuleBase -ChildPath 'Language'
        }

        It 'Should have a Language folder' {
            Test-Path -Path $LanguagePath | Should -Be $true
        }

        It 'Should have en-US language support' {
            $EnUSPath = Join-Path -Path $LanguagePath -ChildPath 'en-US'
            Test-Path -Path $EnUSPath | Should -Be $true
        }

        It 'Should have localization files in en-US' {
            $EnUSPath = Join-Path -Path $LanguagePath -ChildPath 'en-US'
            $LocalizationFiles = Get-ChildItem -Path $EnUSPath -Filter '*.psd1' -ErrorAction SilentlyContinue
            $LocalizationFiles.Count | Should -BeGreaterThan 0
        }

        It 'Should have valid localization data files' {
            $EnUSPath = Join-Path -Path $LanguagePath -ChildPath 'en-US'
            $LocalizationFiles = Get-ChildItem -Path $EnUSPath -Filter '*.psd1'
            foreach ($File in $LocalizationFiles) {
                # All .psd1 files in Language folder use ConvertFrom-StringData and should be loaded with Import-LocalizedData
                {
                    $null = Import-LocalizedData -BaseDirectory $File.Directory.FullName -FileName $File.Name -ErrorAction Stop
                } | Should -Not -Throw
            }
        }

        It 'Should support multiple languages' {
            $LanguageFolders = Get-ChildItem -Path $LanguagePath -Directory
            $LanguageFolders.Count | Should -BeGreaterThan 1
        }
    }
}

AfterAll {
    # Clean up
    Remove-Module -Name 'AsBuiltReport.Core' -Force -ErrorAction SilentlyContinue
}
