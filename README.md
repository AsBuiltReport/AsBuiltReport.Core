<p align="center">
    <a href="https://www.asbuiltreport.com/" alt="AsBuiltReport"></a>
            <img src='https://avatars.githubusercontent.com/u/42958564' width="8%" height="8%" /></a>
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

<p align="center">
    <a href='https://ko-fi.com/B0B7DDGZ7' target='_blank'><img height='36' style='border:0px;height:36px;' src='https://cdn.ko-fi.com/cdn/kofi1.png?v=3' border='0' alt='Buy Me a Coffee at ko-fi.com' /></a>
</p>

# AsBuiltReport.Core

AsBuiltReport.Core is a PowerShell module which provides the core framework for generating as built documentation for many common datacentre systems. The AsBuiltReport.Core module is required by each individual report module used to generate as built documentation for a specific product and/or technology.

# :beginner: Getting Started

The following simple list of instructions will get you started with the AsBuiltReport.Core module.

## :floppy_disk: Supported Versions
### **PowerShell**
This module is compatible with the following PowerShell versions;

| Windows PowerShell 5.1 |    PowerShell 7    |
| :--------------------: | :----------------: |
|   :white_check_mark:   | :white_check_mark: |

## :wrench: System Requirements

The following PowerShell module will be automatically installed by following the [module installation](https://github.com/AsBuiltReport/AsBuiltReport.Core#package-module-installation) procedure.

This PowerShell module may also be manually installed via the PowerShell Gallery or GitHub.

| Module Name | Minimum Required Version |                         PS Gallery                         |                           GitHub                            |
| ----------- | :----------------------: | :--------------------------------------------------------: | :---------------------------------------------------------: |
| PScribo     |          0.10.0          | [Link](https://www.powershellgallery.com/packages/PScribo) | [Link](https://github.com/iainbrighton/PScribo/tree/master) |

To find a list of available report modules, run the following PowerShell command;

```powershell
Find-Module -Name AsBuiltReport.* -Repository PSGallery
```

The pre-requisites for each report type will be documented within its own `README.md` located in the relevant report repository.

## :package: Module Installation

### PowerShell
#### Online Installation

For an online installation, install the `AsBuiltReport.Core` module using the [PowerShell Gallery](https://www.powershellgallery.com/packages?q=Asbuiltreport.Core);

```powershell
# Install AsBuiltReport module
Install-Module -Name 'AsBuiltReport.Core' -Repository 'PSGallery' -Scope 'CurrentUser'
```

#### Offline Installation

For an offline installation, perform the following steps from a machine with internet connectivity;

Save the required `AsBuiltReport.Core` module to a specified folder.

```powershell
# Save AsBuiltReport.Core module
Save-Module -Name 'AsBuiltReport.Core' -Repository 'PSGallery' -Path '<Folder Path>'
```

Copy the downloaded `AsBuiltReport.Core` module folder to a location that can be made accessible to the offline system.
e.g. USB Flash Drive, Internal File Share etc.

On the offline system, open a PowerShell console window and run the following command to determine the PowerShell module path.

**Windows**

```powershell title=""
$env:PSModulePath -Split ';'
```

**macOS & Linux**

```powershell title=""
$env:PSModulePath -Split ':'
```

Copy the downloaded `AsBuiltReport.Core` module folder to a folder specified in the `$env:PSModulePath` output.

### **GitHub**
If you are unable to use the PowerShell Gallery, you can still install the `AsBuiltReport.Core` module manually. Ensure you repeat the following steps for the [system requirements](https://github.com/AsBuiltReport/AsBuiltReport.Core#wrench-system-requirements) also.

1. Download the [latest release](https://github.com/AsBuiltReport/AsBuiltReport.Core/releases/latest) zip from GitHub
2. Extract the zip file
3. Copy the folder `AsBuiltReport.Core` to a path that is set in `$env:PSModulePath`.
4. For Windows users only, open a PowerShell terminal window and unblock the downloaded files with
    ```powershell
    $path = (Get-Module -Name AsBuiltReport.Core -ListAvailable).ModuleBase; Unblock-File -Path $path\*.psd1; Unblock-File -Path $path\Src\Public\*.ps1
    ```
5. Close and reopen the PowerShell terminal window.

_Note: You are not limited to installing the module to those example paths, you can add a new entry to the environment variable PSModulePath if you want to use another path._

## :pencil2: Commands

### **New-AsBuiltReport**

The `New-AsBuiltReport` cmdlet is used to generate as built reports. The type of as built report to generate is specified by using the `Report` parameter. The report parameter relies on additional report modules being installed alongside the `AsBuiltReport.Core` module. The `Target` parameter specifies one or more systems on which to connect and run the report. User credentials to the system are specified using the `Credential`, or the `Username` and `Password` parameters. One or more document formats, such as `HTML`, `Word` or `Text` can be specified using the `Format` parameter. Additional parameters are outlined below.

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
    If this parameter is not specified, a default report configuration JSON is copied to the specified user folder.
    If this parameter is specified and the path to a JSON file is invalid, the script will terminate
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
    New-AsBuiltReportConfig -Report VMware.vSphere -FolderPath 'C:\Reports' -Filename 'vSphere_Report_Config'

    Creates a VMware vSphere report configuration file named 'vSphere_Report_Config.json' in the 'C:\Reports' folder.
.EXAMPLE
    New-AsBuiltReportConfig -Report Nutanix.PrismElement -FolderPath '/Users/Tim/Reports' -Force

    Creates a Nutanix Prism Element report configuration file name 'AsBuiltReport.Nutanix.PrismElement.json' in '/Users/Tim/Reports' folder and overwrites the existing file.
```

```powershell
Get-Help New-AsBuiltReportConfig -Full
```

## :computer: Examples
Here are some examples to get you going.

```powershell
# Generate a VMware vSphere As Built report in HTML & Word formats. Perform a health check to highlight particular issues which exist within the VMware vSphere environment. Save the report to the 'H:\Documents\' folder.
New-AsBuiltReport -Report 'VMware.vSphere' -Target '192.168.1.100' -Username 'admin' -Password 'admin' -Format HTML,Word -EnableHealthCheck -OutputFolderPath 'H:\Documents\'

# Generate a Nutanix Prism Element As Built Report using specified username and password credentials. Specify the report configuration file to be used. Export report to Text, HTML & DOCX formats. Use the default report style. Save the report to the '/Users/Tim/Documents' folder. Display verbose messages to the console.
New-AsBuiltReport -Report 'Nutanix.PrismElement' -Target 'prism.nutanix.local' -Username 'demo' -Password 'demo' -Format Text,Html,Word -OutputFolderPath '/Users/Tim/Documents' -ReportConfigFilePath '/Users/Tim/AsBuiltReport/AsBuiltReport.Nutanix.PrismElement.json' -Verbose

# Generate a Pure Storage FlashArray As Built Report in Text format and append a timestamp to the filename. Use stored credentials for authentication. Use the default Pure Storage report style. Save the reports to the 'H:\Documents' folder.
$Credentials = Get-Credential
New-AsBuiltReport -Report 'PureStorage.FlashArray' -Target '192.168.1.100' -Credential $Credentials -Format Text -Timestamp -OutputFolderPath 'H:\Documents\'

# The following creates a Cisco UCS Manager As Built report in default format (Word) with a customized style.
New-AsBuiltReport -Report 'Cisco.UCSManager' -Target '192.168.1.100' -Username 'admin' -Password 'admin' -StyleFilePath 'C:\scripts\ACME.ps1' -OutputFolderPath 'H:\Documents\'

# The following creates a Nutanix Prism Element As Built report in HTML format, with a custom filename.
New-AsBuiltReport -Report 'Nutanix.PrismElement' -Target '192.168.1.100' -Username 'admin' -Password 'admin' -Format HTML -AsBuiltConfigFilePath 'C:\scripts\asbuilt.json' -OutputFolderPath 'H:\Documents\' -Filename 'My Nutanix Configuration'
```

## :x: Known Issues
- **Table Of Contents (TOC) is missing in Word formatted report**

    When opening a Microsoft Word (DOCX) report for the first time, you will be prompted with the following warning;

    `"This document contains fields that may refer to other files. Do you want to update the fields in this document?"`

    `Yes / No`

    Clicking No will prevent the TOC fields from being updated, leaving the Table of Contents empty.

    Always reply Yes to this message when prompted by Microsoft Word to ensure the Table of Contents is updated.

    Save the document to prevent future prompts when opening the document.

- **Images are missing from reports generated using Linux or macOS**

    Unfortunately due to [breaking changes](https://learn.microsoft.com/en-gb/dotnet/core/compatibility/core-libraries/6.0/system-drawing-common-windows-only) in .NET 6, images are no longer supported for reports generated using Linux or macOS.