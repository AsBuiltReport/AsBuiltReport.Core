# culture = 'nl-NL'
ConvertFrom-StringData @'
    FolderNotExist = De map '{0}' bestaat niet. Maak de map aan en voer New-AsBuiltReportConfig opnieuw uit.
    ProcessConfig = Verwerken van {0} rapportconfiguratiebestand van module {1}, versie {2}.
    CopyConfig = Kopiëren van rapportconfiguratiebestand '{0}' naar '{1}'.
    CopyModuleConfig = Kopiëren van {0} rapportconfiguratiebestand '{1}' naar '{2}'.
    CreateConfig = {0} rapportconfiguratiebestand '{1}.json' aangemaakt in '{2}'.
    OverWriteConfig = Kopiëren van rapportconfiguratiebestand '{0}' naar '{1}'. Bestaand bestand wordt overschreven.
    ForceOverwrite = {0} rapportconfiguratiebestand '{1}.json' bestaat al in '{2}'. Gebruik '-Force' om het bestaande bestand te overschrijven.
    ConfigNotFound = Rapportconfiguratiebestand niet gevonden in modulepad '{0}'.
'@
