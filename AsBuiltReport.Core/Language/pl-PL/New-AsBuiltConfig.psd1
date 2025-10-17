# culture = 'pl-PL'
@{

# As Built Report Information
ReportInfo = ConvertFrom-StringData @'
    BannerTitle = Informacje o As Built Report
    ReportAuthor = Wprowadź nazwisko autora tego raportu As Built Report [{0}]
'@

# Company Configuration
CompanyConfig = ConvertFrom-StringData @'
    BannerTitle = Informacje o firmie
    CompanyInfo = Czy chcesz wprowadzić informacje o firmie dla raportu As Built Report? (y/N)
    CompanyFullName = Wprowadź pełną nazwę firmy
    CompanyShortName = Wprowadź skróconą nazwę firmy
    CompanyContact = Wprowadź osobę kontaktową firmy
    CompanyEmail = Wprowadź adres e-mail firmy
    CompanyPhone = Wprowadź numer telefonu firmy
    CompanyAddress = Wprowadź adres firmy
'@

# Email Configuration
EmailConfig = ConvertFrom-StringData @'
    BannerTitle = Konfiguracja poczty e-mail
    ConfigureMailSettings = Czy chcesz wprowadzić konfigurację SMTP? (y/N)
    MailServer = Wprowadź FQDN / adres IP serwera pocztowego
    EmptyMailServerAddress = Adres serwera pocztowego nie może być pusty. Wprowadź prawidłowy FQDN / adres IP serwera pocztowego.
    InvalidMailServer = '{0}' nie jest prawidłowym FQDN lub adresem IP. Wprowadź prawidłowy FQDN / adres IP serwera pocztowego.
    MailServerPort587 = Wprowadź numer portu serwera pocztowego [587]
    InvalidMailServerPort587 = Nieprawidłowy numer portu. Wprowadź liczbę z zakresu od 1 do 65535 lub naciśnij Enter, aby użyć wartości domyślnej [587].
    MailServerPort25 = Wprowadź numer portu serwera pocztowego [25]
    InvalidMailServerPort25 = Nieprawidłowy numer portu. Wprowadź liczbę z zakresu od 1 do 65535 lub naciśnij Enter, aby użyć wartości domyślnej [25].
    MailServerUseSSL = Użyć SSL do połączenia z serwerem pocztowym? (y/N)
    MailCredentials = Wymagane uwierzytelnianie serwera pocztowego? (y/N)
    MailFrom = Wprowadź adres e-mail nadawcy
    MailTo = Wprowadź adres e-mail odbiorcy
    EmptyEmail = Adres e-mail nie może być pusty. Wprowadź prawidłowy adres e-mail.
    InvalidEmail = '{0}' nie jest prawidłowym adresem e-mail. Wprowadź prawidłowy adres e-mail.
    AnotherRecipient = Czy chcesz wprowadzić innego odbiorcę? (y/N)
    MailBodyPrompt = Wprowadź treść wiadomości e-mail
    MailBody = Raport As Built Report w załączniku
'@

# Report Configuration
ReportConfig = ConvertFrom-StringData @'
    BannerTitle = Konfiguracja As Built Report
    ReportConfigFolder = Wprowadź pełną ścieżkę folderu, który ma być używany do przechowywania plików konfiguracyjnych modułu raportów i niestandardowych skryptów stylu [{0}]
    OverwriteReportConfig = Plik konfiguracyjny modułu raportu dla {0} już istnieje w określonym folderze. Czy chcesz go nadpisać? (y/N)
    CopyFile = Kopiowanie '{0}' do '{1}'.
    OverwriteFile = Kopiowanie '{0}' do '{1}'. Nadpisywanie istniejącego pliku.
    SaveAsBuiltConfig = Czy chcesz zapisać plik konfiguracyjny modułu podstawowego As Built Report? (Y/n)
    AsBuiltName = Wprowadź nazwę pliku konfiguracyjnego As Built Report [AsBuiltReport]
    AsBuiltExportPath = Wprowadź ścieżkę do zapisania pliku konfiguracyjnego As Built Report [{0}]
    ConfigFolder = Tworzenie folderu konfiguracyjnego As Built Report '{0}'.
    SaveConfig = Zapisywanie pliku konfiguracyjnego As Built Report '{0}.json' w ścieżce '{1}'.
    NotSaved = Plik konfiguracyjny As Built Report nie został zapisany.
'@
}
