# culture = 'nb-NO'
ConvertFrom-StringData @'
    FolderNotExist = Mappen '{0}' finnes ikke. Vennligst opprett mappen og kjør New-AsBuiltReportConfig på nytt.
    ProcessConfig = Behandler {0} rapportkonfigurasjonsfil fra modul {1}, versjon {2}.
    CopyConfig = Kopierer rapportkonfigurasjonsfil '{0}' til '{1}'.
    CopyModuleConfig = Kopierer {0} rapportkonfigurasjonsfil '{1}' til '{2}'.
    CreateConfig = {0} rapportkonfigurasjonsfil '{1}.json' opprettet i '{2}'.
    OverWriteConfig = Kopierer rapportkonfigurasjonsfil '{0}' til '{1}'. Overskriver eksisterende fil.
    ForceOverwrite = {0} rapportkonfigurasjonsfil '{1}.json' finnes allerede i '{2}'. Bruk '-Force' for å overskrive eksisterende fil.
    ConfigNotFound = Rapportkonfigurasjonsfil ikke funnet i modulbanen '{0}'.
'@
