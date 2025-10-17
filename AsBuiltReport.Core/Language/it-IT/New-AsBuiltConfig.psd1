# culture = 'it-IT'
@{

# As Built Report Information
ReportInfo = ConvertFrom-StringData @'
    BannerTitle = Informazioni As Built Report
    ReportAuthor = Inserire il nome dell'autore per questo As Built Report [{0}]
'@

# Company Configuration
CompanyConfig = ConvertFrom-StringData @'
    BannerTitle = Informazioni Aziendali
    CompanyInfo = Si desidera inserire le informazioni aziendali per l'As Built Report? (y/N)
    CompanyFullName = Inserire il Nome Completo dell'Azienda
    CompanyShortName = Inserire il Nome Abbreviato dell'Azienda
    CompanyContact = Inserire il Contatto Aziendale
    CompanyEmail = Inserire l'Indirizzo Email Aziendale
    CompanyPhone = Inserire il Numero di Telefono Aziendale
    CompanyAddress = Inserire l'Indirizzo Aziendale
'@

# Email Configuration
EmailConfig = ConvertFrom-StringData @'
    BannerTitle = Configurazione Email
    ConfigureMailSettings = Si desidera inserire la configurazione SMTP? (y/N)
    MailServer = Inserire l'FQDN / indirizzo IP del server di posta
    EmptyMailServerAddress = L'indirizzo del server di posta non può essere vuoto. Inserire un FQDN / indirizzo IP valido del server di posta.
    InvalidMailServer = '{0}' non è un FQDN o indirizzo IP valido. Inserire un FQDN / indirizzo IP valido del server di posta.
    MailServerPort587 = Inserire il numero di porta del server di posta [587]
    InvalidMailServerPort587 = Numero di porta non valido. Inserire un numero compreso tra 1 e 65535 o premere Invio per il valore predefinito [587].
    MailServerPort25 = Inserire il numero di porta del server di posta [25]
    InvalidMailServerPort25 = Numero di porta non valido. Inserire un numero compreso tra 1 e 65535 o premere Invio per il valore predefinito [25].
    MailServerUseSSL = Utilizzare SSL per la connessione al server di posta? (y/N)
    MailCredentials = Richiesta autenticazione al server di posta? (y/N)
    MailFrom = Inserire l'indirizzo email del mittente
    MailTo = Inserire l'indirizzo email del destinatario
    EmptyEmail = L'indirizzo email non può essere vuoto. Inserire un indirizzo email valido.
    InvalidEmail = '{0}' non è un indirizzo email valido. Inserire un indirizzo email valido.
    AnotherRecipient = Si desidera inserire un altro destinatario? (y/N)
    MailBodyPrompt = Inserire il contenuto del corpo del messaggio email
    MailBody = As Built Report allegato
'@

# Report Configuration
ReportConfig = ConvertFrom-StringData @'
    BannerTitle = Configurazione As Built Report
    ReportConfigFolder = Inserire il percorso completo della cartella da utilizzare per l'archiviazione dei file di configurazione del modulo report e degli script di stile personalizzati [{0}]
    OverwriteReportConfig = Un file di configurazione del modulo report per {0} esiste già nella cartella specificata. Si desidera sovrascriverlo? (y/N)
    CopyFile = Copia di '{0}' in '{1}'.
    OverwriteFile = Copia di '{0}' in '{1}'. Sovrascrittura del file esistente.
    SaveAsBuiltConfig = Si desidera salvare il file di configurazione del modulo core di As Built Report? (Y/n)
    AsBuiltName = Inserire un nome per il file di configurazione As Built Report [AsBuiltReport]
    AsBuiltExportPath = Inserire il percorso per salvare il file di configurazione As Built Report [{0}]
    ConfigFolder = Creazione della cartella di configurazione As Built Report '{0}'.
    SaveConfig = Salvataggio del file di configurazione As Built Report '{0}.json' nel percorso '{1}'.
    NotSaved = File di configurazione As Built Report non salvato.
'@
}
