# culture = 'pl-PL'
ConvertFrom-StringData @'
    FolderNotExist = Folder '{0}' nie istnieje. Proszę utworzyć folder i uruchomić New-AsBuiltReportConfig ponownie.
    ProcessConfig = Przetwarzanie pliku konfiguracyjnego raportu {0} z modułu {1}, wersja {2}.
    CopyConfig = Kopiowanie pliku konfiguracyjnego raportu '{0}' do '{1}'.
    CopyModuleConfig = Kopiowanie pliku konfiguracyjnego raportu {0} '{1}' do '{2}'.
    CreateConfig = Plik konfiguracyjny raportu {0} '{1}.json' utworzony w '{2}'.
    OverWriteConfig = Kopiowanie pliku konfiguracyjnego raportu '{0}' do '{1}'. Nadpisywanie istniejącego pliku.
    ForceOverwrite = Plik konfiguracyjny raportu {0} '{1}.json' już istnieje w '{2}'. Użyj '-Force', aby nadpisać istniejący plik.
    ConfigNotFound = Nie znaleziono pliku konfiguracyjnego raportu w ścieżce modułu '{0}'.
'@
