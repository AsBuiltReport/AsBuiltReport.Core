function New-AsBuiltConfig {
    <#
    .SYNOPSIS  
        Creates As Built JSON configuration files.
    .DESCRIPTION
        New-AsBuiltConfig starts a menu-driven procedure in the powershell console and asks the user a series of questions
        Answers to these questions are optionally saved in a JSON configuration file which can then be referenced using the
        -AsBuiltConfigPath parameter on New-AsBuiltReport, to save having to answer these questions again and also to allow
        the automation of New-AsBuiltReport.
        
        New-AsBuiltConfig will automatically be called by New-AsBuiltReport if the -AsBuiltConfigPath parameter is not specified
        If a user wants to generate a new As Built JSON configuration without running a new report, this cmdlet is exported
        in the AsBuiltReport powershell module and can be called as a standalone cmdlet.
    #>

    #Run section to prompt user for information about the As Built Report to be exported to JSON format (if saved)
    $global:Config = @{}

    #region Report configuration
    Clear-Host
    Write-Host '---------------------------------------------' -ForegroundColor Cyan
    Write-Host ' <        As Built Report Information      > ' -ForegroundColor Cyan
    Write-Host '---------------------------------------------' -ForegroundColor Cyan
    $ReportAuthor = Read-Host -Prompt "Enter the name of the Author for this As Built report [$env:USERNAME]"
    if (($ReportAuthor -like $null) -or ($ReportAuthor -eq "")) {
        $ReportAuthor = $env:USERNAME
    }

    $Config.Report = @{
        'Author' = $ReportAuthor
    }
    #endregion Report configuration

    #region Company configuration
    Clear-Host
    Write-Host '---------------------------------------------' -ForegroundColor Cyan
    Write-Host ' <           Company Information           > ' -ForegroundColor Cyan
    Write-Host '---------------------------------------------' -ForegroundColor Cyan

    $CompanyInfo = Read-Host -Prompt "Would you like to enter Company information for the As Built report? (y/n)"
    while ("y", "n" -notcontains $CompanyInfo) {
        $CompanyInfo = Read-Host -Prompt "Would you like to enter Company information for the As Built report? (y/n)"
    }

    if ($CompanyInfo -eq 'y') {
        $CompanyFullName = Read-Host -Prompt "Enter the Full Company Name"
        $CompanyShortName = Read-Host -Prompt "Enter the Company Short Name"
        $CompanyContact = Read-Host -Prompt "Enter the Company Contact"
        $CompanyEmail = Read-Host -Prompt "Enter the Company Email Address"
        $CompanyPhone = Read-Host -Prompt "Enter the Company Phone"
        $CompanyAddress = Read-Host -Prompt "Enter the Company Address"
    }

    $Config.Company = @{
        'FullName' = $CompanyFullName
        'ShortName' = $CompanyShortName
        'Contact' = $CompanyContact
        'Email' = $CompanyEmail
        'Phone' = $CompanyPhone
        'Address' = $CompanyAddress
    }
    #endregion Company configuration

    #region Email configuration
    Clear-Host
    Write-Host '---------------------------------------------' -ForegroundColor Cyan
    Write-Host ' <            Email Configuration          > ' -ForegroundColor Cyan
    Write-Host '---------------------------------------------' -ForegroundColor Cyan
    if (!($SendEmail)) {
        $ConfigureMailSettings = Read-Host -Prompt "Would you like to enter SMTP configuration? (y/n)"
        while ("y", "n" -notcontains $ConfigureMailSettings) {
            $ConfigureMailSettings = Read-Host -Prompt "Would you like to enter SMTP configuration? (y/n)"
        }
    }
    if (($SendEmail) -or ($ConfigureMailSettings -eq "y")) {
        $MailServer = Read-Host -Prompt "Enter the mail server FQDN / IP address"
        while (($MailServer -eq $null) -or ($MailServer -eq "")) {
            $MailServer = Read-Host -Prompt "Enter the mail server FQDN / IP Address" 
        }
        if (($MailServer -eq 'smtp.office365.com') -or ($MailServer -eq 'smtp.gmail.com')) {
            $MailServerPort = Read-Host -Prompt "Enter the mail server port number [587]"
            if (($MailServerPort -eq $null) -or ($MailServerPort -eq "")) {
                $MailServerPort = '587'
            }
        } else {
            $MailServerPort = Read-Host -Prompt "Enter the mail server port number [25]"
            if (($MailServerPort -eq $null) -or ($MailServerPort -eq "")) {
                $MailServerPort = '25'
            }
        }        
        $MailServerUseSSL = Read-Host -Prompt "Use SSL for mail server connection? (true/false)"
        while ("true", "false" -notcontains $MailServerUseSSL) {
            $MailServerUseSSL = Read-Host -Prompt "Use SSL for mail server connection? (true/false)"
        }
        $MailCredentials = Read-Host -Prompt "Require mail server authentication? (true/false)"
        while ("true", "false" -notcontains $MailCredentials) {
            $MailCredentials = Read-Host -Prompt "Require mail server authentication? (true/false)"
        }
        $MailFrom = Read-Host -Prompt "Enter the mail sender address"
        while (($MailFrom -eq $null) -or ($MailFrom -eq "")) {
            $MailFrom = Read-Host -Prompt "Enter the mail sender address" 
        }
        $MailRecipients = @()
        do {
            $MailTo = Read-Host -Prompt "Enter the mail server recipient address"
            $MailRecipients += $MailTo
            $AnotherRecipient = @()
            while ("y", "n" -notcontains $AnotherRecipient) {
                $AnotherRecipient = Read-Host -Prompt "Do you want to enter another recipient? (y/n)" 
            }
        }until($AnotherRecipient -eq "n")
        $MailBody = Read-Host -Prompt "Enter the email message body content"
        if (($MailBody -eq $null) -or ($MailBody -eq "")) {
            $MailBody = "As Built Report attached"
        }
    }

    $Config.Email = @{
        'Server' = $MailServer
        'Port' = $MailServerPort
        'UseSSL' = $MailServerUseSSL
        'Credentials' = $MailCredentials
        'From' = $MailFrom
        'To' = $MailRecipients
        'Body' = $MailBody
    }
    #endregion Email Configuration

    #region Report Configuration Folder
    if (!($ReportConfigPath)) {
        Clear-Host
        Write-Host '---------------------------------------------' -ForegroundColor Cyan
        Write-Host ' <          Report Configuration           > ' -ForegroundColor Cyan
        Write-Host '---------------------------------------------' -ForegroundColor Cyan
        $ReportConfigFolder = Read-Host -Prompt "Enter the full path of the folder to use for storing report JSON configuration files and custom style scripts [$env:USERPROFILE\AsBuiltReport]"
        if (($ReportConfigFolder -like $null) -or ($ReportConfigFolder -eq "")) {
            $ReportConfigFolder = $env:USERPROFILE + "\AsBuiltReport"
        }

        #If the folder doesn't exist, create it
        if (!(Test-Path -Path $ReportConfigFolder)) {
            New-Item -Path $ReportConfigFolder -ItemType Directory -Force
        }

        #Add the path to the folder to the JSON configuration
        $Config.UserFolder = @{
            'Path' = $ReportConfigFolder
        }

        #Test to see if the Report Configuration folder is empty. If it is, generate all report JSON files.
        #If the folder is not empty, do a foreach loop through each currently installed report module and check if the
        #report json specific to that module exists. If it does, prompt the user to see if they want to overwrite the
        #JSON. If it doesn't exist, generate the JSON
        $AsBuiltReportModules = Get-Module -Name "AsBuiltReport.*"
        if (!(Get-ChildItem -Path $ReportConfigFolder -Force)) {
            Foreach ($AsBuiltReportModule in $AsBuiltReportModules) {
                $AsBuiltReportName = $AsBuiltReportModule.Name.Replace("AsBuiltReport.", "")
                Try {
                    New-AsBuiltReportConfig -Report $AsBuiltReportName -Path $ReportConfigFolder
                } Catch {
                    Write-Error $_
                    Break
                }
            }
        } else {
            try {
                foreach ($AsBuiltReportModule in $AsBuiltReportModules) {
                    $AsBuiltReportName = $AsBuiltReportModule.Name.Replace("AsBuiltReport.", "")
                    if (Test-Path -Path "$($ReportConfigFolder)\$($AsBuiltReportModule.Name).json") {
                        $OverwriteReportJSON = Read-Host -Prompt "A report JSON already exists in the specified folder for $($AsBuiltReportModule.Name). Would you like to overwrite it? (y/n)"
                        while ("y", "n" -notcontains $OverwriteReportJSON) {
                            $OverwriteReportJSON = Read-Host -Prompt "A report JSON already exists in the specified folder for $($AsBuiltReportModule.Name). Would you like to overwrite it? (y/n)"
                            while ("y", "n" -notcontains $OverwriteReportJSON) {
                                $OverwriteReportJSON = Read-Host -Prompt "A report JSON already exists in the specified folder for $($AsBuiltReportModule.Name). Would you like to overwrite it? (y/n)"
                            }
                            if ($OverwriteReportJSON -eq 'y') {
                                Try {
                                    New-AsBuiltReportConfig -Report $AsBuiltReportName -Path $ReportConfigFolder
                                } Catch {
                                    Write-Error $_
                                    Break
                                }
                            }
                        } else {
                            Try {
                                New-AsBuiltReportConfig -Report $AsBuiltReportName -Path $ReportConfigFolder
                            } Catch {
                                Write-Error $_
                                Break
                            }
                        }
                    }
                }
            } catch {
                Write-Error $_
            }
        }
    }
    #endregion Report Configuration Folder

    #region Save configuration
    Clear-Host
    Write-Host '----------------------------------------------' -ForegroundColor Cyan
    Write-Host ' <       As Built Report Configuration      > ' -ForegroundColor Cyan
    Write-Host '----------------------------------------------' -ForegroundColor Cyan
    $SaveAsBuiltConfig = Read-Host -Prompt "Would you like to save the As Built configuration file? (y/n)"
    while ("y", "n" -notcontains $SaveAsBuiltConfig) {
        $SaveAsBuiltConfig = Read-Host -Prompt "Would you like to save the As Built configuration file? (y/n)"
    }

    if ($SaveAsBuiltConfig -eq 'y') {
        $AsBuiltName = Read-Host -Prompt "Enter a name for the As Built report configuration file [AsBuiltReport]"
        if (($AsBuiltName -like $null) -or ($AsBuiltName -eq "")) {
            $AsBuiltName = "AsBuiltReport"
        }
        $AsBuiltExportPath = Read-Host -Prompt "Enter the path to save the As Built report configuration file [$env:USERPROFILE\AsBuiltReport]"
        if (($AsBuiltExportPath -like $null) -or ($AsBuiltExportPath -eq "")) {
            $AsBuiltExportPath = "$env:USERPROFILE\AsBuiltReport"
        }
        $AsBuiltConfigPath = Join-Path -Path $AsBuiltExportPath -ChildPath "$AsBuiltName.json"
        $Config | ConvertTo-Json | Out-File $AsBuiltConfigPath
    }
    $Config
    #endregion Save configuration
}#End New-AsBuiltConfig Function