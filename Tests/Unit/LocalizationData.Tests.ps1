BeforeAll {
    # Get the language folder path
    $LanguagePath = Join-Path -Path $PSScriptRoot -ChildPath '..\..\AsBuiltReport.Core\Language'

    # Helper function to extract keys from simple ConvertFrom-StringData format
    function Get-SimpleLocalizationKeys {
        param([string]$FilePath)

        $keys = @()
        $content = Get-Content -Path $FilePath -Raw

        # Match lines with key = value pattern within the here-string
        $pattern = '^\s*(\w+)\s*='
        $lines = Get-Content -Path $FilePath
        foreach ($line in $lines) {
            if ($line -match $pattern -and $line -notmatch '^#' -and $line -notmatch 'ConvertFrom-StringData' -and $line -notmatch "^@['{]") {
                $keys += $Matches[1]
            }
        }
        return $keys | Sort-Object
    }

    # Helper function to extract keys from nested hashtable format (New-AsBuiltConfig.psd1)
    function Get-NestedLocalizationKeys {
        param([string]$FilePath)

        $keys = @()
        $content = Get-Content -Path $FilePath
        $currentSection = $null

        foreach ($line in $content) {
            # Match section headers like: ReportInfo = ConvertFrom-StringData @'
            if ($line -match '^\s*(\w+)\s*=\s*ConvertFrom-StringData') {
                $currentSection = $Matches[1]
            }
            # Match key-value pairs within sections
            elseif ($currentSection -and $line -match '^\s{4}(\w+)\s*=' -and $line -notmatch "^'@") {
                $keys += "$currentSection.$($Matches[1])"
            }
            # End of section
            elseif ($line -match "^'@") {
                $currentSection = $null
            }
        }
        return $keys | Sort-Object
    }
}

