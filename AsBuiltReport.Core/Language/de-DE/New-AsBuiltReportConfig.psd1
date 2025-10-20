# culture = 'de-DE'
ConvertFrom-StringData @'
    FolderNotExist = Der Ordner '{0}' existiert nicht. Bitte erstellen Sie den Ordner und führen Sie New-AsBuiltReportConfig erneut aus.
    ProcessConfig = Verarbeite {0} Berichtskonfigurationsdatei aus Modul {1}, Version {2}.
    CopyConfig = Kopiere Berichtskonfigurationsdatei '{0}' nach '{1}'.
    CopyModuleConfig = Kopiere {0} Berichtskonfigurationsdatei '{1}' nach '{2}'.
    CreateConfig = {0} Berichtskonfigurationsdatei '{1}.json' wurde in '{2}' erstellt.
    OverWriteConfig = Kopiere Berichtskonfigurationsdatei '{0}' nach '{1}'. Vorhandene Datei wird überschrieben.
    ForceOverwrite = {0} Berichtskonfigurationsdatei '{1}.json' existiert bereits in '{2}'. Verwenden Sie '-Force', um die vorhandene Datei zu überschreiben.
    ConfigNotFound = Berichtskonfigurationsdatei nicht im Modulpfad '{0}' gefunden.
'@
