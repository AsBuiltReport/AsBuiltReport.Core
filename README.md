<p align="center">
    <a alt="PowerShell Gallery Version">
        <img src="https://img.shields.io/powershellgallery/v/AsBuiltReport.Core.svg" /></a>
    <a alt="PS Gallery Downloads">
        <img src="https://img.shields.io/powershellgallery/dt/AsBuiltReport.Core.svg" /></a>
    <a alt="PS Platform">
        <img src="https://img.shields.io/powershellgallery/p/AsBuiltReport.Core.svg" /></a>
</p>
<p align="center">
    <a alt="GitHub Last Commit">
        <img src="https://img.shields.io/github/last-commit/AsBuiltReport/AsBuiltReport.Core/master.svg" /></a>
    <a alt="GitHub License">
        <img src="https://img.shields.io/github/license/AsBuiltReport/AsBuiltReport.Core.svg" /></a>
    <a alt="GitHub Contributors">
        <img src="https://img.shields.io/github/contributors/AsBuiltReport/AsBuiltReport.Core.svg"/></a>
</p>
<p align="center">
    <a alt="Twitter">
            <img src="https://img.shields.io/twitter/follow/AsBuiltReport.svg?style=social"/></a>
</p>

# AsBuiltReport

AsBuiltReport.Core is a PowerShell module which generates As-Built documentation for many common datacentre
infrastructure systems. Reports can be generated in Text, XML, HTML and MS Word formats and can be presented with
custom styling to align with your company/customer's brand. Reports are installed as separate PowerShell modules.

# Getting Started

The following simple list of instructions will get you started with the AsBuiltReport.Core module.

## Pre-requisites

All CmdLets and Functions require the [PScribo](https://github.com/iainbrighton/PScribo) module version 0.7.24 or later.
PScribo can be installed from the PowerShell Gallery with the following command.

```powershell
Install-Module PScribo
```
Alternatively PScribo will automatically be installed when you install the `AsBuiltReport` collection or individual report modules.

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
# The following creates a VMware vSphere As-Built report in HTML & Word formats.
# The document will highlight particular issues which exist within the environment by including the Healthchecks switch.
PS C:\>New-AsBuiltReport -Target 192.168.1.100 -Username admin -Password admin -Format HTML,Word -Report VMware.vSphere -EnableHealthCheck

# The following creates a Pure Storage FlashArray As-Built report in Text format and appends a timestamp to the filename. It also uses stored credentials to connect to the system.
PS C:\>$Creds = Get-Credential
PS C:\>New-AsBuiltReport -Target 192.168.1.100 -Credential $Creds -Format Text -Report PureStorage.FlashArray -Timestamp

# The following creates a Cisco UCS As-Built report in default format (Word) with a customised style.
PS C:\>New-AsBuiltReport -IP 192.168.1.100 -Username admin -Password admin -Report Cisco.UCSManager -StylePath c:\scripts\ACME.ps1

# The following creates a VMware vSphere As-Built report in HTML format, using the configuration in the asbuilt.json file located in the C:\scripts\ folder.
PS C:\>New-AsBuiltReport -IP 192.168.1.100 -Username admin -Password admin -Format HTML -Report VMware.vSphere -AsBuiltConfigPath C:\scripts\asbuilt.json
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
