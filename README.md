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

# AsBuiltReport

AsBuiltReport.Core is a PowerShell module which provides the core framework for generating As-Built documentation for many common datacentre systems. The AsBuiltReport.Core module is required by each individual report module used to generate as built documentation for a specific product and/or technology.

# Getting Started

The following simple list of instructions will get you started with the AsBuiltReport.Core module.

## Pre-requisites

All cmdLets and functions require the [PScribo](https://github.com/iainbrighton/PScribo) module version 0.7.26 or later.
PScribo will be automatically installed when you install any `AsBuiltReport` modules.

Alternatively, PScribo can be manually installed from the PowerShell Gallery using the following command.

```powershell
Install-Module PScribo -MinimumVersion 0.7.26
```

To find a list of available report modules, run the following;

```powershell
Find-Module -Name AsBuiltReport.* -Repository PSGallery
```

The pre-requisites for each report type will be documented within its own `README.md` located in the relevant report repository.

### Module Installation
To install as built report modules individually 
```powershell
Install-Module AsBuiltReport.<Vendor>.<Product>
```

or, install the complete as built report collection

```powershell
Install-Module AsBuiltReport
```

## Examples

Each report type utilises a common set of parameters. Additional parameters specific to each
report will be detailed in the report's `README.md` file, along with any relevant examples.

For a full list of common parameters and examples you can view the `New-AsBuiltReport` CmdLet help with the following command.

```powershell
Get-Help New-AsBuiltReport -Full
```

Here are some examples to get you going.

```powershell
# The following creates a VMware vSphere As Built report in HTML & Word formats.
# The document will highlight particular issues which exist within the environment by including the Healthchecks switch.
PS C:\>New-AsBuiltReport -Report VMware.vSphere -Target 192.168.1.100 -Username admin -Password admin -Format HTML,Word -EnableHealthCheck -OutputPath 'H:\Documents\'

# The following creates a Pure Storage FlashArray As Built report in Text format and appends a timestamp to the filename. It also uses stored credentials to connect to the system.
PS C:\>$Creds = Get-Credential
PS C:\>New-AsBuiltReport -Report PureStorage.FlashArray -Target 192.168.1.100 -Credential $Creds -Format Text -Timestamp -OutputPath 'H:\Documents\'

# The following creates a Cisco UCS As Built report in default format (Word) with a customised style.
PS C:\>New-AsBuiltReport -Report Cisco.UCSManager -Target 192.168.1.100 -Username admin -Password admin -StylePath 'C:\scripts\ACME.ps1' -OutputPath 'H:\Documents\'

# The following creates a VMware NSX-V As Built report in HTML format, using the configuration in the asbuilt.json file located in the C:\scripts\ folder.
PS C:\>New-AsBuiltReport -Report VMware.NSXv -Target 192.168.1.100 -Username admin -Password admin -Format HTML -AsBuiltConfigPath 'C:\scripts\asbuilt.json' -OutputPath 'H:\Documents\'
```

## Known Issues
- Table Of Contents (TOC) may be missing in Word formatted report

    When opening the DOC report, MS Word prompts the following 
    
    `"This document contains fields that may refer to other files. Do you want to update the fields in this document?"`
    
    `Yes / No`

    Clicking `No` will prevent the TOC fields being updated and leaving the TOC empty.

    Always reply `Yes` to this message when prompted by MS Word.

- In HTML documents, word-wrap of table cell contents is not working, causing the following issues;
  - Cell contents may overflow table columns
  - Tables may overflow page margin
  - [PScribo Issue #83](https://github.com/iainbrighton/PScribo/issues/83)

- In Word documents, some tables are not sized proportionately. To prevent cell overflow issues in HTML documents, most tables are auto-sized, this causes some tables to be out of proportion.
    
    - [PScribo Issue #83](https://github.com/iainbrighton/PScribo/issues/83)
