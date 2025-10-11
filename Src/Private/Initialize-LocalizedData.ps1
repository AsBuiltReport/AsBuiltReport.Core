function Initialize-LocalizedData {
    <#
    .SYNOPSIS
        Initializes localized data for AsBuiltReport Core and Report modules.

    .DESCRIPTION
        This function loads localized strings from language files (.psd1) based on the specified or detected culture.
        It supports both Core and Report modules with intelligent fallback logic:

        For Core modules (when no Language parameter specified):
        - Uses the user's OS language (Get-Culture)
        - Searches the Core module's Language folder with culture fallback

        For Report modules (when no Language parameter specified):
        - Defaults to en-US
        - Searches the Report module's Language folder with culture fallback
        - Falls back to the Core module's Language folder for shared translations

        When Language parameter is explicitly provided:
        - Uses the specified language for both Core and Report modules

        Language selection priority for Report modules:
        1. ReportLanguage parameter (if explicitly specified by user)
        2. Report.Language setting from JSON configuration file
        3. Default fallback to 'en-US'

    .PARAMETER ModuleBasePath
        The base path of the module containing the Language folder.
        This should point to the module's root directory where the Language subfolder is located.

    .PARAMETER LanguageFile
        The name of the language file (without .psd1 extension).

    .PARAMETER ModuleType
        The type of module: 'Core' or 'Report'. Defaults to 'Core'.

    .PARAMETER ModuleName
        The name of the report module (e.g., 'VMware.vSphere').
        Used for Report modules to help identify the module context.

    .PARAMETER Language
        The specific language to use (e.g., 'en-US', 'es-ES', 'fr-FR').
        If not specified:
        - Core modules use the user's OS language
        - Report modules default to 'en-US'

    .EXAMPLE
        # Core module usage - uses OS language
        Initialize-LocalizedData -ModuleBasePath $PSScriptRoot -LanguageFile 'New-AsBuiltReport' -ModuleType 'Core'

    .EXAMPLE
        # Core module usage with explicit language
        Initialize-LocalizedData -ModuleBasePath $PSScriptRoot -LanguageFile 'New-AsBuiltReport' -ModuleType 'Core' -Language 'fr-FR'

    .EXAMPLE
        # Report module usage - defaults to en-US
        Initialize-LocalizedData -ModuleBasePath $PSScriptRoot -LanguageFile 'VMwareSphere' -ModuleType 'Report' -ModuleName 'VMware.vSphere'

    .EXAMPLE
        # Report module usage with explicit language
        Initialize-LocalizedData -ModuleBasePath $PSScriptRoot -LanguageFile 'VMwareSphere' -ModuleType 'Report' -ModuleName 'VMware.vSphere' -Language 'es-ES'

    .NOTES
        Sets global variable $global:translate with the loaded translations.
        Uses Resolve-Culture function for comprehensive culture fallback.
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [string]$ModuleBasePath,

        [Parameter(Mandatory = $true)]
        [string]$LanguageFile,

        [Parameter()]
        [ValidateSet('Core', 'Report')]
        [string]$ModuleType = 'Core',

        [Parameter()]
        [string]$ModuleName,

        [Parameter()]
        [string]$Language
    )

    try {
        # Determine which language to use based on parameters and module type
        if ($Language) {
            # Explicit language parameter provided
            $Culture = [System.Globalization.CultureInfo]::GetCultureInfo($Language)
        } elseif ($ModuleType -eq 'Core') {
            # For Core modules, use the user's OS language
            $Culture = Get-Culture
        } else {
            # For Report modules without explicit language, use en-US as default
            $Culture = [System.Globalization.CultureInfo]::GetCultureInfo('en-US')
        }
        $PSDefaultParameterValues['*:UICulture'] = $Culture.Name
        $PSDefaultParameterValues['*:Culture'] = $Culture.Name
    } catch {
        Write-Error ($_.Exception.Message)
        return
    }

    # Setup all paths required for script to run
    $script:RootPath = $ModuleBasePath

    # Define search paths based on module type
    $SearchPaths = @()
    if ($ModuleType -eq 'Report' -and $ModuleName) {
        # For report modules, search report module first, then core module
        $ReportLangPath = Join-Path $RootPath 'Language'
        $SearchPaths += @{Path = $ReportLangPath; Type = 'Report'}

        # Try to find Core module path for fallback
        try {
            $CoreModule = Get-Module -Name 'AsBuiltReport.Core' -ListAvailable | Sort-Object -Property Version -Descending | Select-Object -First 1
            if ($CoreModule) {
                $CoreLangPath = Join-Path $CoreModule.ModuleBase 'Language'
                $SearchPaths += @{Path = $CoreLangPath; Type = 'Core'}
            }
        } catch {
            Write-Warning "Could not locate AsBuiltReport.Core module for fallback translations"
        }
    } else {
        # For core modules, use the existing logic
        $script:LangPath = Join-Path $RootPath 'Language'
        $SearchPaths += @{Path = $script:LangPath; Type = 'Core'}
    }

    # Get fallback chain for current culture
    $CultureFallbacks = Resolve-Culture -CultureName $Culture.Name

    # Find first available culture where BOTH folder AND file exist
    $TargetCulture = $null
    $Translate = $null
    $FoundPath = $null

    # Search through all search paths and culture fallbacks
    foreach ($SearchPath in $SearchPaths) {
        foreach ($FallbackCulture in $CultureFallbacks) {
            $TestPath = Join-Path $SearchPath.Path $FallbackCulture
            $TestFile = Join-Path $TestPath "$LanguageFile.psd1"
            if ((Test-Path $TestPath) -and (Test-Path $TestFile)) {
                try {
                    # Test if the file can actually be imported
                    $TestImport = Import-LocalizedData -BaseDirectory $SearchPath.Path -UICulture $FallbackCulture -FileName $LanguageFile -ErrorAction Stop
                    $TargetCulture = $FallbackCulture
                    $Translate = $TestImport
                    $FoundPath = $SearchPath.Path
                    $script:LangPath = $SearchPath.Path
                    break
                } catch {
                    # Continue to next fallback if import fails
                    Write-Error "Cannot load $FallbackCulture language file. Ensure $TestFile exists and is valid." -ErrorAction Stop
                }
            }
        }
        # If we found a translation, break out of search paths loop
        if ($TargetCulture) { break }
    }

    # Final safety net - try en-US if nothing else worked
    if (-not $TargetCulture -or -not $Translate) {
        foreach ($SearchPath in $SearchPaths) {
            $TestPath = Join-Path $SearchPath.Path 'en-US'
            $TestFile = Join-Path $TestPath "$LanguageFile.psd1"

            if ((Test-Path $TestPath) -and (Test-Path $TestFile)) {
                try {
                    $Translate = Import-LocalizedData -BaseDirectory $SearchPath.Path -UICulture 'en-US' -FileName $LanguageFile -ErrorAction Stop
                    $TargetCulture = 'en-US'
                    $FoundPath = $SearchPath.Path
                    $script:LangPath = $SearchPath.Path
                    break
                } catch {
                    Write-Error "Cannot load en-US language file. Ensure $TestFile exists and is valid." -ErrorAction Stop
                }
            }
        }

        # If still no translation found, error out
        if (-not $TargetCulture -or -not $Translate) {
            $SearchedPaths = ($SearchPaths | ForEach-Object { Join-Path $_.Path "en-US\$LanguageFile.psd1" }) -join ', '
            Write-Error "en-US language file not found in any of the searched paths: $SearchedPaths" -ErrorAction Stop
        }
    }

    $script:CulturePath = Join-Path $script:LangPath $TargetCulture

    # Output appropriate message (only once per session per culture/module combination)
    # Determine the source of the translations
    $SourceType = $null
    foreach ($SearchPath in $SearchPaths) {
        if ($SearchPath.Path -eq $FoundPath) {
            $SourceType = $SearchPath.Type
            break
        }
    }

    # Determine the appropriate message based on module type
    # Core module = UI language, Report module = Document language
    $LanguageType = if ($ModuleType -eq 'Core') { "UI language" } else { "document language" }


    # Determine the language source for Report modules
    $LanguageSourceText = ""
    if ($ModuleType -eq 'Report' -and $Language) {
        # Check if the language was explicitly specified via command-line parameter
        # by examining if ReportConfig exists and comparing with its language setting
        if ($global:ReportConfig -and $global:ReportConfig.Report.Language) {
            if ($Language -eq $global:ReportConfig.Report.Language) {
                $LanguageSourceText = " (from report configuration file)"
            } else {
                # Language differs from config, so it must be from command-line
                $LanguageSourceText = " (from command-line parameter)"
            }
        } elseif ($Language -eq 'en-US') {
            # Default language
            $LanguageSourceText = " (fallback to default)"
        } else {
            # Explicitly specified via command-line (no config or config doesn't have language)
            $LanguageSourceText = " (from command-line parameter)"
        }
    }
    # Create unique key for this culture fallback scenario
    # When there's a fallback, include module type to show both messages
    # When there's no fallback, just use culture to avoid duplicate messages for same culture
    if ($TargetCulture -ne $Culture.Name) {
        $LocalizationKey = "$TargetCulture-$($Culture.Name)-$ModuleType"
    } else {
        $LocalizationKey = "$TargetCulture"
    }

    # Initialize global tracking variable if it doesn't exist
    if (-not $global:AsBuiltReportLocalizedWarnings) {
        $global:AsBuiltReportLocalizedWarnings = @{}
    }

    # Only show message if we haven't shown it before for this combination
    $ShouldShowMessage = -not $global:AsBuiltReportLocalizedWarnings.ContainsKey($LocalizationKey)

    # Suppress messages for style-related language files (internal implementation detail)
    if ($LanguageFile -eq 'AsBuiltReportCoreStyle') {
        $ShouldShowMessage = $false
    }

    if ($ShouldShowMessage) {
        if ($TargetCulture -ne $Culture.Name) {
            Write-Host ("Setting $LanguageType to '{0}' (fallback from '{1}')$LanguageSourceText." -f $TargetCulture, $Culture.Name) -ForegroundColor Yellow
        } else {
            Write-Host ("Setting $LanguageType to '{0}'$LanguageSourceText." -f $TargetCulture) -ForegroundColor Yellow
        }

        # Mark this combination as already shown
        $global:AsBuiltReportLocalizedWarnings[$LocalizationKey] = $true
    }

    # Set as global variable
    $global:translate = $Translate
}