function Get-RequiredModule {
    <#
    .SYNOPSIS
        Checks if the required version of a PowerShell module is installed.

    .DESCRIPTION
        This function verifies that a specified PowerShell module is installed with the required
        minimum version. If the module is not installed or the version is too old, it throws an
        error with instructions on how to install or update the module.

    .PARAMETER Name
        The name of the required PowerShell module (e.g., 'Az', 'VMware.PowerCLI').

    .PARAMETER Version
        The minimum required version of the PowerShell module (e.g., '14.2.0').

    .EXAMPLE
        Get-RequiredModule -Name 'Az' -Version '14.2.0'

        Checks if Azure PowerShell module version 14.2.0 or higher is installed.

    .EXAMPLE
        Get-RequiredModule -Name 'VMware.PowerCLI' -Version '13.0.0'

        Checks if VMware PowerCLI version 13.0.0 or higher is installed.

    .NOTES
        This function uses the global $translate variable for localized error messages.
        Throws an error if the module is not installed or version is too old.
    #>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $false)]
        [ValidateNotNullOrEmpty()]
        [String] $Name,

        [Parameter(Mandatory = $true, ValueFromPipeline = $false)]
        [ValidateNotNullOrEmpty()]
        [String] $Version
    )

    # Check if the required version of the module is installed
    $RequiredModule = Get-Module -ListAvailable -Name $Name -ErrorAction SilentlyContinue |
        Sort-Object -Property Version -Descending |
        Select-Object -First 1

    # PowerShell 5.1 has known issues discovering rollup modules in OneDrive paths
    # If not found and we're in PS 5.1, try using Get-InstalledModule from PowerShellGet (if available)
    if (-not $RequiredModule -and $PSVersionTable.PSVersion.Major -le 5) {
        # Check if Get-InstalledModule cmdlet exists
        if (Get-Command -Name Get-InstalledModule -ErrorAction SilentlyContinue) {
            try {
                $RequiredModule = Get-InstalledModule -Name $Name -ErrorAction Stop |
                    Sort-Object -Property Version -Descending |
                    Select-Object -First 1
            } catch {
                # Get-InstalledModule failed or module not found
            }
        }
    }

    if ($RequiredModule) {
        # Get-InstalledModule returns a different object type, handle both
        if ($RequiredModule.Version -is [Version]) {
            # Standard Version object from Get-Module
            $Major = $RequiredModule.Version.Major
            $Minor = $RequiredModule.Version.Minor
            $Build = if ($RequiredModule.Version.Build -ge 0) { $RequiredModule.Version.Build } else { 0 }
            $ModuleVersion = "$Major.$Minor.$Build"
        } elseif ($RequiredModule.Version -is [String]) {
            # String version from Get-InstalledModule
            $ModuleVersion = $RequiredModule.Version
        } else {
            # Try to convert to string
            $ModuleVersion = $RequiredModule.Version.ToString()
        }
    } else {
        $ModuleVersion = $null
    }

    # Module not installed
    if (-not $ModuleVersion -or $ModuleVersion -eq ".." -or $ModuleVersion -eq ".-1.-1") {
        throw ($translate.RequiredModuleNotInstalled -f $Name, $Version)
    }

    # Module version too old
    if ([Version]$ModuleVersion -lt [Version]$Version) {
        throw ($translate.RequiredModuleTooOld -f $Name, $ModuleVersion, $Version)
    }

    # Output success message with installed version
    if ($VerbosePreference -eq 'Continue') {
        Write-PScriboMessage -Plugin "Module" -Message ($translate.RequiredModuleInstalled -f $Name, $ModuleVersion)
    } else {
        Write-Host -ForegroundColor White "  - $(($translate.RequiredModuleInstalled -f $Name, $ModuleVersion))"
    }
}