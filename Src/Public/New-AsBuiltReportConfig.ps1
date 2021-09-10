function New-AsBuiltReportConfig {
    <#
    .SYNOPSIS  
        Creates JSON configuration files for individual As Built Reports.
    .DESCRIPTION
        Creates JSON configuration files for individual As Built Reports.
    .PARAMETER Report
        Specifies the type of report configuration to create.
    .PARAMETER FolderPath
        Specifies the folder path to create the report JSON configuration file.
    .PARAMETER Filename
        Specifies the filename of the report JSON configuration file.
        If filename is not specified, a JSON configuration file will be created with a default filename AsBuiltReport.<Vendor>.<Product>.json
    .PARAMETER Force
        Specifies to overwrite any existing report JSON configuration file
    .EXAMPLE
        Creates a report configuration file for VMware vSphere, named 'vSphere_Report_Config' in 'C:\Reports' folder. 
        New-AsBuiltReportConfig -Report VMware.vSphere -FolderPath 'C:\Reports' -Filename 'vSphere_Report_Config'
    .EXAMPLE
        Creates a report configuration file for Nutanix Prism Central, named 'AsBuiltReport.Nutanix.PrismCentral' in 'C:\Reports' folder, overwriting any existing file. 
        New-AsBuiltReportConfig -Report Nutanix.PrismCentral -FolderPath 'C:\Reports' -Force
    #>
    [CmdletBinding()]
    param (
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Please provide the name of the report to generate the JSON configuration for'
        )]
        [ValidateNotNullOrEmpty()]
        [ValidateScript( {
                $InstalledReportModules = Get-Module -Name "AsBuiltReport.*" -ListAvailable | Where-Object { $_.name -ne 'AsBuiltReport.Core' } | Sort-Object -Property Version -Descending | Select-Object -Unique
                $ValidReports = foreach ($InstalledReportModule in $InstalledReportModules) {
                    $NameArray = $InstalledReportModule.Name.Split('.')
                    "$($NameArray[-2]).$($NameArray[-1])"
                }
                if ($ValidReports -contains $_) {
                    $true
                } else {
                    throw "Invalid report type specified! Please use one of the following [$($ValidReports -Join ', ')]"
                }
            })]
        [String] $Report,

        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Please provide the folder path to save the JSON configuration file'
        )]
        [ValidateNotNullOrEmpty()]
        [Alias('Path')] 
        [String] $FolderPath,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Please provide the filename of the JSON configuration file'
        )]
        [ValidateNotNullOrEmpty()]
        [Alias('Name')]
        [String] $Filename,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Used to overwrite the destination file if it exists'
        )]
        [ValidateNotNullOrEmpty()]
        [Alias('Overwrite')]
        [Switch] $Force
    )

    # Test to ensure the path the user has specified does exist
    if (!(Test-Path -Path $FolderPath)) {
        Write-Error "The Path '$FolderPath' does not exist. Please create the folder and run New-AsBuiltReportConfig again."
        break
    }
    # Find the root folder where the module is located for the report that has been specified
    try {
        $Module = Get-Module -Name "AsBuiltReport.$Report" -ListAvailable | Where-Object { $_.name -ne 'AsBuiltReport.Core' } | Sort-Object -Property Version -Descending | Select-Object -Unique
        if (Test-Path -Path "$($Module.ModuleBase)\$($Module.Name).json") {
            Write-Verbose -Message "Processing report configuration file from module $($Module), version $($Module.Version)."
            if ($Filename) {
                if (!(Test-Path -Path "$($FolderPath)\$($Filename).json")) {
                    Write-Verbose -Message "Copying report configuration file '$($Module.ModuleBase)\$($Module.Name).json' to '$($FolderPath)\$($Filename).json'."
                    Copy-Item -Path "$($Module.ModuleBase)\$($Module.Name).json" -Destination "$($FolderPath)\$($Filename).json"
                    Write-Output "Report configuration file '$($Filename).json' created in '$FolderPath'."
                } elseif ($Force) {
                    Write-Verbose -Message "Copying report configuration file '$($Module.ModuleBase)\$($Module.Name).json' to '$($FolderPath)\$($Filename).json'. Overwriting existing file."
                    Copy-Item -Path "$($Module.ModuleBase)\$($Module.Name).json" -Destination "$($FolderPath)\$($Filename).json" -Force
                    Write-Output "Report configuration file '$($Filename).json' created in '$FolderPath'."
                } else {
                    Write-Error "Report configuration file '$($Filename).json' already exists in '$FolderPath'. Use 'Force' parameter to overwrite existing file."
                }
            } else {
                if (!(Test-Path -Path "$($FolderPath)\$($Module.Name).json")) {
                    Write-Verbose -Message "Copying report configuration file '$($Module.ModuleBase)\$($Module.Name).json' to destination folder '$FolderPath'."
                    Copy-Item -Path "$($Module.ModuleBase)\$($Module.Name).json" -Destination $FolderPath
                    Write-Output "Report configuration file '$($Module.Name).json' created in '$FolderPath'."
                } elseif ($Force) {
                    Write-Verbose -Message "Copying report configuration file '$($Module.ModuleBase)\$($Module.Name).json' to destination folder '$FolderPath'. Overwriting existing file."
                    Copy-Item -Path "$($Module.ModuleBase)\$($Module.Name).json" -Destination $FolderPath -Force
                    Write-Output "Report configuration file '$($Module.Name).json' created in '$FolderPath'."
                } else {
                    Write-Error "Report configuration file '$($Module.Name).json' already exists in '$FolderPath'. Use 'Force' parameter to overwrite existing file."
                }
            }
        } else {
            Write-Error "Report configuration file not found in module path '$($Module.ModuleBase)'."
        }
    } catch {
        Write-Error $_
    }
}

Register-ArgumentCompleter -CommandName 'New-AsBuiltReportConfig' -ParameterName 'Report' -ScriptBlock {
    param (
        $commandName,
        $parameterName,
        $wordToComplete,
        $commandAst,
        $fakeBoundParameter
    )

    $InstalledReportModules = Get-Module -Name "AsBuiltReport.*" -ListAvailable | Where-Object { $_.name -ne 'AsBuiltReport.Core' } | Sort-Object -Property Version -Descending | Select-Object -Unique
    $ValidReports = foreach ($InstalledReportModule in $InstalledReportModules) {
        $NameArray = $InstalledReportModule.Name.Split('.')
        "$($NameArray[-2]).$($NameArray[-1])"
    }

    $ValidReports | Where-Object { $_ -like "$wordToComplete*" } | ForEach-Object {
        [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
    }
}