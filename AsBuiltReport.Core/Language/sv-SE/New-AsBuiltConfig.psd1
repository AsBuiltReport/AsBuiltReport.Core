# culture = 'sv-SE'
@{

# As Built Report Information
ReportInfo = ConvertFrom-StringData @'
    BannerTitle = As Built Report Information
    ReportAuthor = Ange namnet på författaren för denna As Built Report [{0}]
'@

# Company Configuration
CompanyConfig = ConvertFrom-StringData @'
    BannerTitle = Företagsinformation
    CompanyInfo = Vill du ange företagsinformation för As Built Report? (y/N)
    CompanyFullName = Ange företagets fullständiga namn
    CompanyShortName = Ange företagets kortnamn
    CompanyContact = Ange företagskontakt
    CompanyEmail = Ange företagets e-postadress
    CompanyPhone = Ange företagets telefonnummer
    CompanyAddress = Ange företagsadress
'@

# Email Configuration
EmailConfig = ConvertFrom-StringData @'
    BannerTitle = E-postkonfiguration
    ConfigureMailSettings = Vill du ange SMTP-konfiguration? (y/N)
    MailServer = Ange e-postserverns FQDN / IP-adress
    EmptyMailServerAddress = E-postserverns adress får inte vara tom. Ange ett giltigt FQDN / IP-adress för e-postservern.
    InvalidMailServer = '{0}' är inte ett giltigt FQDN eller IP-adress. Ange ett giltigt FQDN / IP-adress för e-postservern.
    MailServerPort587 = Ange e-postserverns portnummer [587]
    InvalidMailServerPort587 = Ogiltigt portnummer. Ange ett nummer mellan 1 och 65535, eller tryck på Enter för standardvärdet [587].
    MailServerPort25 = Ange e-postserverns portnummer [25]
    InvalidMailServerPort25 = Ogiltigt portnummer. Ange ett nummer mellan 1 och 65535, eller tryck på Enter för standardvärdet [25].
    MailServerUseSSL = Använd SSL för e-postserveranslutning? (y/N)
    MailCredentials = Kräver e-postservern autentisering? (y/N)
    MailFrom = Ange avsändarens e-postadress
    MailTo = Ange mottagarens e-postadress
    EmptyEmail = E-postadress får inte vara tom. Ange en giltig e-postadress.
    InvalidEmail = '{0}' är inte en giltig e-postadress. Ange en giltig e-postadress.
    AnotherRecipient = Vill du ange en annan mottagare? (y/N)
    MailBodyPrompt = Ange innehållet i e-postmeddelandets brödtext
    MailBody = As Built Report bifogad
'@

# Report Configuration
ReportConfig = ConvertFrom-StringData @'
    BannerTitle = As Built Report Konfiguration
    ReportConfigFolder = Ange den fullständiga sökvägen till mappen som ska användas för att lagra rapportmodulens konfigurationsfiler och anpassade formatskript [{0}]
    OverwriteReportConfig = En konfigurationsfil för rapportmodulen för {0} finns redan i den angivna mappen. Vill du skriva över den? (y/N)
    CopyFile = Kopierar '{0}' till '{1}'.
    OverwriteFile = Kopierar '{0}' till '{1}'. Skriver över befintlig fil.
    SaveAsBuiltConfig = Vill du spara konfigurationsfilen för As Built Report kärnmodul? (Y/n)
    AsBuiltName = Ange ett namn för As Built Report-konfigurationsfilen [AsBuiltReport]
    AsBuiltExportPath = Ange sökvägen för att spara As Built Report-konfigurationsfilen [{0}]
    ConfigFolder = Skapar As Built Report-konfigurationsmapp '{0}'.
    SaveConfig = Sparar As Built Report-konfigurationsfil '{0}.json' till sökväg '{1}'.
    NotSaved = As Built Report-konfigurationsfilen sparades inte.
'@
}
