# culture = 'fi-FI'
ConvertFrom-StringData @'
    FolderNotExist = Kansiota '{0}' ei ole olemassa. Luo kansio ja suorita New-AsBuiltReportConfig uudelleen.
    ProcessConfig = Käsitellään {0} raportin määritystiedostoa moduulista {1}, versio {2}.
    CopyConfig = Kopioidaan raportin määritystiedosto '{0}' kohteeseen '{1}'.
    CopyModuleConfig = Kopioidaan {0} raportin määritystiedosto '{1}' kohteeseen '{2}'.
    CreateConfig = {0} raportin määritystiedosto '{1}.json' luotu kohteeseen '{2}'.
    OverWriteConfig = Kopioidaan raportin määritystiedosto '{0}' kohteeseen '{1}'. Korvataan olemassa oleva tiedosto.
    ForceOverwrite = {0} raportin määritystiedosto '{1}.json' on jo olemassa kohteessa '{2}'. Käytä '-Force' korvataksesi olemassa oleva tiedosto.
    ConfigNotFound = Raportin määritystiedostoa ei löytynyt moduulipolusta '{0}'.
'@
