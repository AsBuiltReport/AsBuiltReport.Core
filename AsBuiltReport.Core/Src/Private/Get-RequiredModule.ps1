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
    $RequiredModule = Get-Module -ListAvailable -Name $Name |
        Sort-Object -Property Version -Descending |
        Select-Object -First 1

    if ($RequiredModule) {
        $ModuleVersion = "$($RequiredModule.Version.Major)" + "." + "$($RequiredModule.Version.Minor)" + "." + "$($RequiredModule.Version.Build)"
    } else {
        $ModuleVersion = $null
    }

    # Module not installed
    if (-not $ModuleVersion -or $ModuleVersion -eq ".") {
        throw ($translate.RequiredModuleNotInstalled -f $Name, $Version)
    }

    # Module version too old
    if ([Version]$ModuleVersion -lt [Version]$Version) {
        throw ($translate.RequiredModuleTooOld -f $Name, $ModuleVersion, $Version)
    }
}
