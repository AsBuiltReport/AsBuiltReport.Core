# culture = 'fr-FR'
ConvertFrom-StringData @'
    PwshISE = AsBuiltReport ne peut pas être exécuté depuis Windows PowerShell ISE. Veuillez utiliser une fenêtre de commande PowerShell.
    Password = Mot de passe pour l'utilisateur {0}
    OutputFolderPath = OutputFolderPath '{0}' n'est pas un chemin de dossier valide.
    LoadConfig = Chargement de la configuration du rapport tel que construit à partir de {0}.
    NoConfigFound = Impossible de trouver la configuration du rapport tel que construit dans le chemin {0}.
    GeneratingReport = Génération d'une nouvelle configuration de rapport tel que construit.
    StyleScriptNotFound = Impossible de trouver le script de style de rapport dans le chemin {0}.
    ReportModuleNotFound = Impossible de trouver le fichier de configuration du rapport {0} dans le chemin {1}.
    LoadingReportConfig = Chargement du fichier de configuration du rapport {0} à partir du chemin {1}.
    ReportConfigNotFound = La configuration du rapport n'a pas été trouvée dans le chemin du module '{0}'.
    SetReportFileName = Définition du nom du fichier de rapport sur {0}.
    EmailBannerTitle = Informations d'identification du serveur de messagerie
    EmailCredentials = Veuillez saisir les informations d'identification pour {0}.
    InstalledModule = AsBuiltReport.Core {0} est actuellement installé.
    AvailableModule = AsBuiltReport.Core {0} est disponible.
    UpdateModule = Exécutez 'Update-Module -Name AsBuiltReport.Core -Force' pour installer la dernière version.
    ReportGenerating = Veuillez patienter pendant que le rapport {0} tel que construit est en cours de génération.
    ReportStyleScript = Exécution du script de style de rapport à partir du chemin {0}.
    MfaEnabled = MFA est activé, veuillez vérifier les fenêtres d'authentification MFA pour générer votre rapport.
    OutputFolder = {0} Le rapport tel que construit {1} a été enregistré dans {2}.
'@