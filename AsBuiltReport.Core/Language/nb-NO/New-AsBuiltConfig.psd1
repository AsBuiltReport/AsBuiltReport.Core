# culture = 'nb-NO'
@{

# As Built Report Information
ReportInfo = ConvertFrom-StringData @'
    BannerTitle = As Built Report Informasjon
    ReportAuthor = Skriv inn navnet på forfatteren for denne As Built Report [{0}]
'@

# Company Configuration
CompanyConfig = ConvertFrom-StringData @'
    BannerTitle = Selskapsinformasjon
    CompanyInfo = Vil du oppgi selskapsinformasjon for As Built Report? (y/N)
    CompanyFullName = Skriv inn det fullstendige selskapsnavnet
    CompanyShortName = Skriv inn selskapets kortnavn
    CompanyContact = Skriv inn selskapskontakt
    CompanyEmail = Skriv inn selskapets e-postadresse
    CompanyPhone = Skriv inn selskapets telefonnummer
    CompanyAddress = Skriv inn selskapsadressen
'@

# Email Configuration
EmailConfig = ConvertFrom-StringData @'
    BannerTitle = E-postkonfigurasjon
    ConfigureMailSettings = Vil du oppgi SMTP-konfigurasjon? (y/N)
    MailServer = Skriv inn e-postserverens FQDN / IP-adresse
    EmptyMailServerAddress = E-postserveradressen kan ikke være tom. Vennligst skriv inn en gyldig FQDN / IP-adresse for e-postserveren.
    InvalidMailServer = '{0}' er ikke en gyldig FQDN eller IP-adresse. Vennligst skriv inn en gyldig FQDN / IP-adresse for e-postserveren.
    MailServerPort587 = Skriv inn e-postserverens portnummer [587]
    InvalidMailServerPort587 = Ugyldig portnummer. Vennligst skriv inn et tall mellom 1 og 65535, eller trykk Enter for standardverdi [587].
    MailServerPort25 = Skriv inn e-postserverens portnummer [25]
    InvalidMailServerPort25 = Ugyldig portnummer. Vennligst skriv inn et tall mellom 1 og 65535, eller trykk Enter for standardverdi [25].
    MailServerUseSSL = Bruk SSL for e-postservertilkobling? (y/N)
    MailCredentials = Krever e-postserveren autentisering? (y/N)
    MailFrom = Skriv inn avsenderens e-postadresse
    MailTo = Skriv inn mottakerens e-postadresse
    EmptyEmail = E-postadressen kan ikke være tom. Vennligst skriv inn en gyldig e-postadresse.
    InvalidEmail = '{0}' er ikke en gyldig e-postadresse. Vennligst skriv inn en gyldig e-postadresse.
    AnotherRecipient = Vil du oppgi en annen mottaker? (y/N)
    MailBodyPrompt = Skriv inn innholdet i e-postmeldingen
    MailBody = As Built Report vedlagt
'@

# Report Configuration
ReportConfig = ConvertFrom-StringData @'
    BannerTitle = As Built Report Konfigurasjon
    ReportConfigFolder = Skriv inn hele banen til mappen som skal brukes til å lagre rapportmodulkonfigurasjonsfiler og tilpassede stilskript [{0}]
    OverwriteReportConfig = En rapportmodulkonfigurasjonsfil for {0} finnes allerede i den angitte mappen. Vil du overskrive den? (y/N)
    CopyFile = Kopierer '{0}' til '{1}'.
    OverwriteFile = Kopierer '{0}' til '{1}'. Overskriver eksisterende fil.
    SaveAsBuiltConfig = Vil du lagre As Built Report kjernemodul konfigurasjonsfilen? (Y/n)
    AsBuiltName = Skriv inn et navn for As Built Report konfigurasjonsfilen [AsBuiltReport]
    AsBuiltExportPath = Skriv inn banen for å lagre As Built Report konfigurasjonsfilen [{0}]
    ConfigFolder = Oppretter As Built Report konfigurasjonsmappe '{0}'.
    SaveConfig = Lagrer As Built Report konfigurasjonsfil '{0}.json' til banen '{1}'.
    NotSaved = As Built Report konfigurasjonsfilen ble ikke lagret.
'@
}
