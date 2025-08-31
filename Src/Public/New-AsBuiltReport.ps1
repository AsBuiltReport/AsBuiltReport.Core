function New-AsBuiltReport {
    <#
    .SYNOPSIS
        Documents the configuration of IT infrastructure in Word/HTML/Text formats using PScribo.
    .DESCRIPTION
        Documents the configuration of IT infrastructure in Word/HTML/Text formats using PScribo.
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
    .PARAMETER Language
        Specifies the language for the report.
        By default, the language will be set to en-US.
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
        Enter the full file path to the As Built Report configuration JSON file.
        If this parameter is not specified, the user will be prompted for this configuration information on first
        run, with the option to save the configuration to a file.
    .PARAMETER ReportConfigFilePath
        Enter the full file path to a report JSON configuration file
        If this parameter is not specified, a default report configuration JSON is copied to the specifed user folder.
        If this parameter is specified and the path to a JSON file is invalid, the script will terminate.
    .EXAMPLE
        New-AsBuiltReport -Report VMware.vSphere -Target 192.168.1.100 -Username admin -Password admin -Format HTML,Word -EnableHealthCheck -OutputFolderPath 'c:\scripts\'

        Creates a VMware vSphere As Built Report in HTML & Word formats. The document will highlight particular issues which exist within the environment.
        The report will be saved to c:\scripts.
    .EXAMPLE
        $Creds = Get-Credential
        New-AsBuiltReport -Report PureStorage.FlashArray -Target 192.168.1.100 -Credential $Creds -Format Text -Timestamp -OutputFolderPath 'c:\scripts\'

        Creates a Pure Storage FlashArray As Built Report in Text format and appends a timestamp to the filename.
        Stored credentials are used to connect to the system.
        The report will be saved to c:\scripts.
    .EXAMPLE
        New-AsBuiltReport -Report Rubrik.CDM -Target 192.168.1.100 -Token '123456789abcdefg' -Format HTML -OutputFolderPath 'c:\scripts\'

        Creates a Rubrik CDM As Built Report in HTML format.
        An API token is used to connect to the system.
        The report will be saved to c:\scripts.
    .EXAMPLE
        New-AsBuiltReport -Report Cisco.UCSManager -Target '192.168.1.100' -Username admin -Password admin -StyleFilePath '/Users/Tim/AsBuiltReport/Styles/ACME.ps1' -OutputFolderPath '/Users/Tim/scripts'

        Creates a Cisco UCS Manager As Built Report in default format (Word), using a custom style.
        The report will be saved to '/Users/Tim/scripts'.
    .EXAMPLE
        New-AsBuiltReport -Report Nutanix.PrismElement -Target 192.168.1.100 -Username admin -Password admin -SendEmail -OutputFolderPath c:\scripts\

        Creates a Nutanix Prism Element As Built Report in default format (Word). Report will be attached and sent via email.
        The report will be saved to c:\scripts.
    .EXAMPLE
        New-AsBuiltReport -Report VMware.vSphere -Target 192.168.1.100 -Username admin -Password admin -Format HTML-AsBuiltConfigFilePath C:\scripts\asbuiltreport.json -OutputFolderPath c:\scripts\

        Creates a VMware vSphere As Built Report in HTML format, using the configuration in the asbuiltreport.json file located in the C:\scripts\ folder.
        The report will be saved to c:\scripts.
    .LINK
        https://github.com/AsBuiltReport/AsBuiltReport.Core
    .LINK
        https://www.asbuiltreport.com/user-guide/new-asbuiltreport/
    #>

    #region Script Parameters
    [CmdletBinding(
        PositionalBinding = $false,
        DefaultParameterSetName = 'Credential'
    )]
    param (
        [Parameter(
            Position = 0,
            Mandatory = $true,
            HelpMessage = 'Please specify which report type you wish to run.'
        )]
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
            Position = 1,
            Mandatory = $true,
            HelpMessage = 'Please provide the IP/FQDN of the system'
        )]
        [ValidateNotNullOrEmpty()]
        [Alias('Cluster', 'Server', 'IP')]
        [String[]] $Target,
        [Parameter(
            Position = 2,
            Mandatory = $true,
            HelpMessage = 'Please provide credentials to connect to the system',
            ParameterSetName = 'Credential'
        )]
        [ValidateNotNullOrEmpty()]
        [PSCredential] $Credential,

        [Parameter(
            Position = 2,
            Mandatory = $true,
            HelpMessage = 'Please provide the username to connect to the target system',
            ParameterSetName = 'UsernameAndPassword'
        )]
        [ValidateNotNullOrEmpty()]
        [String] $Username,

        [Parameter(
            Position = 3,
            Mandatory = $false,
            HelpMessage = 'Please provide the password to connect to the target system',
            ParameterSetName = 'UsernameAndPassword'
        )]
        [ValidateNotNullOrEmpty()]
        [String] $Password,

        [Parameter(
            Position = 3,
            Mandatory = $true,
            HelpMessage = 'Please provide an API token to connect to the target system',
            ParameterSetName = 'APIToken'
        )]
        [ValidateNotNullOrEmpty()]
        [String] $Token,

        [Parameter(
            Position = 3,
            Mandatory = $true,
            ParameterSetName = 'MFA'
        )]
        [ValidateNotNullOrEmpty()]
        [Switch] $MFA,

        [Parameter(
            Position = 4,
            Mandatory = $false,
            HelpMessage = 'Please provide the document output format'
        )]
        [ValidateNotNullOrEmpty()]
        [ValidateSet('Word', 'HTML', 'Text')]
        [Array] $Format = 'Word',

                [Parameter(
            Mandatory = $false,
            HelpMessage = 'Please specify the language for the report (default is en-US)'
        )]
        [ValidateNotNullOrEmpty()]
        [ValidateSet('en-US', 'en-GB', 'fr-FR', 'de-DE', 'es-ES', 'it-IT', 'ja-JP', 'zh-CN')]
        [String] $Language = 'en-US',

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Determines the document page orientation'
        )]
        [ValidateNotNullOrEmpty()]
        [ValidateSet('Portrait', 'Landscape')]
        [String] $Orientation = 'Portrait',

        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Please provide the path to the document output file'
        )]
        [ValidateNotNullOrEmpty()]
        [Alias('OutputPath')]
        [String] $OutputFolderPath,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Please provide the path to the custom style script'
        )]
        [ValidateNotNullOrEmpty()]
        [Alias('StylePath')]
        [String] $StyleFilePath,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Provide the file path to an existing report JSON Configuration file'
        )]
        [ValidateNotNullOrEmpty()]
        [Alias('ReportConfigPath')]
        [String] $ReportConfigFilePath,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Provide the file path to an existing As Built JSON Configuration file'
        )]
        [ValidateNotNullOrEmpty()]
        [Alias('AsBuiltConfigPath')]
        [String] $AsBuiltConfigFilePath,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Specify the As Built Report filename'
        )]
        [ValidateNotNullOrEmpty()]
        [String] $Filename,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Specify whether to append a timestamp to the document filename'
        )]
        [Switch] $Timestamp = $false,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Specify whether to highlight any configuration issues within the document'
        )]
        [Switch] $EnableHealthCheck = $false,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Specify whether to send report via Email'
        )]
        [Switch] $SendEmail = $false
    )
    #endregion Script Parameters

    Initialize-SessionLocalization -ScriptRoot (Split-Path (Split-Path $PSScriptRoot -Parent) -Parent) -LanguageFile 'New-AsBuiltReport'

    try {

        if ($psISE) {
            Write-Error -Message $translate.PwshISE -ErrorAction Stop
        }

        # If Username and Password parameters used, convert specified Password to secure string and store in $Credential
        if ($Username) {
            if (-not $Password) {
                # If the Password parameter is not provided, prompt for it securely
                $SecurePassword = Read-Host ($translate.password -f $Username) -AsSecureString
            } else {
                # If the Password parameter is provided, convert it to secure string
                $SecurePassword = ConvertTo-SecureString $Password -AsPlainText -Force
            }
            $Credential = New-Object System.Management.Automation.PSCredential ($Username, $SecurePassword)
        }

        if (-not (Test-Path $OutputFolderPath)) {
            Write-Error ($translate.OutputFolderPath -f $OutputFolderPath) -ErrorAction Stop
        }
        #region Variable config

        # Import the AsBuiltReport JSON configuration file
        # If no path was specified, or the specified file doesn't exist, call New-AsBuiltConfig to walk the user through the menu prompt to create a config JSON
        if ($AsBuiltConfigFilePath) {
            if (Test-Path -Path $AsBuiltConfigFilePath) {
                $Global:AsBuiltConfig = Get-Content -Path $AsBuiltConfigFilePath | ConvertFrom-Json
                # Verbose Output for As Built Report configuration
                Write-PScriboMessage -Plugin "Module" -Message ($translate.LoadConfig -f $AsBuiltConfigFilePath)
            } else {
                Write-Error -Message ($translate.NoConfigFound -f $AsBuiltConfigFilePath) -ErrorAction Stop
            }
        } else {
            Write-PScriboMessage -Plugin "Document" -Message $translate.GeneratingReport
            $Global:AsBuiltConfig = New-AsBuiltConfig
        }

        # Set ReportConfigFilePath as Global scope for use in New-AsBuiltConfig
        if ($ReportConfigFilePath) {
            $Global:ReportConfigFilePath = $ReportConfigFilePath
        }

        # Set $OutputFolderPath as Global scope
        if ($OutputFolderPath) {
            $Global:OutputFolderPath = $OutputFolderPath
        }

        # If StyleFilePath was specified, ensure the file provided in the path exists, otherwise exit with error
        if ($StyleFilePath) {
            if (-not (Test-Path -Path $StyleFilePath)) {
                Write-Error ($translate.StyleScriptNotFound -f $StyleFilePath) -ErrorAction Stop
            }
        }

        # Report Module Information
        $Global:Report = $Report
        $ReportModuleName = "AsBuiltReport.$Report"
        $CoreModulePath = (Get-Module -Name 'AsBuiltReport.Core' -ListAvailable | Sort-Object -Property Version -Descending | Select-Object -First 1).ModuleBase
        $ReportModulePath = (Get-Module -Name $ReportModuleName -ListAvailable | Sort-Object -Property Version -Descending | Select-Object -First 1).ModuleBase

        if ($ReportConfigFilePath) {
            # If ReportConfigFilePath was specified, ensure the file provided in the path exists, otherwise exit with error
            if (-not (Test-Path -Path $ReportConfigFilePath)) {
                Write-Error -Message ($translate.ReportModuleNotFound -f $ReportModuleName, $ReportConfigFilePath) -ErrorAction Stop
            } else {
                # Import the Report Configuration in to a variable
                Write-PScriboMessage -Plugin "Document" -Message ($translate.LoadingReportConfig -f $ReportModuleName, $ReportConfigFilePath)
                $Global:ReportConfig = Get-Content -Path $ReportConfigFilePath | ConvertFrom-Json
            }
        } else {
            # If a report config hasn't been provided, check for the existance of the default JSON in the paths the user specified in base config
            $ReportConfigFilePath =  $ReportModulePath + $DirectorySeparatorChar + "$($ReportModuleName).json"
            if (Test-Path -Path $ReportConfigFilePath) {
                Write-PScriboMessage -Plugin "Document" -Message ($translate.LoadingReportConfig -f $ReportModuleName, $ReportConfigFilePath)
                $Global:ReportConfig = Get-Content -Path $ReportConfigFilePath | ConvertFrom-Json
            } else {
                Write-Error -Message ($translate.ReportConfigNotFound -f $ReportModulePath) -ErrorAction Stop
            }
        }

        # If Filename parameter is not specified, set filename to the report name
        if (-not $Filename) {
            $FileName = $ReportConfig.Report.Name
        }
        # If Timestamp parameter is specified, add the timestamp to the report filename
        if ($Timestamp) {
            $FileName = $Filename + " - " + (Get-Date -Format 'yyyy-MM-dd_HH.mm.ss')
        }
        Write-PScriboMessage -Plugin "Document" -Message ($translate.SetReportFileName -f $FileName)

        # If the EnableHealthCheck parameter has been specified, set the global healthcheck variable so report scripts can reference the health checks
        if ($EnableHealthCheck) {
            $Global:Healthcheck = $ReportConfig.HealthCheck
        }

        # Set Global scope for Orientation parameter
        $Global:Orientation = $Orientation

        #endregion Variable config

        #region Email Server Authentication
        # If Email Server Authentication is required, prompt user for credentials
        if ($SendEmail -and $AsBuiltConfig.Email.Credentials) {
            Clear-Host
            Draw-AsciiBox -Lines @($translate.EmailBannerTitle) -ExtraPadding 4 -TextColor 'Cyan' -BorderColor 'Cyan'
            $MailCredentials = Get-Credential -Message ($translate.EmailCredentials -f $AsBuiltConfig.Email.Server)
            Clear-Host
        }
        #endregion Email Server Authentication

        # Check installed module version
        Try {
            $InstalledVersion = Get-Module -ListAvailable -Name AsBuiltReport.Core -ErrorAction SilentlyContinue | Sort-Object -Property Version -Descending | Select-Object -First 1 -ExpandProperty Version

            if ($InstalledVersion) {
                Write-PScriboMessage -Plugin "Module" -Message ($translate.InstalledModule -f $($InstalledVersion.ToString()))
                $LatestVersion = Find-Module -Name AsBuiltReport.Core -Repository PSGallery -ErrorAction SilentlyContinue | Select-Object -ExpandProperty Version
                if ($LatestVersion -gt $InstalledVersion) {
                    Write-PScriboMessage -Plugin "Module" -Message ($translate.AvailableModule -f $($LatestVersion.ToString()))
                    Write-PScriboMessage -Plugin "Module" -Message $translate.UpdateModule
                }
            }
        } Catch {
            Write-PscriboMessage -Plugin "Module" -IsWarning $_.Exception.Message
        }

        #region Generate PScribo document
        # if Verbose has been passed
        if ($PSCmdlet.MyInvocation.BoundParameters["Verbose"].IsPresent) {
            $AsBuiltReport = Document $FileName -Verbose {
                Write-PScriboMessage -Plugin "Document" -Message ($translate.ReportGenerating -f $($Report.Replace(".", " ")))
                # Set Document Style
                if ($StyleFilePath) {
                    Write-PScriboMessage -Plugin "Document" -Message ($translate.ReportStyleScript -f $StyleFilePath)
                    . $StyleFilePath
                } else {
                    $StyleFilePath = $CoreModulePath + $DirectorySeparatorChar + 'AsBuiltReport.Core.Style.ps1'
                    Write-PScriboMessage -Plugin "Document" -Message ($translate.ReportStyleScript -f $StyleFilePath)
                    . $StyleFilePath
                }
                # If Credential has been passed or previously created via Username/Password
                if ($Credential) {
                    & "Invoke-$($ReportModuleName)" -Target $Target -Credential $Credential -Verbose
                }
                elseif ($Token) {
                    & "Invoke-$($ReportModuleName)" -Target $Target -Token $Token -Verbose
                }
                elseif ($MFA) {
                    Write-PScriboMessage -Plugin "Module" -Message $translate.MfaEnabled
                    & "Invoke-$($ReportModuleName)" -Target $Target -MFA -Verbose
                }
            }
        } else {
            $AsBuiltReport = Document $FileName {
                Write-Host ($translate.ReportGenerating -f $($Report.Replace(".", " "))) -ForegroundColor Green
                if ($MFA) {
                    Write-PScriboMessage -Plugin "Module" -Message $translate.MfaEnabled
                }
                # Set Document Style
                if ($StyleFilePath) {
                    Write-PScriboMessage -Plugin "Document" -Message ($translate.ReportStyleScript -f $StyleFilePath)
                    . $StyleFilePath
                } else {
                    $StyleFilePath = $CoreModulePath + $DirectorySeparatorChar + 'AsBuiltReport.Core.Style.ps1'
                    Write-PScriboMessage -Plugin "Document" -Message ($translate.ReportStyleScript -f $StyleFilePath)
                    . $StyleFilePath
                }
                # If Credential has been passed or previously created via Username/Password
                if ($Credential) {
                    & "Invoke-$($ReportModuleName)" -Target $Target -Credential $Credential
                }
                elseif ($Token) {
                    & "Invoke-$($ReportModuleName)" -Target $Target -Token $Token
                }
                elseif ($MFA) {
                    & "Invoke-$($ReportModuleName)" -Target $Target -MFA
                }
            }
        }
        Try {
            $Document = $AsBuiltReport | Export-Document -Path $OutputFolderPath -Format $Format -Options @{ TextWidth = 240 } -PassThru
            Write-Output ($translate.OutputFolder -f $($Report.Replace(".", " ")), $FileName, $OutputFolderPath)
        } catch {
            $Err = $_
            Write-Error $Err
        }
        #endregion Generate PScribo document

        #region Send-Email
        if ($SendEmail) {
            $EmailArguments = @{
                Attachments = $Document
                To = $AsBuiltConfig.Email.To
                From = $AsBuiltConfig.Email.From
                Subject = $ReportConfig.Report.Name
                Body = $AsBuiltConfig.Email.Body
                SmtpServer = $AsBuiltConfig.Email.Server
                Port = $AsBuiltConfig.Email.Port
                UseSSL = $AsBuiltConfig.Email.UseSSL
            }

            if ($AsBuiltConfig.Email.Credentials) {
                # Send the report via SMTP using SSL
                Send-MailMessage @EmailArguments -Credential $MailCredentials
            } else {
                # Send the report via SMTP
                Send-MailMessage @EmailArguments
            }
        }
        #endregion Send-Email

        #region Globals cleanup
        Remove-Variable -Name AsBuiltConfig -Scope Global
        Remove-Variable -Name ReportConfig -Scope Global
        Remove-Variable -Name Report -Scope Global
        Remove-Variable -Name Orientation -Scope Global
        if ($ReportConfigFilePath) {
            Remove-Variable -Name ReportConfigFilePath
        }
        if ($Healthcheck) {
            Remove-Variable -Name Healthcheck -Scope Global
        }
        #endregion Globals cleanup

    } catch {
        Write-Error $_
    }
}

Register-ArgumentCompleter -CommandName 'New-AsBuiltReport' -ParameterName 'Report' -ScriptBlock {
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