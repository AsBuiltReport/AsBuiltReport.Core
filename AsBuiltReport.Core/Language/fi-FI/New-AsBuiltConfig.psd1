# culture = 'fi-FI'
@{

# As Built Report Information
ReportInfo = ConvertFrom-StringData @'
    BannerTitle = As Built Report Tiedot
    ReportAuthor = Anna tämän As Built Report tekijän nimi [{0}]
'@

# Company Configuration
CompanyConfig = ConvertFrom-StringData @'
    BannerTitle = Yrityksen Tiedot
    CompanyInfo = Haluatko syöttää yrityksen tiedot As Built Report -raporttiin? (y/N)
    CompanyFullName = Anna yrityksen koko nimi
    CompanyShortName = Anna yrityksen lyhyt nimi
    CompanyContact = Anna yrityksen yhteystieto
    CompanyEmail = Anna yrityksen sähköpostiosoite
    CompanyPhone = Anna yrityksen puhelinnumero
    CompanyAddress = Anna yrityksen osoite
'@

# Email Configuration
EmailConfig = ConvertFrom-StringData @'
    BannerTitle = Sähköpostiasetukset
    ConfigureMailSettings = Haluatko syöttää SMTP-asetukset? (y/N)
    MailServer = Anna sähköpostipalvelimen FQDN / IP-osoite
    EmptyMailServerAddress = Sähköpostipalvelimen osoite ei voi olla tyhjä. Anna kelvollinen sähköpostipalvelimen FQDN / IP-osoite.
    InvalidMailServer = '{0}' ei ole kelvollinen FQDN tai IP-osoite. Anna kelvollinen sähköpostipalvelimen FQDN / IP-osoite.
    MailServerPort587 = Anna sähköpostipalvelimen porttinumero [587]
    InvalidMailServerPort587 = Virheellinen porttinumero. Anna numero välillä 1 - 65535 tai paina Enter käyttääksesi oletusarvoa [587].
    MailServerPort25 = Anna sähköpostipalvelimen porttinumero [25]
    InvalidMailServerPort25 = Virheellinen porttinumero. Anna numero välillä 1 - 65535 tai paina Enter käyttääksesi oletusarvoa [25].
    MailServerUseSSL = Käytetäänkö SSL:ää sähköpostipalvelinyhteyteen? (y/N)
    MailCredentials = Vaatiiko sähköpostipalvelin todennuksen? (y/N)
    MailFrom = Anna lähettäjän sähköpostiosoite
    MailTo = Anna vastaanottajan sähköpostiosoite
    EmptyEmail = Sähköpostiosoite ei voi olla tyhjä. Anna kelvollinen sähköpostiosoite.
    InvalidEmail = '{0}' ei ole kelvollinen sähköpostiosoite. Anna kelvollinen sähköpostiosoite.
    AnotherRecipient = Haluatko lisätä toisen vastaanottajan? (y/N)
    MailBodyPrompt = Anna sähköpostiviestin sisältö
    MailBody = As Built Report liitteenä
'@

# Report Configuration
ReportConfig = ConvertFrom-StringData @'
    BannerTitle = As Built Report Asetukset
    ReportConfigFolder = Anna kansion koko polku, jota käytetään raporttiasetustiedostojen ja mukautettujen tyyliskriptien tallentamiseen [{0}]
    OverwriteReportConfig = Raporttimoduulin asetustiedosto kohteelle {0} on jo olemassa määritetyssä kansiossa. Haluatko korvata sen? (y/N)
    CopyFile = Kopioidaan '{0}' kohteeseen '{1}'.
    OverwriteFile = Kopioidaan '{0}' kohteeseen '{1}'. Korvataan olemassa oleva tiedosto.
    SaveAsBuiltConfig = Haluatko tallentaa As Built Report ydinmoduulin asetustiedoston? (Y/n)
    AsBuiltName = Anna nimi As Built Report asetustiedostolle [AsBuiltReport]
    AsBuiltExportPath = Anna polku As Built Report asetustiedoston tallentamiseen [{0}]
    ConfigFolder = Luodaan As Built Report asetuskansio '{0}'.
    SaveConfig = Tallennetaan As Built Report asetustiedosto '{0}.json' polkuun '{1}'.
    NotSaved = As Built Report asetustiedostoa ei tallennettu.
'@
}
