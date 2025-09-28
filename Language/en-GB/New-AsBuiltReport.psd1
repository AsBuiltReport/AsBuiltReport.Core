# culture = 'en-US'
ConvertFrom-StringData @'
    PwshISE = AsBuiltReport cannot be run from Windows PowerShell ISE. Please use a PowerShell command window instead.
    Password = Password for user {0}
    OutputFolderPath = OutputFolderPath '{0}' is not a valid folder path.
    LoadConfig = Loading As Built Report configuration from {0}.
    NoConfigFound = Could not find As Built Report configuration in path '{0}'.
    GeneratingReport = Generating new As Built Report configuration.
    StyleScriptNotFound = Could not find report style script in path '{0}'.
    ReportModuleNotFound = Could not find {0} report configuration file in path '{1}'.
    LoadingReportConfig = Loading {0} report configuration file from path '{1}'.
    ReportConfigNotFound = Report configuration not found in module path '{0}'.
    SetReportFileName = Setting report file name to '{0}'.
    EmailBannerTitle = Email Server Credentials
    EmailCredentials = Please enter credentials for {0}.
    InstalledModule = AsBuiltReport.Core {0} is currently installed.
    AvailableModule = AsBuiltReport.Core {0} is available.
    UpdateModule = Run 'Update-Module -Name AsBuiltReport.Core -Force' to install the latest version.
    ReportGenerating = Please wait while the {0} As Built Report is being generated.
    ReportStyleScript = Executing report style script from path '{0}'.
    MfaEnabled = MFA is enabled, please check for MFA authentication windows to generate your report.
    OutputFolder = {0} As Built Report '{1}' has been saved to '{2}'.
'@