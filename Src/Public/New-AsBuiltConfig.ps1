function New-AsBuiltConfig {
    <#
    .SYNOPSIS
        Creates As Built Report configuration files.
    .DESCRIPTION
        New-AsBuiltConfig starts a menu-driven procedure in the powershell console and asks the user a series of questions
        Answers to these questions are optionally saved in a JSON configuration file which can then be referenced using the
        -AsBuiltConfigFilePath parameter using New-AsBuiltReport, to save having to answer these questions again and also to allow
        the automation of New-AsBuiltReport.

        New-AsBuiltConfig will automatically be called by New-AsBuiltReport if the -AsBuiltConfigFilePath parameter is not specified
        If a user wants to generate a new As Built Report configuration without running a new report, this cmdlet is exported
        in the AsBuiltReport powershell module and can be called as a standalone cmdlet.
    .LINK
        https://github.com/AsBuiltReport/AsBuiltReport.Core
    .LINK
        https://www.asbuiltreport.com/user-guide/new-asbuiltconfig/
    #>

    [CmdletBinding()]
    param()

    begin {
        #Run section to prompt user for information about the As Built Report to be exported to JSON format (if saved)
        $global:Config = @{ }

        Initialize-SessionLocalization -ScriptRoot (Split-Path (Split-Path $PSScriptRoot -Parent) -Parent) -LanguageFile 'New-AsBuiltConfig'

    }

    process {
        #region Report configuration
        Clear-Host
        # Show As Built Report configuration banner
        Draw-AsciiBanner -Lines @($translate.ReportInfo.BannerTitle) -ExtraPadding 4 -TextColor 'Cyan' -BorderColor 'Cyan'

        $ReportAuthor = Read-Host -Prompt ($translate.ReportInfo.ReportAuthor -f [System.Environment]::Username)
        if (($ReportAuthor -like $null) -or ($ReportAuthor -eq "")) {
            $ReportAuthor = $([System.Environment]::Username)
        }

        $Config.Report = @{
            'Author' = $ReportAuthor
        }
        #endregion Report configuration

        #region Company configuration
        Clear-Host
        # Show Company configuration banner
        Draw-AsciiBanner -Lines @($translate.CompanyConfig.BannerTitle) -ExtraPadding 4 -TextColor 'Cyan' -BorderColor 'Cyan'

        $CompanyInfo = Read-Host -Prompt $translate.CompanyConfig.CompanyInfo
        while ("y", "n" -notcontains $CompanyInfo) {
            $CompanyInfo = Read-Host -Prompt $translate.CompanyConfig.CompanyInfo
        }

        if ($CompanyInfo -eq 'y') {
            $CompanyFullName = Read-Host -Prompt $translate.CompanyConfig.CompanyFullName
            $CompanyShortName = Read-Host -Prompt $translate.CompanyConfig.CompanyShortName
            $CompanyContact = Read-Host -Prompt $translate.CompanyConfig.CompanyContact
            do {
                $CompanyEmail = Read-Host -Prompt $translate.CompanyConfig.CompanyEmail

                if (($null -eq $CompanyEmail) -or ($CompanyEmail -eq "")) {
                    # Allow blank/empty - no validation needed
                    $isValid = $true
                } else {
                    # Validate email format if text is entered
                    try {
                        $null = [System.Net.Mail.MailAddress]$CompanyEmail
                        $isValid = $true
                    } catch {
                        Write-Host ($translate.EmailConfig.InvalidEmail -f $CompanyEmail) -ForegroundColor Red
                        $isValid = $false
                    }
                }
            } while (-not $isValid)
            $CompanyPhone = Read-Host -Prompt $translate.CompanyConfig.CompanyPhone
            $CompanyAddress = Read-Host -Prompt $translate.CompanyConfig.CompanyAddress
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
        # Show Email configuration banner
        Draw-AsciiBanner -Lines @($translate.EmailConfig.BannerTitle) -ExtraPadding 4 -TextColor 'Cyan' -BorderColor 'Cyan'
        if (-not ($SendEmail)) {
            $ConfigureMailSettings = Read-Host -Prompt $translate.EmailConfig.ConfigureMailSettings
            while ("y", "n" -notcontains $ConfigureMailSettings) {
                $ConfigureMailSettings = Read-Host -Prompt $translate.EmailConfig.ConfigureMailSettings
            }
        }
        if (($SendEmail) -or ($ConfigureMailSettings -eq "y")) {
            do {
                $MailServer = Read-Host -Prompt $translate.EmailConfig.MailServer

                if (($null -eq $MailServer) -or ($MailServer -eq "")) {
                    Write-Host $translate.EmailConfig.EmptyMailServerAddress -ForegroundColor Red
                    $isValid = $false
                } else {
                    # Check if it's a valid IPv4 address (strict validation)
                    $ipParts = $MailServer.Split('.')
                    $isValidIPv4 = $false

                    if ($ipParts.Count -eq 4) {
                        $isValidIPv4 = $true
                        foreach ($part in $ipParts) {
                            $num = 0
                            if (-not [int]::TryParse($part, [ref]$num) -or $num -lt 0 -or $num -gt 255) {
                                $isValidIPv4 = $false
                                break
                            }
                        }
                    }

                    # Check if it's a valid IPv6 address
                    $isValidIPv6 = $false
                    if (-not $isValidIPv4) {
                        try {
                            $parsedIP = [System.Net.IPAddress]::Parse($MailServer)
                            $isValidIPv6 = $parsedIP.AddressFamily -eq 'InterNetworkV6'
                        } catch {
                            $isValidIPv6 = $false
                        }
                    }

                    # Check if it's a valid FQDN - but exclude things that look like incomplete IPs
                    $isValidFQDN = $false
                    if (-not $isValidIPv4 -and -not $isValidIPv6) {
                        # Exclude strings that are all numeric with dots (incomplete IPs)
                        $looksLikeIP = $MailServer -match '^[\d\.]+$'

                        if (-not $looksLikeIP) {
                            $fqdnPattern = '^[a-zA-Z0-9]([a-zA-Z0-9\-]{0,61}[a-zA-Z0-9])?(\.[a-zA-Z0-9]([a-zA-Z0-9\-]{0,61}[a-zA-Z0-9])?)+$'
                            $isValidFQDN = $MailServer -match $fqdnPattern
                        }
                    }

                    if ($isValidIPv4 -or $isValidIPv6 -or $isValidFQDN) {
                        $isValid = $true
                    } else {
                        Write-Host ($translate.EmailConfig.InvalidMailServer -f $MailServer) -ForegroundColor Red
                        $isValid = $false
                    }
                }
            } while (-not $isValid)

            if (($MailServer -eq 'smtp.office365.com') -or ($MailServer -eq 'smtp.gmail.com')) {
                do {
                    $MailServerPort = Read-Host -Prompt $translate.EmailConfig.MailServerPort587
                    $portNumber = 0  # Initialize the variable

                    if (($null -eq $MailServerPort) -or ($MailServerPort -eq "")) {
                        $MailServerPort = '587'
                        $isValid = $true
                    } elseif ([int]::TryParse($MailServerPort, [ref]$portNumber) -and $portNumber -ge 1 -and $portNumber -le 65535) {
                        $isValid = $true
                    } else {
                        Write-Host $translate.EmailConfig.InvalidMailServerPort587 -ForegroundColor Red
                        $isValid = $false
                    }
                } while (-not $isValid)
            } else {
                do {
                    $MailServerPort = Read-Host -Prompt $translate.EmailConfig.MailServerPort25
                    $portNumber = 0  # Initialize the variable

                    if (($null -eq $MailServerPort) -or ($MailServerPort -eq "")) {
                        $MailServerPort = '25'
                        $isValid = $true
                    } elseif ([int]::TryParse($MailServerPort, [ref]$portNumber) -and $portNumber -ge 1 -and $portNumber -le 65535) {
                        $isValid = $true
                    } else {
                        Write-Host $translate.EmailConfig.InvalidMailServerPort25 -ForegroundColor Red
                        $isValid = $false
                    }
                } while (-not $isValid)
            }

            $MailServerUseSSL = Read-Host -Prompt $translate.EmailConfig.MailServerUseSSL
            while ("y", "n" -notcontains $MailServerUseSSL) {
                $MailServerUseSSL = Read-Host -Prompt $translate.EmailConfig.MailServerUseSSL
            }
            $MailServerUseSSL = switch ($MailServerUseSSL) {
                "y" { $true }
                "n" { $false }
            }

            $MailCredentials = Read-Host -Prompt $translate.EmailConfig.MailCredentials
            while ("y", "n" -notcontains $MailCredentials) {
                $MailCredentials = Read-Host -Prompt $translate.EmailConfig.MailCredentials
            }
            $MailCredentials = switch ($MailCredentials) {
                "y" { $true }
                "n" { $false }
            }

            do {
                $MailFrom = Read-Host -Prompt $translate.EmailConfig.MailFrom
                if (($null -eq $MailFrom) -or ($MailFrom -eq "")) {
                    Write-Host $translate.EmailConfig.EmptyEmail -ForegroundColor Red
                    $isValid = $false
                } else {
                    try {
                        $null = [System.Net.Mail.MailAddress]$MailFrom
                        $isValid = $true
                    } catch {
                        $isValid = $false
                        Write-Host ($translate.EmailConfig.InvalidEmail -f $MailFrom) -ForegroundColor Red
                    }
                }
            } while (-not $isValid)

            $MailRecipients = @()
            do {
                do {
                    $MailTo = Read-Host -Prompt $translate.EmailConfig.MailTo

                    if (($null -eq $MailTo) -or ($MailTo -eq "")) {
                        Write-Host $translate.EmailConfig.EmptyEmail -ForegroundColor Red
                        $isValid = $false
                    } else {
                        try {
                            $null = [System.Net.Mail.MailAddress]$MailTo
                            $isValidEmail = $true
                        } catch {
                            $isValidEmail = $false
                            Write-Host ($translate.EmailConfig.InvalidEmail -f $MailTo) -ForegroundColor Red
                        }
                    }
                } while (-not $isValidEmail)

                $MailRecipients += $MailTo
                $AnotherRecipient = @()
                while ("y", "n" -notcontains $AnotherRecipient) {
                    $AnotherRecipient = Read-Host -Prompt $translate.EmailConfig.AnotherRecipient
                }
            } until($AnotherRecipient -eq "n")
            $MailBody = Read-Host -Prompt $translate.EmailConfig.MailBodyPrompt
            if (($null -eq $MailBody) -or ($MailBody -eq "")) {
                $MailBody = $translate.EmailConfig.MailBody
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
        if ($Report -and (-not $ReportConfigFilePath)) {
            Clear-Host
            # Show Rerport configuration banner
            Draw-AsciiBanner -Lines @($translate.ReportConfig.BannerTitle) -ExtraPadding 4 -TextColor 'Cyan' -BorderColor 'Cyan'
            $ReportConfigFolder = Read-Host -Prompt ($translate.ReportConfig.ReportConfigFolder -f $Home + $DirectorySeparatorChar + "AsBuiltReport")
            if (($ReportConfigFolder -like $null) -or ($ReportConfigFolder -eq "")) {
                $ReportConfigFolder = $Home + $DirectorySeparatorChar + "AsBuiltReport"
            }

            #If the folder doesn't exist, create it
            if (-not (Test-Path -Path $ReportConfigFolder)) {
                try {
                    $Folder = New-Item -Path $ReportConfigFolder -ItemType Directory -Force
                } catch {
                    Write-Error $_
                    break
                }
            }

            # Add the path to the folder to the report configuration file
            $Config.UserFolder = @{
                'Path' = $ReportConfigFolder
            }

            # Test to see if the report configuration file exists. If it doesn't exist, generate the report configuration file.
            # If the report configuration file exists, prompt the user to overwrite the report configuration file.
            $ReportModule = Get-Module -Name "AsBuiltReport.$Report" -ListAvailable | Sort-Object -Property Version -Descending | Select-Object -First 1
            $SourcePath = $($ReportModule.ModuleBase) + $DirectorySeparatorChar + $($ReportModule.Name) + ".json"
            $DestinationPath = $($ReportConfigFolder) + $DirectorySeparatorChar + $($ReportModule.Name) + ".json"
            if (-not (Get-ChildItem -Path $DestinationPath)) {
                Write-Verbose -Message ($translate.CopyFile -f $SourcePath, $DestinationPath)
                New-AsBuiltReportConfig -Report $Report -FolderPath $ReportConfigFolder
            } else {
                try {
                    if (Test-Path -Path $DestinationPath) {
                        $OverwriteReportConfig = Read-Host -Prompt ($translate.ReportConfig.OverwriteReportConfig -f $ReportModule.Name)
                        while ("y", "n" -notcontains $OverwriteReportConfig) {
                            $OverwriteReportConfig = Read-Host -Prompt ($translate.ReportConfig.OverwriteReportConfig -f $ReportModule.Name)
                        }
                        if ($OverwriteReportConfig -eq 'y') {
                            try {
                                Write-Verbose -Message ($translate.ReportConfig.OverwriteFile -f $SourcePath, $DestinationPath)
                                New-AsBuiltReportConfig -Report $Report -FolderPath $ReportConfigFolder -Force
                            } catch {
                                Write-Error $_
                                break
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
        Draw-AsciiBanner -Lines @($translate.ReportConfig.BannerTitle) -ExtraPadding 4 -TextColor 'Cyan' -BorderColor 'Cyan'
        $SaveAsBuiltConfig = Read-Host -Prompt $translate.ReportConfig.SaveAsBuiltConfig
        while ("y", "n" -notcontains $SaveAsBuiltConfig) {
            $SaveAsBuiltConfig = Read-Host -Prompt $translate.ReportConfig.SaveAsBuiltConfig
        }

        if ($SaveAsBuiltConfig -eq 'y') {
            $AsBuiltName = Read-Host -Prompt $translate.ReportConfig.AsBuiltName
            if (($AsBuiltName -like $null) -or ($AsBuiltName -eq "")) {
                $AsBuiltName = "AsBuiltReport"
            }
            if ($Config.UserFolder.Path) {
                $AsBuiltExportPath = Read-Host -Prompt ($translate.ReportConfig.AsBuiltExportPath -f $Config.UserFolder.Path)
                if (($AsBuiltExportPath -like $null) -or ($AsBuiltExportPath -eq "")) {
                    $AsBuiltExportPath = $Config.UserFolder.Path
                }
            } elseif ($ReportConfigFilePath) {
                $ReportConfigFolderPath = Split-Path -Path $ReportConfigFilePath
                $AsBuiltExportPath = Read-Host -Prompt ($translate.ReportConfig.AsBuiltExportPath -f $ReportConfigFolderPath)
                if (($AsBuiltExportPath -like $null) -or ($AsBuiltExportPath -eq "")) {
                    $AsBuiltExportPath = $ReportConfigFolderPath
                }
            } else {
                $AsBuiltExportPath = Read-Host -Prompt ($translate.ReportConfig.AsBuiltExportPath -f $($Home + $DirectorySeparatorChar + 'AsBuiltReport'))
                if (($AsBuiltExportPath -like $null) -or ($AsBuiltExportPath -eq "")) {
                    $AsBuiltExportPath = $Home + $DirectorySeparatorChar + "AsBuiltReport"
                }
            }
            if (-not (Test-Path -Path $AsBuiltExportPath)) {
                Write-Verbose -Message ($translate.ReportConfig.ConfigFolder -f $AsBuiltExportPath)
                try {
                    $Folder = New-Item -Path $AsBuiltExportPath -ItemType Directory -Force
                } catch {
                    Write-Error $_
                    break
                }
            }
            $Config.UserFolder = @{
                'Path' = $AsBuiltExportPath
            }
            Write-Verbose -Message ($translate.ReportConfig.SaveConfig -f $AsBuiltName, $AsBuiltExportPath)
            $AsBuiltConfigPath = Join-Path -Path $AsBuiltExportPath -ChildPath "$AsBuiltName.json"
            $Config | ConvertTo-Json | Out-File $AsBuiltConfigPath
        } else {
            Write-Verbose -Message $translate.ReportConfig.NotSaved
        }
        #endregion Save configuration

        # Print output to screen so that it can be captured to $Global:AsBuiltConfig variable in New-AsBuiltReport
        $Config

        # Verbose Output
        Write-Verbose -Message "Config.Report.Author = $ReportAuthor"
        Write-Verbose -Message "Config.UserFolder.Path = $ReportConfigFolder"
        foreach ($x in $Config.Company.Keys) {
            Write-Verbose -Message "Config.Company.$x = $($Config.Company[$x])"
        }
        foreach ($x in $Config.Email.Keys) {
            Write-Verbose -Message "Config.Email.$x = $($Config.Email[$x])"
        }
    }

    end {}
}#End New-AsBuiltConfig Function