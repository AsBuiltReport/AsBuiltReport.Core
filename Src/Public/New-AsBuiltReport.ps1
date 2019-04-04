function New-AsBuiltReport {
    <#
    .SYNOPSIS  
        Documents the configuration of IT infrastructure in Word/HTML/XML/Text formats using PScribo.
    .DESCRIPTION
        Documents the configuration of IT infrastructure in Word/HTML/XML/Text formats using PScribo.
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
    .PARAMETER Format
        Specifies the output format of the report.
        The supported output formats are WORD, HTML, XML & TEXT.
        Multiple output formats may be specified, separated by a comma.
    .PARAMETER Orientation
        Sets the page orientation of the report to Portrait or Landscape.
        By default, page orientation will be set to Portrait.
    .PARAMETER StylePath
        Specifies the path to a custom style .ps1 script for the report to use.
    .PARAMETER OutputPath
        Specifies the path to save the report.
    .PARAMETER Timestamp
        Specifies whether to append a timestamp string to the report filename.
        By default, the timestamp string is not added to the report filename.
    .PARAMETER EnableHealthCheck
        Performs a health check of the target environment and highlights known issues within the report.
        Not all reports may provide this functionality.
    .PARAMETER SendEmail
        Sends report to specified recipients as email attachments.
    .PARAMETER AsBuiltConfigPath
        Enter the full path to the As Built Report configuration JSON file.
        If this parameter is not specified, the user will be prompted for this configuration information on first 
        run, with the option to save the configuration to a file.
    .PARAMETER ReportConfigPath
        Enter the full path to a report JSON configuration file
        If this parameter is not specified, a default report configuration JSON is copied to the specifed user folder.
        If this paramter is specified and the path to a JSON file is invalid, the script will terminate
    .EXAMPLE
        PS C:\>New-AsBuiltReport -Target 192.168.1.100 -Username admin -Password admin -Format HTML,Word -Report VMware.vSphere -EnableHealthCheck -OutputPath c:\scripts\

        Creates a VMware vSphere As Built Report in HTML & Word formats. The document will highlight particular issues which exist within the environment.
        The report will be saved to c:\scripts.
    .EXAMPLE
        PS C:\>$Creds = Get-Credential
        PS C:\>New-AsBuiltReport -Target 192.168.1.100 -Credential $Creds -Format Text -Report PureStorage.FlashArray -Timestamp -OutputPath c:\scripts\

        Creates a Pure Storage FlashArray As Built Report in Text format and appends a timestamp to the filename. 
        Stored credentials are used to connect to the system.
        The report will be saved to c:\scripts.
    .EXAMPLE
        PS C:\>New-AsBuiltReport -Target 192.168.1.100 -Username admin -Password admin -Report Cisco.UCSManager -StylePath c:\scripts\AsBuiltReport\Styles\ACME.ps1 -OutputPath c:\scripts\

        Creates a Cisco UCS As Built Report in default format (Word) with a customised style.
        The report will be saved to c:\scripts.
    .EXAMPLE
        PS C:\>New-AsBuiltReport -Target 192.168.1.100 -Username admin -Password admin -Report Nutanix.AOS -SendEmail -OutputPath c:\scripts\

        Creates a Nutanix AOS As Built Report in default format (Word). Report will be attached and sent via email.
        The report will be saved to c:\scripts.
    .EXAMPLE
        PS C:\>New-AsBuiltReport -Target 192.168.1.100 -Username admin -Password admin -Format HTML -Report VMware.vSphere -AsBuiltConfigPath C:\scripts\asbuiltreport.json -OutputPath c:\scripts\
        
        Creates a VMware vSphere As Built Report in HTML format, using the configuration in the asbuiltreport.json file located in the C:\scripts\ folder.
        The report will be saved to c:\scripts.
    .NOTES
        Version:        1.0.0
        Author(s):      Tim Carman / Matt Allford
        Twitter:        @tpcarman / @mattallford
        Github:         AsBuiltReport
        Credits:        Iain Brighton (@iainbrighton) - PScribo module
                        
    .LINK
        https://github.com/AsBuiltReport
        https://github.com/iainbrighton/PScribo
    #>

    #region Script Parameters
    [CmdletBinding(
        PositionalBinding = $false
    )]
    param (
        [Parameter(
            Position = 0,
            Mandatory = $true,
            HelpMessage = 'Please specify which report type you wish to run.'
        )]
        [ValidateScript( {
                $InstalledReportModules = Get-Module -Name "AsBuiltReport.*" #-ListAvailable
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
        [string] $Report,

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
            HelpMessage = 'Please provide credentails to connect to the system',
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
            Mandatory = $true,
            HelpMessage = 'Please provide the password to connect to the target system',
            ParameterSetName = 'UsernameAndPassword'
        )]
        [ValidateNotNullOrEmpty()]
        [String] $Password,

        [Parameter(
            Position = 4,
            Mandatory = $false,
            HelpMessage = 'Please provide the document output format'
        )]
        [ValidateNotNullOrEmpty()]
        [ValidateSet('Word', 'HTML', 'Text', 'XML')]
        [Array] $Format = 'Word',

        [Parameter(
            Position = 5,
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
        [String] $OutputPath,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Please provide the path to the custom style script'
        )]
        [ValidateNotNullOrEmpty()] 
        [String] $StylePath,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Provide the file path to an existing report JSON Configuration file'
        )]
        [string] $ReportConfigPath,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Provide the file path to an existing As Built JSON Configuration file'
        )]
        [string] $AsBuiltConfigPath,

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

    try {

        # If Username and Password parameters used, convert specified Password to secure string and store in $Credential
        if (($Username -and $Password)) {
            $SecurePassword = ConvertTo-SecureString $Password -AsPlainText -Force
            $Credential = New-Object System.Management.Automation.PSCredential ($Username, $SecurePassword)
        }

        #region Variable config

        # Import the AsBuiltReport JSON configuration file
        # If no path was specified, or the specified file doesn't exist, call New-AsBuiltConfig to walk the user through the menu prompt to create a config JSON
        if ($AsBuiltConfigPath) {
            if (Test-Path -Path $AsBuiltConfigPath) {
                $Global:AsBuiltConfig = Get-Content -Path $AsBuiltConfigPath | ConvertFrom-Json
            }
        } else {
            $Global:AsBuiltConfig = New-AsBuiltConfig
        }

        # Set ReportConfigPath as Global scope for use in New-AsBuiltConfig
        if ($ReportConfigPath) {
            $Global:ReportConfigPath = $ReportConfigPath
        }

        # If Stylepath was specified, ensure the file provided in the path exists, otherwise exit with error
        if ($StylePath) {
            if (!(Test-Path -Path $StylePath)) {
                Write-Error "Could not find a style script at $StylePath"
                break
            }
        }

        $ReportModule = "AsBuiltReport.$Report"

        if ($ReportConfigPath) {
            # If ReportConfigPath was specified, ensure the file provided in the path exists, otherwise exit with error
            if (!(Test-Path -Path $ReportConfigPath)) {
                Write-Error "Could not find a style script at $ReportConfigPath"
                break
            } else {
                #Import the Report Configuration in to a variable
                $Global:ReportConfig = Get-Content -Path $ReportConfigPath | ConvertFrom-Json
            }
        } else {
            # If a report config hasn't been provided, check for the existance of the default JSON in the paths the user specified in base config
            $ReportConfigPath = Join-Path -Path $AsBuiltConfig.UserFolder.Path -ChildPath "$ReportModule.json"
            
            if (Test-Path -Path $ReportConfigPath) {
                $Global:ReportConfig = Get-Content -Path $ReportConfigPath | ConvertFrom-Json
            } else {
                # Create the report JSON and save it in the UserFolder specified in the Base Config
                New-AsBuiltReportConfig -Report $Report -Path $AsBuiltConfig.UserFolder.Path
                $Global:ReportConfig = Get-Content -Path $ReportConfigPath | ConvertFrom-Json
            }#End if test-path
        }#End if ReportConfigPath

        # If Timestamp parameter is specified, add the timestamp to the report filename 
        if ($Timestamp) {
            $FileName = $ReportConfig.Report.Name + " - " + (Get-Date -Format 'yyyy-MM-dd_HH.mm.ss')
        } else {
            $FileName = $ReportConfig.Report.Name
        }

        # If the EnableHealthCheck parameter has been specified, set the global healthcheck variable so report scripts can reference the health checks
        if ($EnableHealthCheck) {
            $Global:Healthcheck = $ReportConfig.HealthCheck
        }

        # Set Global scope for Orientation parameter
        $Global:Orientation = $Orientation
        
        #endregion Variable config

        #region Email Server Authentication
        # If Email Server Authentication is required, prompt user for credentials
        if ($AsBuiltConfig.Email.Credentials) {
            Clear-Host
            Write-Host '---------------------------------------------' -ForegroundColor Cyan
            Write-Host '  <        Email Server Credentials       >  ' -ForegroundColor Cyan
            Write-Host '---------------------------------------------' -ForegroundColor Cyan
            $MailCredentials = Get-Credential -Message "Please enter the credentials for $($AsBuiltConfig.Email.Server)"
        }
        #endregion Email Server Authentication

        #region Generate PScribo document
        $AsBuiltReport = Document $FileName -Verbose {
            # Set Document Style
            if ($StylePath) {
                .$StylePath
            }

            & "Invoke-$($ReportModule)" -Target $Target -Credential $Credential -StylePath $StylePath
        }
        Try {
            $Document = $AsBuiltReport | Export-Document -Path $OutputPath -Format $Format -PassThru
            Write-Output "$FileName has been saved to $OutputPath"
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
            }

            if ($AsBuiltConfig.Email.Credentials) {
                if ($AsBuiltConfig.Email.UseSSL) {
                    # If UseSsl is enabled in the JSON configuration, send the report via SMTP using SSL and with credentials
                    Send-MailMessage @EmailArguments -UseSsl -Credential $MailCredentials
                } else {
                    # Send the report via SMTP using SSL
                    Send-MailMessage @EmailArguments -Credential $MailCredentials
                }
            } elseif ($AsBuiltConfig.Email.UseSSL) {
                # If UseSsl is enabled in the JSON configuration, send the report via SMTP using SSL
                Send-MailMessage @EmailArguments -UseSsl
            } else {
                # Send the report via SMTP
                Send-MailMessage @EmailArguments
            }
        }
        #endregion Send-Email

        #region Globals cleanup
        Clear-Variable AsBuiltConfig -Scope Global
        Clear-Variable ReportConfig -Scope Global
        Clear-Variable ReportConfigPath -Scope Global
        Clear-Variable Healthcheck -Scope Global
        Clear-Variable Orientation -Scope Global
        #endregion Globals cleanup

    } catch {
        $Err = $_
        Write-Error $Err
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

    $InstalledReportModules = Get-Module -Name "AsBuiltReport.*" -ListAvailable
    $ValidReports = foreach ($InstalledReportModule in $InstalledReportModules) {
        $NameArray = $InstalledReportModule.Name.Split('.')
        "$($NameArray[-2]).$($NameArray[-1])"
    }

    $ValidReports | Where-Object {$_ -like "$wordToComplete*"} | ForEach-Object {
        [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
    }
}
