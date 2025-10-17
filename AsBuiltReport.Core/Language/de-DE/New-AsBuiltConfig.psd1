# culture = 'de-DE'
@{

# As Built Report Information
ReportInfo = ConvertFrom-StringData @'
    BannerTitle = As Built Report Informationen
    ReportAuthor = Geben Sie den Namen des Autors für diesen As Built Report ein [{0}]
'@

# Company Configuration
CompanyConfig = ConvertFrom-StringData @'
    BannerTitle = Unternehmensinformationen
    CompanyInfo = Möchten Sie Unternehmensinformationen für den As Built Report eingeben? (y/N)
    CompanyFullName = Geben Sie den vollständigen Unternehmensnamen ein
    CompanyShortName = Geben Sie den Kurznamen des Unternehmens ein
    CompanyContact = Geben Sie den Unternehmenskontakt ein
    CompanyEmail = Geben Sie die E-Mail-Adresse des Unternehmens ein
    CompanyPhone = Geben Sie die Telefonnummer des Unternehmens ein
    CompanyAddress = Geben Sie die Unternehmensadresse ein
'@

# Email Configuration
EmailConfig = ConvertFrom-StringData @'
    BannerTitle = E-Mail-Konfiguration
    ConfigureMailSettings = Möchten Sie die SMTP-Konfiguration eingeben? (y/N)
    MailServer = Geben Sie den FQDN / die IP-Adresse des Mailservers ein
    EmptyMailServerAddress = Die Mailserveradresse darf nicht leer sein. Bitte geben Sie einen gültigen FQDN / eine gültige IP-Adresse des Mailservers ein.
    InvalidMailServer = '{0}' ist kein gültiger FQDN oder keine gültige IP-Adresse. Bitte geben Sie einen gültigen FQDN / eine gültige IP-Adresse des Mailservers ein.
    MailServerPort587 = Geben Sie die Portnummer des Mailservers ein [587]
    InvalidMailServerPort587 = Ungültige Portnummer. Bitte geben Sie eine Zahl zwischen 1 und 65535 ein oder drücken Sie die Eingabetaste für den Standard [587].
    MailServerPort25 = Geben Sie die Portnummer des Mailservers ein [25]
    InvalidMailServerPort25 = Ungültige Portnummer. Bitte geben Sie eine Zahl zwischen 1 und 65535 ein oder drücken Sie die Eingabetaste für den Standard [25].
    MailServerUseSSL = SSL für Mailserververbindung verwenden? (y/N)
    MailCredentials = Ist eine Mailserver-Authentifizierung erforderlich? (y/N)
    MailFrom = Geben Sie die E-Mail-Adresse des Absenders ein
    MailTo = Geben Sie die E-Mail-Adresse des Empfängers ein
    EmptyEmail = Die E-Mail-Adresse darf nicht leer sein. Bitte geben Sie eine gültige E-Mail-Adresse ein.
    InvalidEmail = '{0}' ist keine gültige E-Mail-Adresse. Bitte geben Sie eine gültige E-Mail-Adresse ein.
    AnotherRecipient = Möchten Sie einen weiteren Empfänger eingeben? (y/N)
    MailBodyPrompt = Geben Sie den Inhalt der E-Mail-Nachricht ein
    MailBody = As Built Report angehängt
'@

# Report Configuration
ReportConfig = ConvertFrom-StringData @'
    BannerTitle = As Built Report Konfiguration
    ReportConfigFolder = Geben Sie den vollständigen Pfad des Ordners ein, der zum Speichern von Berichtsmodulkonfigurationsdateien und benutzerdefinierten Stilskripten verwendet werden soll [{0}]
    OverwriteReportConfig = Eine Berichtsmodulkonfigurationsdatei für {0} existiert bereits im angegebenen Ordner. Möchten Sie sie überschreiben? (y/N)
    CopyFile = '{0}' wird nach '{1}' kopiert.
    OverwriteFile = '{0}' wird nach '{1}' kopiert. Vorhandene Datei wird überschrieben.
    SaveAsBuiltConfig = Möchten Sie die As Built Report Kernmodulkonfigurationsdatei speichern? (Y/n)
    AsBuiltName = Geben Sie einen Namen für die As Built Report Konfigurationsdatei ein [AsBuiltReport]
    AsBuiltExportPath = Geben Sie den Pfad zum Speichern der As Built Report Konfigurationsdatei ein [{0}]
    ConfigFolder = As Built Report Konfigurationsordner '{0}' wird erstellt.
    SaveConfig = As Built Report Konfigurationsdatei '{0}.json' wird im Pfad '{1}' gespeichert.
    NotSaved = As Built Report Konfigurationsdatei wurde nicht gespeichert.
'@
}