Describe 'Localization Data Consistency Tests' {
    Context 'New-AsBuiltReport.psd1 Localization Files' {
        BeforeAll {
            $TemplateFile = Join-Path -Path $LanguagePath -ChildPath 'en-US\New-AsBuiltReport.psd1'
            $TemplateKeys = Get-SimpleLocalizationKeys -FilePath $TemplateFile
            $LanguageFolders = Get-ChildItem -Path $LanguagePath -Directory | Where-Object { $_.Name -ne 'en-US' }
        }

        It 'Template (en-US) should have localization keys' {
            $TemplateKeys.Count | Should -BeGreaterThan 0
        }

        foreach ($folder in (Get-ChildItem -Path (Join-Path -Path $PSScriptRoot -ChildPath '..\..\AsBuiltReport.Core\Language') -Directory | Where-Object { $_.Name -ne 'en-US' })) {
            It "Language '<Name>' should have all keys from en-US template for New-AsBuiltReport.psd1" -TestCases @(@{ Name = $folder.Name; FolderPath = $folder.FullName }) {
                param($Name, $FolderPath)

                $LocalizedFile = Join-Path -Path $FolderPath -ChildPath 'New-AsBuiltReport.psd1'
                if (Test-Path $LocalizedFile) {
                    $LocalizedKeys = Get-SimpleLocalizationKeys -FilePath $LocalizedFile
                    $TemplatePath = Join-Path -Path $LanguagePath -ChildPath 'en-US\New-AsBuiltReport.psd1'
                    $TemplateKeysForTest = Get-SimpleLocalizationKeys -FilePath $TemplatePath

                    $MissingKeys = $TemplateKeysForTest | Where-Object { $_ -notin $LocalizedKeys }
                    $ExtraKeys = $LocalizedKeys | Where-Object { $_ -notin $TemplateKeysForTest }

                    if ($MissingKeys) {
                        $MissingKeys | Should -BeNullOrEmpty -Because "Language '$Name' is missing keys: $($MissingKeys -join ', ')"
                    }
                    if ($ExtraKeys) {
                        $ExtraKeys | Should -BeNullOrEmpty -Because "Language '$Name' has extra keys not in template: $($ExtraKeys -join ', ')"
                    }
                } else {
                    Set-ItResult -Skipped -Because "File not found: $LocalizedFile"
                }
            }
        }
    }

    Context 'AsBuiltReportCoreStyle.psd1 Localization Files' {
        BeforeAll {
            $TemplateFile = Join-Path -Path $LanguagePath -ChildPath 'en-US\AsBuiltReportCoreStyle.psd1'
            $TemplateKeys = Get-SimpleLocalizationKeys -FilePath $TemplateFile
        }

        It 'Template (en-US) should have localization keys' {
            $TemplateKeys.Count | Should -BeGreaterThan 0
        }

        foreach ($folder in (Get-ChildItem -Path (Join-Path -Path $PSScriptRoot -ChildPath '..\..\AsBuiltReport.Core\Language') -Directory | Where-Object { $_.Name -ne 'en-US' })) {
            It "Language '<Name>' should have all keys from en-US template for AsBuiltReportCoreStyle.psd1" -TestCases @(@{ Name = $folder.Name; FolderPath = $folder.FullName }) {
                param($Name, $FolderPath)

                $LocalizedFile = Join-Path -Path $FolderPath -ChildPath 'AsBuiltReportCoreStyle.psd1'
                if (Test-Path $LocalizedFile) {
                    $LocalizedKeys = Get-SimpleLocalizationKeys -FilePath $LocalizedFile
                    $TemplatePath = Join-Path -Path $LanguagePath -ChildPath 'en-US\AsBuiltReportCoreStyle.psd1'
                    $TemplateKeysForTest = Get-SimpleLocalizationKeys -FilePath $TemplatePath

                    $MissingKeys = $TemplateKeysForTest | Where-Object { $_ -notin $LocalizedKeys }
                    $ExtraKeys = $LocalizedKeys | Where-Object { $_ -notin $TemplateKeysForTest }

                    if ($MissingKeys) {
                        $MissingKeys | Should -BeNullOrEmpty -Because "Language '$Name' is missing keys: $($MissingKeys -join ', ')"
                    }
                    if ($ExtraKeys) {
                        $ExtraKeys | Should -BeNullOrEmpty -Because "Language '$Name' has extra keys not in template: $($ExtraKeys -join ', ')"
                    }
                } else {
                    Set-ItResult -Skipped -Because "File not found: $LocalizedFile"
                }
            }
        }
    }

    Context 'New-AsBuiltReportConfig.psd1 Localization Files' {
        BeforeAll {
            $TemplateFile = Join-Path -Path $LanguagePath -ChildPath 'en-US\New-AsBuiltReportConfig.psd1'
            $TemplateKeys = Get-SimpleLocalizationKeys -FilePath $TemplateFile
        }

        It 'Template (en-US) should have localization keys' {
            $TemplateKeys.Count | Should -BeGreaterThan 0
        }

        foreach ($folder in (Get-ChildItem -Path (Join-Path -Path $PSScriptRoot -ChildPath '..\..\AsBuiltReport.Core\Language') -Directory | Where-Object { $_.Name -ne 'en-US' })) {
            It "Language '<Name>' should have all keys from en-US template for New-AsBuiltReportConfig.psd1" -TestCases @(@{ Name = $folder.Name; FolderPath = $folder.FullName }) {
                param($Name, $FolderPath)

                $LocalizedFile = Join-Path -Path $FolderPath -ChildPath 'New-AsBuiltReportConfig.psd1'
                if (Test-Path $LocalizedFile) {
                    $LocalizedKeys = Get-SimpleLocalizationKeys -FilePath $LocalizedFile
                    $TemplatePath = Join-Path -Path $LanguagePath -ChildPath 'en-US\New-AsBuiltReportConfig.psd1'
                    $TemplateKeysForTest = Get-SimpleLocalizationKeys -FilePath $TemplatePath

                    $MissingKeys = $TemplateKeysForTest | Where-Object { $_ -notin $LocalizedKeys }
                    $ExtraKeys = $LocalizedKeys | Where-Object { $_ -notin $TemplateKeysForTest }

                    if ($MissingKeys) {
                        $MissingKeys | Should -BeNullOrEmpty -Because "Language '$Name' is missing keys: $($MissingKeys -join ', ')"
                    }
                    if ($ExtraKeys) {
                        $ExtraKeys | Should -BeNullOrEmpty -Because "Language '$Name' has extra keys not in template: $($ExtraKeys -join ', ')"
                    }
                } else {
                    Set-ItResult -Skipped -Because "File not found: $LocalizedFile"
                }
            }
        }
    }

    Context 'New-AsBuiltConfig.psd1 Localization Files (Nested Format)' {
        BeforeAll {
            $TemplateFile = Join-Path -Path $LanguagePath -ChildPath 'en-US\New-AsBuiltConfig.psd1'
            $TemplateKeys = Get-NestedLocalizationKeys -FilePath $TemplateFile
        }

        It 'Template (en-US) should have localization keys' {
            $TemplateKeys.Count | Should -BeGreaterThan 0
        }

        foreach ($folder in (Get-ChildItem -Path (Join-Path -Path $PSScriptRoot -ChildPath '..\..\AsBuiltReport.Core\Language') -Directory | Where-Object { $_.Name -ne 'en-US' })) {
            It "Language '<Name>' should have all keys from en-US template for New-AsBuiltConfig.psd1" -TestCases @(@{ Name = $folder.Name; FolderPath = $folder.FullName }) {
                param($Name, $FolderPath)

                $LocalizedFile = Join-Path -Path $FolderPath -ChildPath 'New-AsBuiltConfig.psd1'
                if (Test-Path $LocalizedFile) {
                    $LocalizedKeys = Get-NestedLocalizationKeys -FilePath $LocalizedFile
                    $TemplatePath = Join-Path -Path $LanguagePath -ChildPath 'en-US\New-AsBuiltConfig.psd1'
                    $TemplateKeysForTest = Get-NestedLocalizationKeys -FilePath $TemplatePath

                    $MissingKeys = $TemplateKeysForTest | Where-Object { $_ -notin $LocalizedKeys }
                    $ExtraKeys = $LocalizedKeys | Where-Object { $_ -notin $TemplateKeysForTest }

                    if ($MissingKeys) {
                        $MissingKeys | Should -BeNullOrEmpty -Because "Language '$Name' is missing keys: $($MissingKeys -join ', ')"
                    }
                    if ($ExtraKeys) {
                        $ExtraKeys | Should -BeNullOrEmpty -Because "Language '$Name' has extra keys not in template: $($ExtraKeys -join ', ')"
                    }
                } else {
                    Set-ItResult -Skipped -Because "File not found: $LocalizedFile"
                }
            }
        }
    }
}
