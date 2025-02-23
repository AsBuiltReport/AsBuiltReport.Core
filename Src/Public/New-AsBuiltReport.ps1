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

    $DirectorySeparatorChar = [System.IO.Path]::DirectorySeparatorChar

    try {

        if ($psISE) {
            Write-Error -Message "AsBuiltReport cannot be run from Windows PowerShell ISE. Please use a PowerShell command window instead."
            break
        }

        # If Username and Password parameters used, convert specified Password to secure string and store in $Credential
        if ($Username) {
            if (-not $Password) {
                # If the Password parameter is not provided, prompt for it securely
                $SecurePassword = Read-Host "Password for user $Username" -AsSecureString
            } else {
                # If the Password parameter is provided, convert it to secure string
                $SecurePassword = ConvertTo-SecureString $Password -AsPlainText -Force
            }
            $Credential = New-Object System.Management.Automation.PSCredential ($Username, $SecurePassword)
        }

        if (-not (Test-Path $OutputFolderPath)) {
            Write-Error "OutputFolderPath '$OutputFolderPath' is not a valid folder path."
            break
        }
        #region Variable config

        # Import the AsBuiltReport JSON configuration file
        # If no path was specified, or the specified file doesn't exist, call New-AsBuiltConfig to walk the user through the menu prompt to create a config JSON
        if ($AsBuiltConfigFilePath) {
            if (Test-Path -Path $AsBuiltConfigFilePath) {
                $Global:AsBuiltConfig = Get-Content -Path $AsBuiltConfigFilePath | ConvertFrom-Json
                # Verbose Output for As Built Report configuration
                Write-Verbose -Message "Loading As Built Report configuration from '$AsBuiltConfigFilePath'."
            } else {
                Write-Error "Could not find As Built Report configuration in path '$AsBuiltConfigFilePath'."
                break
            }
        } else {
            Write-Verbose -Message "Generating new As Built Report configuration"
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
                Write-Error "Could not find report style script in path '$StyleFilePath'."
                break
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
                Write-Error "Could not find $ReportModuleName report configuration file in path '$ReportConfigFilePath'."
                break
            } else {
                #Import the Report Configuration in to a variable
                Write-Verbose -Message "Loading $ReportModuleName report configuration file from path '$ReportConfigFilePath'."
                $Global:ReportConfig = Get-Content -Path $ReportConfigFilePath | ConvertFrom-Json
            }
        } else {
            # If a report config hasn't been provided, check for the existance of the default JSON in the paths the user specified in base config
            $ReportConfigFilePath =  $ReportModulePath + $DirectorySeparatorChar + "$($ReportModuleName).json"

            if (Test-Path -Path $ReportConfigFilePath) {
                Write-Verbose -Message "Loading report configuration file from path '$ReportConfigFilePath'."
                $Global:ReportConfig = Get-Content -Path $ReportConfigFilePath | ConvertFrom-Json
            } else {
                Write-Error "Report configuration file not found in module path '$ReportModulePath'."
                break
            }#End if test-path
        }#End if ReportConfigFilePath

        # If Filename parameter is not specified, set filename to the report name
        if (-not $Filename) {
            $FileName = $ReportConfig.Report.Name
        }
        # If Timestamp parameter is specified, add the timestamp to the report filename
        if ($Timestamp) {
            $FileName = $Filename + " - " + (Get-Date -Format 'yyyy-MM-dd_HH.mm.ss')
        }
        Write-Verbose -Message "Setting report filename to '$FileName'."

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
            Write-Host '---------------------------------------------' -ForegroundColor Cyan
            Write-Host '  <        Email Server Credentials       >  ' -ForegroundColor Cyan
            Write-Host '---------------------------------------------' -ForegroundColor Cyan
            $MailCredentials = Get-Credential -Message "Please enter the credentials for $($AsBuiltConfig.Email.Server)"
            Clear-Host
        }
        #endregion Email Server Authentication

        # Check installed module version
        Try {
            $InstalledVersion = Get-Module -ListAvailable -Name AsBuiltReport.Core -ErrorAction SilentlyContinue | Sort-Object -Property Version -Descending | Select-Object -First 1 -ExpandProperty Version

            if ($InstalledVersion) {
                Write-PScriboMessage -Plugin "Module" -IsWarning "AsBuiltReport.Core $($InstalledVersion.ToString()) is currently installed."
                $LatestVersion = Find-Module -Name AsBuiltReport.Core -Repository PSGallery -ErrorAction SilentlyContinue | Select-Object -ExpandProperty Version
                if ($LatestVersion -gt $InstalledVersion) {
                    Write-PScriboMessage -Plugin "Module" -IsWarning "AsBuiltReport.Core $($LatestVersion.ToString()) is available."
                    Write-PScriboMessage -Plugin "Module" -IsWarning "Run 'Update-Module -Name AsBuiltReport.Core -Force' to install the latest version."
                }
            }
        } Catch {
                Write-PscriboMessage -Plugin "Module" -IsWarning $_.Exception.Message
        }

        #region Generate PScribo document
        # if Verbose has been passed
        if ($PSCmdlet.MyInvocation.BoundParameters["Verbose"].IsPresent) {
            $AsBuiltReport = Document $FileName -Verbose {
                Write-PScriboMessage "Please wait while the $($Report.Replace("."," ")) As Built Report is being generated."
                # Set Document Style
                if ($StyleFilePath) {
                    Write-PScriboMessage "Executing report style script from path '$StyleFilePath'."
                    . $StyleFilePath
                } else {
                    $StyleFilePath = $CoreModulePath + $DirectorySeparatorChar + 'AsBuiltReport.Core.Style.ps1'
                    Write-PScriboMessage "Executing report style script from path '$($StyleFilePath)'."
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
                    Write-PScriboMessage -Plugin "MFA" -IsWarning "MFA is enabled, please check for MFA authentication windows to generate your report."
                    & "Invoke-$($ReportModuleName)" -Target $Target -MFA -Verbose
                }
            }
        } else {
            $AsBuiltReport = Document $FileName {
                Write-Host "Please wait while the $($Report.Replace("."," ")) As Built Report is being generated." -ForegroundColor Green
                if ($MFA) {
                    Write-Host "MFA is enabled, please check for MFA authentication windows to generate your report." -ForegroundColor Yellow
                }
                # Set Document Style
                if ($StyleFilePath) {
                    Write-PScriboMessage "Executing report style script from path '$StyleFilePath'."
                    . $StyleFilePath
                } else {
                    $StyleFilePath = $CoreModulePath + $DirectorySeparatorChar + 'AsBuiltReport.Core.Style.ps1'
                    Write-PScriboMessage "Executing report style script from path '$($StyleFilePath)'."
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
            Write-Output "$($Report.Replace("."," ")) As Built Report '$FileName' has been saved to '$OutputFolderPath'."
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
