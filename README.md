<p align="center">
    <a href="https://www.asbuiltreport.com/" alt="AsBuiltReport"></a>
            <img src='https://raw.githubusercontent.com/AsBuiltReport/AsBuiltReport/master/AsBuiltReport.png' width="8%" height="8%" /></a>
</p>
<p align="center">
    <a href="https://www.powershellgallery.com/packages/AsBuiltReport.Core/" alt="PowerShell Gallery Version">
        <img src="https://img.shields.io/powershellgallery/v/AsBuiltReport.Core.svg" /></a>
    <a href="https://www.powershellgallery.com/packages/AsBuiltReport.Core/" alt="PS Gallery Downloads">
        <img src="https://img.shields.io/powershellgallery/dt/AsBuiltReport.Core.svg" /></a>
    <a href="https://www.powershellgallery.com/packages/AsBuiltReport.Core/" alt="PS Platform">
        <img src="https://img.shields.io/powershellgallery/p/AsBuiltReport.Core.svg" /></a>
</p>
<p align="center">
    <a href="https://github.com/AsBuiltReport/AsBuiltReport.Core/graphs/commit-activity" alt="GitHub Last Commit">
        <img src="https://img.shields.io/github/last-commit/AsBuiltReport/AsBuiltReport.Core/master.svg" /></a>
    <a href="https://raw.githubusercontent.com/AsBuiltReport/AsBuiltReport.Core/master/LICENSE" alt="GitHub License">
        <img src="https://img.shields.io/github/license/AsBuiltReport/AsBuiltReport.Core.svg" /></a>
    <a href="https://github.com/AsBuiltReport/AsBuiltReport.Core/graphs/contributors" alt="GitHub Contributors">
        <img src="https://img.shields.io/github/contributors/AsBuiltReport/AsBuiltReport.Core.svg"/></a>
</p>
<p align="center">
    <a href="https://twitter.com/AsBuiltReport" alt="Twitter">
            <img src="https://img.shields.io/twitter/follow/AsBuiltReport.svg?style=social"/></a>
</p>

# AsBuiltReport.Core

AsBuiltReport.Core is a PowerShell module which provides the core framework for generating as built documentation for many common datacentre systems. The AsBuiltReport.Core module is required by each individual report module used to generate as built documentation for a specific product and/or technology.

# :beginner: Getting Started

The following simple list of instructions will get you started with the AsBuiltReport.Core module.

## :floppy_disk: Supported Versions
### **PowerShell**
This report is compatible with the following PowerShell versions;

| Windows PowerShell 5.1 | PowerShell 7 |
|:----------------------:|:------------------:|
|   :white_check_mark:   | :white_check_mark: |

## :wrench: System Requirements

