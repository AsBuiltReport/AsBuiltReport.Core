# culture = 'sv-SE'
ConvertFrom-StringData @'
    FolderNotExist = Mappen '{0}' finns inte. Skapa mappen och kör New-AsBuiltReportConfig igen.
    ProcessConfig = Bearbetar {0} rapportkonfigurationsfil från modul {1}, version {2}.
    CopyConfig = Kopierar rapportkonfigurationsfil '{0}' till '{1}'.
    CopyModuleConfig = Kopierar {0} rapportkonfigurationsfil '{1}' till '{2}'.
    CreateConfig = {0} rapportkonfigurationsfil '{1}.json' skapad i '{2}'.
    OverWriteConfig = Kopierar rapportkonfigurationsfil '{0}' till '{1}'. Skriver över befintlig fil.
    ForceOverwrite = {0} rapportkonfigurationsfil '{1}.json' finns redan i '{2}'. Använd '-Force' för att skriva över befintlig fil.
    ConfigNotFound = Rapportkonfigurationsfil hittades inte i modulsökväg '{0}'.
'@
