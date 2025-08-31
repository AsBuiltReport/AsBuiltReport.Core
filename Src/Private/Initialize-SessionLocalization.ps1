function Initialize-SessionLocalization {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [string]$ScriptRoot,

        [Parameter(Mandatory = $true)]
        [string]$LanguageFile
    )

    try {
        #$Culture = [System.Globalization.CultureInfo]::GetCultureInfo($Language)
        $Culture = Get-Culture

        $PSDefaultParameterValues['*:UICulture'] = $Culture.Name
        $PSDefaultParameterValues['*:Culture'] = $Culture.Name
    } catch {
        Write-Error -Message ($_.Exception.Message)
        return
    }

    $DirectorySeparatorChar = [System.IO.Path]::DirectorySeparatorChar

    # Setup all paths required for script to run
    $script:RootPath = $ScriptRoot
    $script:LangPath = Join-Path $RootPath 'Language'

    # Get fallback chain for current culture
    $CultureFallbacks = Resolve-Culture -CultureName $Culture.Name

    # Find first available culture where BOTH folder AND file exist
    $TargetCulture = $null
    $translate = $null

    foreach ($FallbackCulture in $CultureFallbacks) {
        $TestPath = Join-Path $script:LangPath $FallbackCulture
        $TestFile = Join-Path $TestPath "$LanguageFile.psd1"
        if ((Test-Path $TestPath) -and (Test-Path $TestFile)) {
            try {
                # Test if the file can actually be imported
                $testImport = Import-LocalizedData -BaseDirectory $script:LangPath -UICulture $FallbackCulture -FileName $LanguageFile -ErrorAction Stop
                $TargetCulture = $FallbackCulture
                $translate = $testImport
                break
            } catch {
                # Continue to next fallback if import fails
                Write-Error "Cannot load $FallbackCulture language file. Ensure $($TestPath + $DirectorySeparatorChar + $LanguageFile + ".psd1") exists and is valid." -ErrorAction Stop
            }
        }
    }

    # Final safety net - try en-US if nothing else worked
    if (-not $TargetCulture -or -not $translate) {
        $TestPath = Join-Path $script:LangPath 'en-US'
        $TestFile = Join-Path $TestPath "$LanguageFile.psd1"

        if ((Test-Path $TestPath) -and (Test-Path $TestFile)) {
            try {
                $translate = Import-LocalizedData -BaseDirectory $script:LangPath -UICulture 'en-US' -FileName $LanguageFile -ErrorAction Stop
                $TargetCulture = 'en-US'
            } catch {
                Write-Error "Cannot load en-US language file. Ensure $($TestPath + $DirectorySeparatorChar + $LanguageFile + ".psd1") exists and is valid." -ErrorAction Stop
            }
        } else {
            Write-Error "en-US language folder or file not found at $TestFile" -ErrorAction Stop
        }
    }

    $script:CulturePath = Join-Path $script:LangPath $TargetCulture

    # Output appropriate message
    Clear-Host
    if ($TargetCulture -ne $Culture.Name) {
        Write-Warning -Message ("Setting report language to '{0}' (fallback from '{1}')." -f $TargetCulture, $Culture.Name)
        Start-Sleep -Seconds 1.5
    } else {
        Write-Host -Message ("Setting report language to '{0}'" -f $TargetCulture) -ForegroundColor Green
        Start-Sleep -Seconds 1.5
    }

    # Set as global variable
    $global:translate = $translate

    # Return the localized data for use by calling code
    return $translate
}