The following module will be automatically installed by following the [module installation](https://github.com/AsBuiltReport/AsBuiltReport.Core#package-module-installation) procedure.

This module may also be manually installed.

| Module Name        | Minimum Required Version |                          PS Gallery                           |                                   GitHub                                    |
|--------------------|:------------------------:|:---------------------------------------------------------------------:|:---------------------------------------------------------------------------:|
| PScribo            |          0.9.1           |      [Link](https://www.powershellgallery.com/packages/PScribo)       |         [Link](https://github.com/iainbrighton/PScribo/tree/master)

To find a list of available report modules, run the following PowerShell command;

```powershell
Find-Module -Name AsBuiltReport.* -Repository PSGallery
```

The pre-requisites for each report type will be documented within its own `README.md` located in the relevant report repository.

## :package: Module Installation

### **PowerShell**
Open a PowerShell terminal window and install the required module as follows;
```powershell
install-module AsBuiltReport.Core
```

### **GitHub**
If you are unable to use the PowerShell Gallery, you can still install the module manually. Ensure you repeat the following steps for the [system requirements](https://github.com/AsBuiltReport/AsBuiltReport.Core#wrench-system-requirements) also.

1. Download the [latest release](https://github.com/AsBuiltReport/AsBuiltReport.Core/releases/latest) zip from GitHub
2. Extract the zip file
3. Copy the folder `AsBuiltReport.Core` to a path that is set in `$env:PSModulePath`. By default this could be `C:\Program Files\WindowsPowerShell\Modules` or `C:\Users\<user>\Documents\WindowsPowerShell\Modules`
4. Open a PowerShell terminal window and unblock the downloaded files with
    ```powershell
    $path = (Get-Module -Name AsBuiltReport.Core -ListAvailable).ModuleBase; Unblock-File -Path $path\*.psd1; Unblock-File -Path $path\Src\Public\*.ps1
    ```
5. Close and reopen the PowerShell terminal window.

_Note: You are not limited to installing the module to those example paths, you can add a new entry to the environment variable PSModulePath if you want to use another path._

## :pencil2: Commands

### **New-AsBuiltReport**

The `New-AsBuiltReport` cmdlet is used to generate as built reports. The type of as built report to generate is specified by using the `Report` parameter. The report parameter relies on additional report modules being installed alongside the `AsBuiltReport.Core` module. The `Target` parameter specifies one or more systems on which to connect and run the report. User credentials to the system are specifed using the `Credential`, or the `Username` and `Password` parameters. One or more document formats, such as `HTML`, `Word` or `Text` can be specified using the `Format` parameter. Additional parameters are outlined below.

```powershell
.PARAMETER Report
    Specifies the type of report that will be generated.
.PARAMETER Target
    Specifies the IP/FQDN of the system to connect.
    Multiple targets may be specified, separated by a comma.
.PARAMETER Credential
    Specifies the stored credential of the target system.
.PARAMETER Username
    Specifies the username for the target system.
.PARAMETER Password
    Specifies the password for the target system.
.PARAMETER Token
    Specifies an API token to authenticate to the target system.
.PARAMETER MFA
    Use multifactor authentication to authenticate to the target system.
.PARAMETER Format
    Specifies the output format of the report.
    The supported output formats are WORD, HTML & TEXT.
    Multiple output formats may be specified, separated by a comma.
.PARAMETER Orientation
    Sets the page orientation of the report to Portrait or Landscape.
    By default, page orientation will be set to Portrait.
.PARAMETER StyleFilePath
    Specifies the file path to a custom style .ps1 script for the report to use.
.PARAMETER OutputFolderPath
    Specifies the folder path to save the report.
.PARAMETER Filename
    Specifies a filename for the report.
.PARAMETER Timestamp
    Specifies whether to append a timestamp string to the report filename.
    By default, the timestamp string is not added to the report filename.
.PARAMETER EnableHealthCheck
    Performs a health check of the target environment and highlights known issues within the report.
    Not all reports may provide this functionality.
.PARAMETER SendEmail
    Sends report to specified recipients as email attachments.
.PARAMETER AsBuiltConfigFilePath
    Enter the full path to the As Built Report configuration JSON file.
    If this parameter is not specified, the user will be prompted for this configuration information on first
    run, with the option to save the configuration to a file.
.PARAMETER ReportConfigFilePath
    Enter the full path to a report JSON configuration file.
    If this parameter is not specified, a default report configuration JSON is copied to the specifed user folder.
    If this paramter is specified and the path to a JSON file is invalid, the script will terminate
```

For a full list of common parameters and examples you can view the `New-AsBuiltReport` cmdlet help with the following command;

```powershell
Get-Help New-AsBuiltReport -Full
```

### **New-AsBuiltConfig**
`New-AsBuiltConfig` starts a menu-driven procedure in the powershell console and asks the user a series of questions. Answers to these questions are optionally saved in a JSON configuration file which can then be referenced using the `-AsBuiltConfigFilePath` parameter using `New-AsBuiltReport`, to save having to answer these questions again and also to allow the automation of `New-AsBuiltReport`.

`New-AsBuiltConfig` will automatically be called by `New-AsBuiltReport` if the `-AsBuiltConfigFilePath` parameter is not specified. If a user wants to generate a new As Built JSON configuration without running a new report, this cmdlet can be called as a standalone cmdlet.

### **New-AsBuiltReportConfig**

The `New-AsBuiltReportConfig` cmdlet is used to create JSON configuration files for individual As Built Reports. Cmdlet parameters and examples are outlined below.

```powershell
.PARAMETER Report
    Specifies the type of report configuration to create.
.PARAMETER FolderPath
    Specifies the folder path to create the report JSON configuration file.
.PARAMETER Filename
    Specifies the filename of the report JSON configuration file.
    If Name is not specified, a JSON configuration file will be created with a default name AsBuiltReport.<Vendor>.<Product>.json
.PARAMETER Force
    Specifies to overwrite any existing report JSON configuration file
.EXAMPLE
    Creates a report JSON configuration file for VMware vSphere, named 'vSphere_Report_Config' in 'C:\Reports' folder.
    New-AsBuiltReportConfig -Report VMware.vSphere -FolderPath 'C:\Reports' -Filename 'vSphere_Report_Config'
.EXAMPLE
    Creates a report JSON configuration file for Nutanix Prism Central, named 'AsBuiltReport.Nutanix.PrismCentral' in 'C:\Reports' folder, overwriting any existing file.
    New-AsBuiltReportConfig -Report Nutanix.PrismCentral -FolderPath 'C:\Reports' -Force
```

```powershell
Get-Help New-AsBuiltReportConfig -Full
```

## :computer: Examples
Here are some examples to get you going.

```powershell
# The following creates a VMware vSphere As Built report in HTML & Word formats.
# The document will highlight particular issues which exist within the environment by including the Healthchecks switch.
PS C:\>New-AsBuiltReport -Report VMware.vSphere -Target 192.168.1.100 -Username admin -Password admin -Format HTML,Word -EnableHealthCheck -OutputFolderPath 'H:\Documents\'

# The following creates a VMware vSphere As Built report in HTML & Word formats, while displaying Verbose messages to the console
PS C:\>New-AsBuiltReport -Report VMware.vSphere -Target 192.168.1.100 -Username admin -Password admin -Format HTML,Word -OutputFolderPath 'H:\Documents\' -Verbose

# The following creates a Pure Storage FlashArray As Built report in Text format and appends a timestamp to the filename. It also uses stored credentials to connect to the system.
PS C:\>$Creds = Get-Credential
PS C:\>New-AsBuiltReport -Report PureStorage.FlashArray -Target 192.168.1.100 -Credential $Creds -Format Text -Timestamp -OutputFolderPath 'H:\Documents\'

# The following creates a Cisco UCS Manager As Built report in default format (Word) with a customised style.
PS C:\>New-AsBuiltReport -Report Cisco.UCSManager -Target 192.168.1.100 -Username admin -Password admin -StyleFilePath 'C:\scripts\ACME.ps1' -OutputFolderPath 'H:\Documents\'

# The following creates a VMware NSX-V As Built report in HTML format, using the configuration in the asbuilt.json file located in the C:\scripts\ folder.
PS C:\>New-AsBuiltReport -Report VMware.NSXv -Target 192.168.1.100 -Username admin -Password admin -Format HTML -AsBuiltConfigFilePath 'C:\scripts\asbuilt.json' -OutputFolderPath 'H:\Documents\'

# The following creates a Nutanix Prism Element As Built report in HTML format, with a custom filename.
PS C:\>New-AsBuiltReport -Report VMware.NSXv -Target 192.168.1.100 -Username admin -Password admin -Format HTML -AsBuiltConfigFilePath 'C:\scripts\asbuilt.json' -OutputFolderPath 'H:\Documents\' -Filename 'My Nutanix Configuration'
```

## :pencil: Notes
- Table Of Contents (TOC) may be missing in Word formatted report

    When opening the DOCX report, MS Word prompts the following

    `"This document contains fields that may refer to other files. Do you want to update the fields in this document?"`

    `Yes / No`

    Clicking `No` will prevent the TOC fields being updated and leaving the TOC empty.

    Always reply `Yes` to this message when prompted by MS Word.
