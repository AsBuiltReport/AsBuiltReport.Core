# culture = 'da-DK'
ConvertFrom-StringData @'
    FolderNotExist = Mappen '{0}' findes ikke. Opret venligst mappen og kør New-AsBuiltReportConfig igen.
    ProcessConfig = Behandler {0} rapportkonfigurationsfil fra modul {1}, version {2}.
    CopyConfig = Kopierer rapportkonfigurationsfil '{0}' til '{1}'.
    CopyModuleConfig = Kopierer {0} rapportkonfigurationsfil '{1}' til '{2}'.
    CreateConfig = {0} rapportkonfigurationsfil '{1}.json' oprettet i '{2}'.
    OverWriteConfig = Kopierer rapportkonfigurationsfil '{0}' til '{1}'. Overskriver eksisterende fil.
    ForceOverwrite = {0} rapportkonfigurationsfil '{1}.json' findes allerede i '{2}'. Brug '-Force' til at overskrive eksisterende fil.
    ConfigNotFound = Rapportkonfigurationsfil ikke fundet i modulsti '{0}'.
'@
