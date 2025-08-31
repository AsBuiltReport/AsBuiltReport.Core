# culture = 'fr-FR'
@{

# Informations sur le rapport tel que construit
ReportInfo = ConvertFrom-StringData @'
    BannerTitle = Informations sur le rapport tel que construit
    ReportAuthor = Saisissez le nom de l'auteur de ce rapport tel que construit [{0}]
'@

# Configuration de l'entreprise
CompanyConfig = ConvertFrom-StringData @'
    BannerTitle = Information de l'entreprise
    CompanyInfo = Souhaitez-vous saisir les informations de l'entreprise pour le rapport As Built ? (y/n)
    CompanyFullName = Entrez le nom complet de l'entreprise
    CompanyShortName = Entrez le nom abrégé de l'entreprise
    CompanyContact = Entrez le contact de l'entreprise
    CompanyEmail = Entrez l'adresse e-mail de l'entreprise
    CompanyPhone = Entrez le numéro de téléphone de l'entreprise
    CompanyAddress = Entrez l'adresse de l'entreprise
'@

# Configuration de la messagerie électronique
EmailConfig = ConvertFrom-StringData @'
    BannerTitle = Configuration de la messagerie électronique
    ConfigureMailSettings = Souhaitez-vous entrer dans la configuration SMTP ? (y/n)
    MailServer = Entrez le FQDN / l'adresse IP du serveur de messagerie
    EmptyMailServerAddress = L'adresse du serveur de messagerie ne peut pas être vide. Veuillez saisir un nom de domaine complet (FQDN) ou une adresse IP valide.
    InvalidMailServer = {0} n'est pas un nom de domaine complet (FQDN) ni une adresse IP valides. Veuillez saisir un nom de domaine complet (FQDN) ou une adresse IP de serveur de messagerie valides.
    MailServerPort587 = Entrez le numéro de port du serveur de messagerie [587]
    InvalidMailServerPort587 = Numéro de port non valide. Veuillez saisir un numéro compris entre 1 et 65535, ou appuyez sur Entrée pour la valeur par défaut. [587].
    MailServerPort25 = Entrez le numéro de port du serveur de messagerie [25]
    InvalidMailServerPort25 = Numéro de port non valide. Veuillez saisir un numéro compris entre 1 et 65535, ou appuyez sur Entrée pour la valeur par défaut. [25].
    MailServerUseSSL = Utiliser SSL pour la connexion au serveur de messagerie? (y/n)
    MailCredentials = Exiger une authentification du serveur de messagerie? (y/n)
    MailFrom = Saisissez l'adresse e-mail de l'expéditeur du courrier
    MailTo = Saisissez l'adresse e-mail du destinataire du serveur de messagerie
    EmptyEmail = L'adresse e-mail ne peut pas être vide. Veuillez saisir une adresse e-mail valide.
    InvalidEmail = '{0}' n'est pas une adresse e-mail valide. Veuillez saisir une adresse e-mail valide.
    AnotherRecipient = Voulez-vous saisir un autre destinataire? (y/n)
    MailBodyPrompt = Saisissez le contenu du corps du message électronique
    MailBody = Rapport de construction ci-joint
'@

# Configuration du rapport
ReportConfig = ConvertFrom-StringData @'
    BannerTitle = Configuration du rapport tel que construit
    ReportConfigFolder = Saisissez le chemin complet du dossier à utiliser pour stocker les fichiers de configuration de rapport et les scripts de style personnalisés [{0}]
    OverwriteReportConfig = Un fichier de configuration de rapport existe déjà dans le dossier spécifié pour {0}. Souhaitez-vous le remplacer? (y/n)
    CopyFile = Copie de '{0}' vers '{1}'.
    OverwriteFile = Copie de {0} vers {1}. Écrasement du fichier existant.
    SaveAsBuiltConfig = Souhaitez-vous enregistrer le fichier de configuration du rapport As Built ? (y/n)
    AsBuiltName = Entrez un nom pour le fichier de configuration du rapport As Built [AsBuiltReport]
    AsBuiltExportPath = Entrez le chemin pour enregistrer le fichier de configuration du rapport As Built [{0}]
    ConfigFolder = Création d'un dossier de configuration de rapport tel que construit '{0}'.
    SaveConfig = Enregistrement du fichier de configuration du rapport tel que construit {0}.json dans le chemin {1}.
    NotSaved = Le fichier de configuration du rapport tel que construit n'est pas enregistré.
'@
}