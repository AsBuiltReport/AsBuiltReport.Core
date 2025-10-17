function Write-ReportModuleInfo {
    <#
    .SYNOPSIS
        Displays informational messages about the report module being executed.

    .DESCRIPTION
        This function displays standardized informational messages about the report module,
        including documentation links and version information. The output method varies based
        on whether verbose mode is enabled:
        - Verbose mode: Uses Write-PScriboMessage for consistent logging
        - Non-verbose mode: Uses Write-Host for user-friendly colored output

    .PARAMETER ModuleName
        The name of the report module (e.g., 'Microsoft.Azure', 'VMware.vSphere').
        This is used to construct GitHub URLs and module-specific messages.

    .EXAMPLE
        Write-ReportModuleInfo -ModuleName 'Microsoft.Azure'

        Displays informational messages about the Microsoft Azure report module.

    .EXAMPLE
        Write-ReportModuleInfo -ModuleName 'VMware.vSphere'

        Displays informational messages about the VMware vSphere report module.

    .NOTES
        This function uses the global $translate variable for localized messages.
        The function automatically detects verbose mode using $VerbosePreference.
        Requires [CmdletBinding()] on the calling function to properly inherit -Verbose parameter.
    #>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [String] $ModuleName
    )

    # Construct the full module name
    $FullModuleName = "AsBuiltReport.$ModuleName"

    # Display informational messages - use appropriate output method based on verbose preference
    if ($VerbosePreference -eq 'Continue') {
        # Check the current report module version
        $InstalledVersion = Get-Module -ListAvailable -Name $FullModuleName -ErrorAction SilentlyContinue |
            Sort-Object -Property Version -Descending |
            Select-Object -First 1 -ExpandProperty Version

        if ($InstalledVersion) {
            Write-PScriboMessage -Plugin "Module" -Message ($translate.ReportModuleInstalled -f $FullModuleName, "v$($InstalledVersion.ToString())")

            $LatestVersion = Find-Module -Name $FullModuleName -Repository PSGallery -ErrorAction SilentlyContinue |
                Select-Object -ExpandProperty Version

            if ($LatestVersion -and ($InstalledVersion -lt $LatestVersion)) {
                Write-PScriboMessage -Plugin "Module" -IsWarning -Message ($translate.ReportModuleAvailable -f $FullModuleName, "v$($LatestVersion.ToString())")
                Write-PScriboMessage -Plugin "Module" -IsWarning -Message ($translate.ReportModuleUpdate -f $FullModuleName)
            }
        }

        # Verbose mode - use Write-PScriboMessage for consistent logging
        Write-PScriboMessage -Plugin "Module" -Message ($translate.ReportModuleInfo1 -f $ModuleName)
        Write-PScriboMessage -Plugin "Module" -Message ($translate.ReportModuleInfo2 -f $ModuleName)
        Write-PScriboMessage -Plugin "Module" -Message $translate.ReportModuleInfo3
        Write-PScriboMessage -Plugin "Module" -Message $translate.ProjectWebsite
        Write-PScriboMessage -Plugin "Module" -Message $translate.CommunityProject

    } else {
        # Check the current report module version
        $InstalledVersion = Get-Module -ListAvailable -Name $FullModuleName -ErrorAction SilentlyContinue |
            Sort-Object -Property Version -Descending |
            Select-Object -First 1 -ExpandProperty Version

        if ($InstalledVersion) {
            Write-Host -ForegroundColor White "  - $(($translate.ReportModuleInstalled -f $FullModuleName, "v$($InstalledVersion.ToString())"))"

            $LatestVersion = Find-Module -Name $FullModuleName -Repository PSGallery -ErrorAction SilentlyContinue |
                Select-Object -ExpandProperty Version

            if ($LatestVersion -and ($InstalledVersion -lt $LatestVersion)) {
                Write-Host -ForegroundColor Red ($translate.ReportModuleAvailable -f $FullModuleName, "v$($LatestVersion.ToString())")
                Write-Host -ForegroundColor Red ($translate.ReportModuleUpdate -f $FullModuleName)
            }
        }

        # Non-verbose mode - use Write-Host for user-friendly output
        Write-Host -ForegroundColor White "  - $(($translate.ReportModuleInfo1 -f $ModuleName))"
        Write-Host -ForegroundColor White "  - $(($translate.ReportModuleInfo2 -f $ModuleName))"
        Write-Host -ForegroundColor White "  - $($translate.ReportModuleInfo3)"
        Write-Host -ForegroundColor White "  - $($translate.ProjectWebsite)"
        Write-Host -ForegroundColor White "  - $($translate.CommunityProject)"
    }
}
