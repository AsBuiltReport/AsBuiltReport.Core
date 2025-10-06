# culture = 'nl-NL'
@{

# As Built Report Information
ReportInfo = ConvertFrom-StringData @'
    BannerTitle = As Built Report Informatie
    ReportAuthor = Voer de naam van de auteur in voor dit As Built Report [{0}]
'@

# Company Configuration
CompanyConfig = ConvertFrom-StringData @'
    BannerTitle = Bedrijfsinformatie
    CompanyInfo = Wilt u bedrijfsinformatie invoeren voor het As Built Report? (y/N)
    CompanyFullName = Voer de volledige bedrijfsnaam in
    CompanyShortName = Voer de verkorte bedrijfsnaam in
    CompanyContact = Voer het bedrijfscontact in
    CompanyEmail = Voer het e-mailadres van het bedrijf in
    CompanyPhone = Voer het telefoonnummer van het bedrijf in
    CompanyAddress = Voer het bedrijfsadres in
'@

# Email Configuration
EmailConfig = ConvertFrom-StringData @'
    BannerTitle = E-mailconfiguratie
    ConfigureMailSettings = Wilt u SMTP-configuratie invoeren? (y/N)
    MailServer = Voer de FQDN / het IP-adres van de mailserver in
    EmptyMailServerAddress = Het adres van de mailserver mag niet leeg zijn. Voer een geldige FQDN / IP-adres van de mailserver in.
    InvalidMailServer = '{0}' is geen geldige FQDN of IP-adres. Voer een geldige FQDN / IP-adres van de mailserver in.
    MailServerPort587 = Voer het poortnummer van de mailserver in [587]
    InvalidMailServerPort587 = Ongeldig poortnummer. Voer een nummer tussen 1 en 65535 in, of druk op Enter voor de standaardwaarde [587].
    MailServerPort25 = Voer het poortnummer van de mailserver in [25]
    InvalidMailServerPort25 = Ongeldig poortnummer. Voer een nummer tussen 1 en 65535 in, of druk op Enter voor de standaardwaarde [25].
    MailServerUseSSL = SSL gebruiken voor mailserververbinding? (y/N)
    MailCredentials = Is mailserververificatie vereist? (y/N)
    MailFrom = Voer het e-mailadres van de afzender in
    MailTo = Voer het e-mailadres van de ontvanger in
    EmptyEmail = Het e-mailadres mag niet leeg zijn. Voer een geldig e-mailadres in.
    InvalidEmail = '{0}' is geen geldig e-mailadres. Voer een geldig e-mailadres in.
    AnotherRecipient = Wilt u een andere ontvanger invoeren? (y/N)
    MailBodyPrompt = Voer de inhoud van het e-mailbericht in
    MailBody = As Built Report bijgevoegd
'@

# Report Configuration
ReportConfig = ConvertFrom-StringData @'
    BannerTitle = As Built Report Configuratie
    ReportConfigFolder = Voer het volledige pad in van de map die moet worden gebruikt voor het opslaan van configuratiebestanden van de rapportmodule en aangepaste stijlscripts [{0}]
    OverwriteReportConfig = Er bestaat al een configuratiebestand van de rapportmodule voor {0} in de opgegeven map. Wilt u deze overschrijven? (y/N)
    CopyFile = '{0}' wordt gekopieerd naar '{1}'.
    OverwriteFile = '{0}' wordt gekopieerd naar '{1}'. Bestaand bestand wordt overschreven.
    SaveAsBuiltConfig = Wilt u het configuratiebestand van de As Built Report-kernmodule opslaan? (Y/n)
    AsBuiltName = Voer een naam in voor het As Built Report-configuratiebestand [AsBuiltReport]
    AsBuiltExportPath = Voer het pad in om het As Built Report-configuratiebestand op te slaan [{0}]
    ConfigFolder = As Built Report-configuratiemap '{0}' wordt gemaakt.
    SaveConfig = As Built Report-configuratiebestand '{0}.json' wordt opgeslagen in pad '{1}'.
    NotSaved = As Built Report-configuratiebestand niet opgeslagen.
'@
}
