# culture = 'en-US'
@{

# As Built Report Information
ReportInfo = ConvertFrom-StringData @'
    BannerTitle = As Built Report Information
    ReportAuthor = Enter the name of the author for this As Built Report [{0}]
'@

# Company Configuration
CompanyConfig = ConvertFrom-StringData @'
    BannerTitle = Company Information
    CompanyInfo = Would you like to enter company information for the As Built Report? (y/N)
    CompanyFullName = Enter the Full Company Name
    CompanyShortName = Enter the Company Short Name
    CompanyContact = Enter the Company Contact
    CompanyEmail = Enter the Company Email Address
    CompanyPhone = Enter the Company Phone Number
    CompanyAddress = Enter the Company Address
'@

# Email Configuration
EmailConfig = ConvertFrom-StringData @'
    BannerTitle = Email Configuration
    ConfigureMailSettings = Would you like to enter SMTP configuration? (y/N)
    MailServer = Enter the mail server FQDN / IP address
    EmptyMailServerAddress = Mail server address cannot be empty. Please enter a valid mail server FQDN / IP address.
    InvalidMailServer = '{0}' is not a valid FQDN or IP address. Please enter a valid mail server FQDN / IP address.
    MailServerPort587 = Enter the mail server port number [587]
    InvalidMailServerPort587 = Invalid port number. Please enter a number between 1 and 65535, or press Enter for default [587].
    MailServerPort25 = Enter the mail server port number [25]
    InvalidMailServerPort25 = Invalid port number. Please enter a number between 1 and 65535, or press Enter for default [25].
    MailServerUseSSL = Use SSL for mail server connection? (y/N)
    MailCredentials = Require mail server authentication? (y/N)
    MailFrom = Enter the mail sender email address
    MailTo = Enter the mail server recipient email address
    EmptyEmail = Email address cannot be empty. Please enter a valid email address.
    InvalidEmail = '{0}' is not a valid email address. Please enter a valid email address.
    AnotherRecipient = Do you want to enter another recipient? (y/N)
    MailBodyPrompt = Enter the email message body content
    MailBody = As Built Report attached
'@

# Report Configuration
ReportConfig = ConvertFrom-StringData @'
    BannerTitle = As Built Report Configuration
    ReportConfigFolder = Enter the full path of the folder to use for storing report configuration files and custom style scripts [{0}]
    OverwriteReportConfig = A report configuration file for {0} already exists in the specified folder. Would you like to overwrite it? (y/N)
    CopyFile = Copying '{0}' to '{1}'.
    OverwriteFile = Copying '{0}' to '{1}'. Overwriting existing file.
    SaveAsBuiltConfig = Would you like to save the As Built Report configuration file? (Y/n)
    AsBuiltName = Enter a name for the As Built Report configuration file [AsBuiltReport]
    AsBuiltExportPath = Enter the path to save the As Built Report configuration file [{0}]
    ConfigFolder = Creating As Built Report configuration folder '{0}'.
    SaveConfig = Saving As Built Report configuration file '{0}.json' to path '{1}'.
    NotSaved = As Built Report configuration file not saved.
'@
}