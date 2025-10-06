# culture = 'da-DK'
@{

# As Built Report Information
ReportInfo = ConvertFrom-StringData @'
    BannerTitle = As Built Report Information
    ReportAuthor = Indtast navnet på forfatteren til denne As Built Report [{0}]
'@

# Company Configuration
CompanyConfig = ConvertFrom-StringData @'
    BannerTitle = Virksomhedsinformation
    CompanyInfo = Vil du indtaste virksomhedsinformation til As Built Report? (y/N)
    CompanyFullName = Indtast det fulde virksomhedsnavn
    CompanyShortName = Indtast virksomhedens korte navn
    CompanyContact = Indtast virksomhedskontakt
    CompanyEmail = Indtast virksomhedens e-mailadresse
    CompanyPhone = Indtast virksomhedens telefonnummer
    CompanyAddress = Indtast virksomhedsadresse
'@

# Email Configuration
EmailConfig = ConvertFrom-StringData @'
    BannerTitle = E-mailkonfiguration
    ConfigureMailSettings = Vil du indtaste SMTP-konfiguration? (y/N)
    MailServer = Indtast mailserverens FQDN / IP-adresse
    EmptyMailServerAddress = Mailserveradressen må ikke være tom. Indtast venligst en gyldig mailserver FQDN / IP-adresse.
    InvalidMailServer = '{0}' er ikke en gyldig FQDN eller IP-adresse. Indtast venligst en gyldig mailserver FQDN / IP-adresse.
    MailServerPort587 = Indtast mailserverens portnummer [587]
    InvalidMailServerPort587 = Ugyldigt portnummer. Indtast venligst et tal mellem 1 og 65535, eller tryk på Enter for standardværdien [587].
    MailServerPort25 = Indtast mailserverens portnummer [25]
    InvalidMailServerPort25 = Ugyldigt portnummer. Indtast venligst et tal mellem 1 og 65535, eller tryk på Enter for standardværdien [25].
    MailServerUseSSL = Brug SSL til mailserverforbindelse? (y/N)
    MailCredentials = Kræver mailserveren godkendelse? (y/N)
    MailFrom = Indtast afsenderens e-mailadresse
    MailTo = Indtast modtagerens e-mailadresse
    EmptyEmail = E-mailadressen må ikke være tom. Indtast venligst en gyldig e-mailadresse.
    InvalidEmail = '{0}' er ikke en gyldig e-mailadresse. Indtast venligst en gyldig e-mailadresse.
    AnotherRecipient = Vil du indtaste en anden modtager? (y/N)
    MailBodyPrompt = Indtast indholdet af e-mailbeskedens brødtekst
    MailBody = As Built Report vedhæftet
'@

# Report Configuration
ReportConfig = ConvertFrom-StringData @'
    BannerTitle = As Built Report Konfiguration
    ReportConfigFolder = Indtast den fulde sti til mappen, der skal bruges til at gemme rapportmodulkonfigurationsfiler og brugerdefinerede typografiskrip ter [{0}]
    OverwriteReportConfig = En rapportmodulkonfigurationsfil til {0} findes allerede i den angivne mappe. Vil du overskrive den? (y/N)
    CopyFile = Kopierer '{0}' til '{1}'.
    OverwriteFile = Kopierer '{0}' til '{1}'. Overskriver eksisterende fil.
    SaveAsBuiltConfig = Vil du gemme As Built Report kernemodul konfigurationsfilen? (Y/n)
    AsBuiltName = Indtast et navn til As Built Report konfigurationsfilen [AsBuiltReport]
    AsBuiltExportPath = Indtast stien til at gemme As Built Report konfigurationsfilen [{0}]
    ConfigFolder = Opretter As Built Report konfigurationsmappe '{0}'.
    SaveConfig = Gemmer As Built Report konfigurationsfil '{0}.json' til sti '{1}'.
    NotSaved = As Built Report konfigurationsfilen blev ikke gemt.
'@
}
