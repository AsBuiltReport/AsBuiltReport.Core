# culture = 'cs-CZ'
@{

# As Built Report Information
ReportInfo = ConvertFrom-StringData @'
    BannerTitle = Informace o As Built Report
    ReportAuthor = Zadejte jméno autora této sestavy As Built Report [{0}]
'@

# Company Configuration
CompanyConfig = ConvertFrom-StringData @'
    BannerTitle = Informace o společnosti
    CompanyInfo = Chcete zadat informace o společnosti pro sestavu As Built Report? (y/N)
    CompanyFullName = Zadejte úplný název společnosti
    CompanyShortName = Zadejte zkrácený název společnosti
    CompanyContact = Zadejte kontaktní osobu společnosti
    CompanyEmail = Zadejte e-mailovou adresu společnosti
    CompanyPhone = Zadejte telefonní číslo společnosti
    CompanyAddress = Zadejte adresu společnosti
'@

# Email Configuration
EmailConfig = ConvertFrom-StringData @'
    BannerTitle = Konfigurace e-mailu
    ConfigureMailSettings = Chcete zadat konfiguraci SMTP? (y/N)
    MailServer = Zadejte FQDN / IP adresu poštovního serveru
    EmptyMailServerAddress = Adresa poštovního serveru nesmí být prázdná. Zadejte platnou FQDN / IP adresu poštovního serveru.
    InvalidMailServer = '{0}' není platná FQDN nebo IP adresa. Zadejte platnou FQDN / IP adresu poštovního serveru.
    MailServerPort587 = Zadejte číslo portu poštovního serveru [587]
    InvalidMailServerPort587 = Neplatné číslo portu. Zadejte číslo mezi 1 a 65535 nebo stiskněte Enter pro výchozí hodnotu [587].
    MailServerPort25 = Zadejte číslo portu poštovního serveru [25]
    InvalidMailServerPort25 = Neplatné číslo portu. Zadejte číslo mezi 1 a 65535 nebo stiskněte Enter pro výchozí hodnotu [25].
    MailServerUseSSL = Použít SSL pro připojení k poštovnímu serveru? (y/N)
    MailCredentials = Vyžaduje poštovní server ověření? (y/N)
    MailFrom = Zadejte e-mailovou adresu odesílatele
    MailTo = Zadejte e-mailovou adresu příjemce
    EmptyEmail = E-mailová adresa nesmí být prázdná. Zadejte platnou e-mailovou adresu.
    InvalidEmail = '{0}' není platná e-mailová adresa. Zadejte platnou e-mailovou adresu.
    AnotherRecipient = Chcete zadat dalšího příjemce? (y/N)
    MailBodyPrompt = Zadejte obsah těla e-mailové zprávy
    MailBody = Sestava As Built Report připojena
'@

# Report Configuration
ReportConfig = ConvertFrom-StringData @'
    BannerTitle = Konfigurace As Built Report
    ReportConfigFolder = Zadejte úplnou cestu ke složce, která se má použít pro ukládání konfiguračních souborů modulu sestav a vlastních skriptů stylů [{0}]
    OverwriteReportConfig = Konfigurační soubor modulu sestav pro {0} již v zadané složce existuje. Chcete jej přepsat? (y/N)
    CopyFile = Kopírování '{0}' do '{1}'.
    OverwriteFile = Kopírování '{0}' do '{1}'. Přepsání existujícího souboru.
    SaveAsBuiltConfig = Chcete uložit konfigurační soubor základního modulu As Built Report? (Y/n)
    AsBuiltName = Zadejte název konfiguračního souboru As Built Report [AsBuiltReport]
    AsBuiltExportPath = Zadejte cestu pro uložení konfiguračního souboru As Built Report [{0}]
    ConfigFolder = Vytváření konfigurační složky As Built Report '{0}'.
    SaveConfig = Ukládání konfiguračního souboru As Built Report '{0}.json' do cesty '{1}'.
    NotSaved = Konfigurační soubor As Built Report nebyl uložen.
'@
}
