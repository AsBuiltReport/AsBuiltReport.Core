# culture = 'hu-HU'
@{

# As Built Report Information
ReportInfo = ConvertFrom-StringData @'
    BannerTitle = As Built Report Információk
    ReportAuthor = Adja meg ennek az As Built Report szerzőjének nevét [{0}]
'@

# Company Configuration
CompanyConfig = ConvertFrom-StringData @'
    BannerTitle = Cég Információk
    CompanyInfo = Szeretné megadni a céginformációkat az As Built Report számára? (y/N)
    CompanyFullName = Adja meg a cég teljes nevét
    CompanyShortName = Adja meg a cég rövid nevét
    CompanyContact = Adja meg a cég kapcsolattartóját
    CompanyEmail = Adja meg a cég e-mail címét
    CompanyPhone = Adja meg a cég telefonszámát
    CompanyAddress = Adja meg a cég címét
'@

# Email Configuration
EmailConfig = ConvertFrom-StringData @'
    BannerTitle = E-mail Konfiguráció
    ConfigureMailSettings = Szeretné megadni az SMTP konfigurációt? (y/N)
    MailServer = Adja meg a levelezőszerver FQDN / IP címét
    EmptyMailServerAddress = A levelezőszerver címe nem lehet üres. Kérjük, adjon meg egy érvényes levelezőszerver FQDN / IP címét.
    InvalidMailServer = A(z) '{0}' nem érvényes FQDN vagy IP cím. Kérjük, adjon meg egy érvényes levelezőszerver FQDN / IP címét.
    MailServerPort587 = Adja meg a levelezőszerver portszámát [587]
    InvalidMailServerPort587 = Érvénytelen portszám. Kérjük, adjon meg egy számot 1 és 65535 között, vagy nyomja meg az Enter billentyűt az alapértelmezett értékhez [587].
    MailServerPort25 = Adja meg a levelezőszerver portszámát [25]
    InvalidMailServerPort25 = Érvénytelen portszám. Kérjük, adjon meg egy számot 1 és 65535 között, vagy nyomja meg az Enter billentyűt az alapértelmezett értékhez [25].
    MailServerUseSSL = SSL használata a levelezőszerver kapcsolathoz? (y/N)
    MailCredentials = A levelezőszerver hitelesítést igényel? (y/N)
    MailFrom = Adja meg a feladó e-mail címét
    MailTo = Adja meg a címzett e-mail címét
    EmptyEmail = Az e-mail cím nem lehet üres. Kérjük, adjon meg egy érvényes e-mail címet.
    InvalidEmail = A(z) '{0}' nem érvényes e-mail cím. Kérjük, adjon meg egy érvényes e-mail címet.
    AnotherRecipient = Szeretne megadni egy másik címzettet? (y/N)
    MailBodyPrompt = Adja meg az e-mail üzenet törzsének tartalmát
    MailBody = As Built Report csatolva
'@

# Report Configuration
ReportConfig = ConvertFrom-StringData @'
    BannerTitle = As Built Report Konfiguráció
    ReportConfigFolder = Adja meg a jelentésmodul konfigurációs fájlok és egyéni stílusszkriptek tárolásához használandó mappa teljes elérési útját [{0}]
    OverwriteReportConfig = A megadott mappában már létezik egy jelentésmodul konfigurációs fájl a(z) {0} számára. Szeretné felülírni? (y/N)
    CopyFile = '{0}' másolása ide: '{1}'.
    OverwriteFile = '{0}' másolása ide: '{1}'. Meglévő fájl felülírása.
    SaveAsBuiltConfig = Szeretné menteni az As Built Report mag modul konfigurációs fájlt? (Y/n)
    AsBuiltName = Adjon meg egy nevet az As Built Report konfigurációs fájlhoz [AsBuiltReport]
    AsBuiltExportPath = Adja meg az As Built Report konfigurációs fájl mentési útvonalát [{0}]
    ConfigFolder = As Built Report konfigurációs mappa '{0}' létrehozása.
    SaveConfig = As Built Report konfigurációs fájl '{0}.json' mentése az '{1}' útvonalra.
    NotSaved = Az As Built Report konfigurációs fájl nem lett mentve.
'@
}
