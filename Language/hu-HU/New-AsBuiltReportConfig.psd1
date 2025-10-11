# culture = 'hu-HU'
ConvertFrom-StringData @'
    FolderNotExist = A(z) '{0}' mappa nem létezik. Kérjük, hozza létre a mappát és futtassa újra a New-AsBuiltReportConfig parancsot.
    ProcessConfig = {0} jelentés konfigurációs fájl feldolgozása a(z) {1} modulból, {2} verzió.
    CopyConfig = Jelentés konfigurációs fájl '{0}' másolása ide: '{1}'.
    CopyModuleConfig = {0} jelentés konfigurációs fájl '{1}' másolása ide: '{2}'.
    CreateConfig = {0} jelentés konfigurációs fájl '{1}.json' létrehozva itt: '{2}'.
    OverWriteConfig = Jelentés konfigurációs fájl '{0}' másolása ide: '{1}'. Meglévő fájl felülírása.
    ForceOverwrite = A(z) {0} jelentés konfigurációs fájl '{1}.json' már létezik itt: '{2}'. Használja a '-Force' paramétert a meglévő fájl felülírásához.
    ConfigNotFound = Jelentés konfigurációs fájl nem található a(z) '{0}' modul elérési útjában.
'@
