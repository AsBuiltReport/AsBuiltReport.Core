# culture = 'fr-FR'
ConvertFrom-StringData @'
    FolderNotExist = Le dossier {0} n'existe pas. Veuillez le créer et réexécuter New-AsBuiltReportConfig.
    ProcessConfig = Traitement du fichier de configuration du rapport {0} du module {1}, version {2}.
    CopyConfig = Copie du fichier de configuration du rapport '{0}' vers '{1}'.
    CopyModuleConfig = Copie du fichier de configuration du rapport {0} '{1}' vers '{2}'.
    CreateConfig = {0} fichier de configuration du rapport '{1}.json' créé dans '{2}'.
    OverWriteConfig = Copie du fichier de configuration du rapport {0} vers {1}. Écrasement du fichier existant.
    ForceOverwrite = Le fichier de configuration du rapport {0} '{1}.json' existe déjà dans '{2}'. Utilisez '-Force' pour écraser le fichier existant.
    ConfigNotFound = Le fichier de configuration du rapport n'a pas été trouvé dans le chemin du module '{0}'.
'@