BeforeAll {
    $ModuleRoot = Join-Path -Path $PSScriptRoot -ChildPath '..\..\AsBuiltReport.Core'
}

Describe 'Code Quality and Best Practices' {
    Context 'File Structure' {
        It 'Should have a manifest file' {
            $ManifestPath = Join-Path -Path $ModuleRoot -ChildPath 'AsBuiltReport.Core.psd1'
            Test-Path -Path $ManifestPath | Should -Be $true
        }

        It 'Should have a module file' {
            $ModulePath = Join-Path -Path $ModuleRoot -ChildPath 'AsBuiltReport.Core.psm1'
            Test-Path -Path $ModulePath | Should -Be $true
        }

        It 'Should have a Src folder' {
            $SrcPath = Join-Path -Path $ModuleRoot -ChildPath 'Src'
            Test-Path -Path $SrcPath | Should -Be $true
        }

        It 'Should organize functions into Public and Private folders' {
            $PublicPath = Join-Path -Path $ModuleRoot -ChildPath 'Src\Public'
            $PrivatePath = Join-Path -Path $ModuleRoot -ChildPath 'Src\Private'
            Test-Path -Path $PublicPath | Should -Be $true
            Test-Path -Path $PrivatePath | Should -Be $true
        }
    }

    Context 'PowerShell Best Practices' {
        It 'All script files should use UTF8 encoding' {
            $ScriptFiles = Get-ChildItem -Path $ModuleRoot -Include '*.ps1', '*.psm1' -Recurse
            foreach ($File in $ScriptFiles) {
                $Content = [System.IO.File]::ReadAllBytes($File.FullName)
                # Check for UTF8 BOM (EF BB BF) or assume UTF8
                if ($Content.Length -ge 3) {
                    $BOM = $Content[0..2]
                    # UTF8 BOM or no BOM is acceptable
                    ($BOM[0] -eq 0xEF -and $BOM[1] -eq 0xBB -and $BOM[2] -eq 0xBF) -or
                    ($BOM[0] -ne 0xFF -and $BOM[0] -ne 0xFE) | Should -Be $true
                }
            }
        }

        It 'All public functions should have comment-based help' {
            $PublicFunctions = Get-ChildItem -Path (Join-Path -Path $ModuleRoot -ChildPath 'Src\Public') -Filter '*.ps1'
            foreach ($Function in $PublicFunctions) {
                $Content = Get-Content -Path $Function.FullName -Raw
                $Content | Should -Match '\.SYNOPSIS'
                $Content | Should -Match '\.DESCRIPTION'
                $Content | Should -Match '\.EXAMPLE'
            }
        }

        It 'All public functions should use CmdletBinding' {
            $PublicFunctions = Get-ChildItem -Path (Join-Path -Path $ModuleRoot -ChildPath 'Src\Public') -Filter '*.ps1'
            foreach ($Function in $PublicFunctions) {
                $Content = Get-Content -Path $Function.FullName -Raw
                $Content | Should -Match '\[CmdletBinding\('
            }
        }

        It 'All functions should use approved verbs' {
            $PublicFunctions = Get-ChildItem -Path (Join-Path -Path $ModuleRoot -ChildPath 'Src\Public') -Filter '*.ps1'
            $ApprovedVerbs = Get-Verb | Select-Object -ExpandProperty Verb

            foreach ($Function in $PublicFunctions) {
                $FunctionName = $Function.BaseName
                $Verb = ($FunctionName -split '-')[0]
                $ApprovedVerbs | Should -Contain $Verb
            }
        }
    }

    Context 'Code Syntax' {
        It 'Should have no syntax errors in PowerShell script files' {
            $ScriptFiles = Get-ChildItem -Path $ModuleRoot -Include '*.ps1', '*.psm1' -Recurse
            foreach ($File in $ScriptFiles) {
                $Errors = $null
                $null = [System.Management.Automation.PSParser]::Tokenize(
                    (Get-Content -Path $File.FullName -Raw),
                    [ref]$Errors
                )
                $Errors.Count | Should -Be 0 -Because "File $($File.Name) should have no syntax errors"
            }
        }

        It 'Should parse successfully with AST' {
            $ScriptFiles = Get-ChildItem -Path $ModuleRoot -Include '*.ps1', '*.psm1' -Recurse
            foreach ($File in $ScriptFiles) {
                $Errors = $null
                $null = [System.Management.Automation.Language.Parser]::ParseFile(
                    $File.FullName,
                    [ref]$null,
                    [ref]$Errors
                )
                $Errors.Count | Should -Be 0 -Because "File $($File.Name) should parse without errors"
            }
        }
    }

    Context 'Manifest Validation' {
        BeforeAll {
            $ManifestPath = Join-Path -Path $ModuleRoot -ChildPath 'AsBuiltReport.Core.psd1'
        }

        It 'Should have a valid module manifest' {
            { Test-ModuleManifest -Path $ManifestPath -ErrorAction Stop } | Should -Not -Throw
        }

        It 'Should specify a RootModule' {
            $Manifest = Import-PowerShellDataFile -Path $ManifestPath
            $Manifest.RootModule | Should -Not -BeNullOrEmpty
        }

        It 'Should specify a ModuleVersion' {
            $Manifest = Import-PowerShellDataFile -Path $ManifestPath
            $Manifest.ModuleVersion | Should -Not -BeNullOrEmpty
            [Version]$Manifest.ModuleVersion | Should -Not -BeNullOrEmpty
        }

        It 'Should specify a GUID' {
            $Manifest = Import-PowerShellDataFile -Path $ManifestPath
            $Manifest.GUID | Should -Not -BeNullOrEmpty
            [Guid]::TryParse($Manifest.GUID, [ref][Guid]::Empty) | Should -Be $true
        }

        It 'Should specify an Author' {
            $Manifest = Import-PowerShellDataFile -Path $ManifestPath
            $Manifest.Author | Should -Not -BeNullOrEmpty
        }

        It 'Should specify a Description' {
            $Manifest = Import-PowerShellDataFile -Path $ManifestPath
            $Manifest.Description | Should -Not -BeNullOrEmpty
        }

        It 'Should have FunctionsToExport defined' {
            $Manifest = Import-PowerShellDataFile -Path $ManifestPath
            $Manifest.FunctionsToExport | Should -Not -BeNullOrEmpty
        }

        It 'Should not use wildcards for FunctionsToExport' {
            $Manifest = Import-PowerShellDataFile -Path $ManifestPath
            $Manifest.FunctionsToExport | Should -Not -Contain '*'
        }
    }

    Context 'Documentation' {
        It 'Should have a README file in the repository root' {
            $ReadmePath = Join-Path -Path $ModuleRoot -ChildPath '..\README.md'
            Test-Path -Path $ReadmePath | Should -Be $true
        }

        It 'Should have a CHANGELOG file in the repository root' {
            $ChangelogPath = Join-Path -Path $ModuleRoot -ChildPath '..\CHANGELOG.md'
            Test-Path -Path $ChangelogPath | Should -Be $true
        }

        It 'Should have a LICENSE file in the repository root' {
            $LicensePath = Join-Path -Path $ModuleRoot -ChildPath '..\LICENSE'
            Test-Path -Path $LicensePath | Should -Be $true
        }
    }

    Context 'Language Files Quality' {
        BeforeAll {
            $LanguagePath = Join-Path -Path $ModuleRoot -ChildPath 'Language'
            $LanguageFiles = Get-ChildItem -Path $LanguagePath -Filter '*.psd1' -Recurse
        }

        It 'All language files should be valid and parseable' {
            foreach ($File in $LanguageFiles) {
                # All .psd1 files in Language folder use ConvertFrom-StringData and should be loaded with Import-LocalizedData
                {
                    $null = Import-LocalizedData -BaseDirectory $File.Directory.FullName -FileName $File.Name -ErrorAction Stop
                } | Should -Not -Throw
            }
        }

        It 'All language files should contain hashtable data' {
            foreach ($File in $LanguageFiles) {
                # All language files should be loaded with Import-LocalizedData
                $Data = Import-LocalizedData -BaseDirectory $File.Directory.FullName -FileName $File.Name
                $Data.GetType().Name | Should -Be 'Hashtable'
            }
        }

        It 'Language files should have consistent keys across cultures' {
            # Get all language folders
            $LanguageFolders = Get-ChildItem -Path $LanguagePath -Directory

            # Get all unique language file names
            $FileNames = $LanguageFiles | Select-Object -ExpandProperty Name -Unique

            foreach ($FileName in $FileNames) {
                $Keys = @{}

                # Collect keys from each culture's version of this file
                foreach ($Folder in $LanguageFolders) {
                    $FilePath = Join-Path -Path $Folder.FullName -ChildPath $FileName
                    if (Test-Path $FilePath) {
                        # All language files should be loaded with Import-LocalizedData
                        $Data = Import-LocalizedData -BaseDirectory $Folder.FullName -FileName $FileName
                        $Keys[$Folder.Name] = $Data.Keys | Sort-Object
                    }
                }

                # All cultures with this file should have the same keys
                if ($Keys.Count -gt 1) {
                    $ReferenceKeys = $Keys.Values | Select-Object -First 1
                    foreach ($CultureKeys in $Keys.Values) {
                        Compare-Object -ReferenceObject $ReferenceKeys -DifferenceObject $CultureKeys | Should -BeNullOrEmpty
                    }
                }
            }
        }
    }
}
