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
        New-AsBuiltReportConfig -Report VMware.vSphere -FolderPath 'C:\Reports' -Filename 'vSphere_Report_Config'

        Creates a VMware vSphere report configuration file named 'vSphere_Report_Config.json' in the 'C:\Reports' folder.
    .EXAMPLE
        New-AsBuiltReportConfig -Report Nutanix.PrismElement -FolderPath '/Users/Tim/Reports' -Force

        Creates a Nutanix Prism Element report configuration file name 'AsBuiltReport.Nutanix.PrismElement.json' in '/Users/Tim/Reports' folder and overwrites the existing file.
    .LINK
        https://github.com/AsBuiltReport/AsBuiltReport.Core
    .LINK
        https://www.asbuiltreport.com/user-guide/new-asbuiltreportconfig/
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
                    throw "Invalid report type specified. Please use one of the following [$($ValidReports -Join ', ')]"
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

    Initialize-LocalizedData -ModuleType 'Core' -ModuleBasePath (Split-Path (Split-Path $PSScriptRoot -Parent) -Parent) -LanguageFile 'New-AsBuiltReportConfig'

    # Test to ensure the path the user has specified does exist
    if (-not (Test-Path -Path $($FolderPath))) {
        Write-Error ($translate.FolderNotExist -f $($FolderPath)) -ErrorAction Stop
    }
    # Find the root folder where the module is located for the report that has been specified
    try {
        $Module = Get-Module -Name "AsBuiltReport.$Report" -ListAvailable | Where-Object { $_.name -ne 'AsBuiltReport.Core' } | Sort-Object -Property Version -Descending | Select-Object -Unique
        $SourcePath = Join-Path -Path $($Module.ModuleBase) -ChildPath "$($Module.Name).json"
        if (Test-Path -Path $($SourcePath)) {
            Write-Verbose ($translate.ProcessConfig -f $Module.Name, $Module, $Module.Version)
            if ($Filename) {
                $DestinationPath = Join-Path -Path $($FolderPath) -ChildPath "$($Filename).json"
                if (-not (Test-Path -Path $($DestinationPath))) {
                    Write-Verbose ($translate.CopyConfig -f $SourcePath, $DestinationPath)
                    Copy-Item -Path $($SourcePath) -Destination "$($DestinationPath)"
                    Write-Output ($translate.CreateConfig -f $Module.Name, $Filename, $FolderPath)
                } elseif ($Force) {
                    Write-Verbose ($translate.OverWriteConfig -f $SourcePath, $DestinationPath)
                    Copy-Item -Path $($SourcePath) -Destination $($DestinationPath) -Force
                    Write-Output ($translate.CreateConfig -f $Module.Name, $Filename, $FolderPath)
                } else {
                    Write-Error ($translate.ForceOverwrite -f $Module.Name, $Filename, $FolderPath)
                }
            } else {
                $DestinationPath = Join-Path -Path $($FolderPath) -ChildPath "$($Module.Name).json"
                if (-not (Test-Path -Path $($DestinationPath))) {
                    Write-Verbose ($translate.CopyModuleConfig -f $Module.Name, $SourcePath, $DestinationPath)
                    Copy-Item -Path $($SourcePath) -Destination $($DestinationPath)
                    Write-Output ($translate.CreateConfig -f $Module.Name, $Module.Name, $FolderPath)
                } elseif ($Force) {
                    Write-Verbose ($translate.OverWriteConfig -f $SourcePath, $DestinationPath)
                    Copy-Item -Path $($SourcePath) -Destination $($DestinationPath) -Force
                    Write-Output ($translate.CreateConfig -f $Module.Name, $Module.Name, $FolderPath)
                } else {
                    Write-Error ($translate.ForceOverwrite -f $Module.Name, $Module.Name, $FolderPath)
                }
            }
        } else {
            Write-Error ($translate.ConfigNotFound -f $Module.ModuleBase)
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