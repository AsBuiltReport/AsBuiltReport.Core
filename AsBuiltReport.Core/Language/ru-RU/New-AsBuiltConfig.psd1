# culture = 'ru-RU'
@{

# As Built Report Information
ReportInfo = ConvertFrom-StringData @'
    BannerTitle = Информация об As Built Report
    ReportAuthor = Введите имя автора этого As Built Report [{0}]
'@

# Company Configuration
CompanyConfig = ConvertFrom-StringData @'
    BannerTitle = Информация о компании
    CompanyInfo = Хотите ввести информацию о компании для As Built Report? (y/N)
    CompanyFullName = Введите полное название компании
    CompanyShortName = Введите краткое название компании
    CompanyContact = Введите контактное лицо компании
    CompanyEmail = Введите адрес электронной почты компании
    CompanyPhone = Введите номер телефона компании
    CompanyAddress = Введите адрес компании
'@

# Email Configuration
EmailConfig = ConvertFrom-StringData @'
    BannerTitle = Настройка электронной почты
    ConfigureMailSettings = Хотите ввести конфигурацию SMTP? (y/N)
    MailServer = Введите FQDN / IP-адрес почтового сервера
    EmptyMailServerAddress = Адрес почтового сервера не может быть пустым. Введите действительный FQDN / IP-адрес почтового сервера.
    InvalidMailServer = '{0}' не является действительным FQDN или IP-адресом. Введите действительный FQDN / IP-адрес почтового сервера.
    MailServerPort587 = Введите номер порта почтового сервера [587]
    InvalidMailServerPort587 = Неверный номер порта. Введите число от 1 до 65535 или нажмите Enter для значения по умолчанию [587].
    MailServerPort25 = Введите номер порта почтового сервера [25]
    InvalidMailServerPort25 = Неверный номер порта. Введите число от 1 до 65535 или нажмите Enter для значения по умолчанию [25].
    MailServerUseSSL = Использовать SSL для подключения к почтовому серверу? (y/N)
    MailCredentials = Требуется аутентификация на почтовом сервере? (y/N)
    MailFrom = Введите адрес электронной почты отправителя
    MailTo = Введите адрес электронной почты получателя
    EmptyEmail = Адрес электронной почты не может быть пустым. Введите действительный адрес электронной почты.
    InvalidEmail = '{0}' не является действительным адресом электронной почты. Введите действительный адрес электронной почты.
    AnotherRecipient = Хотите ввести другого получателя? (y/N)
    MailBodyPrompt = Введите содержимое тела электронного письма
    MailBody = As Built Report прикреплен
'@

# Report Configuration
ReportConfig = ConvertFrom-StringData @'
    BannerTitle = Конфигурация As Built Report
    ReportConfigFolder = Введите полный путь к папке для хранения файлов конфигурации модуля отчетов и пользовательских скриптов стилей [{0}]
    OverwriteReportConfig = Файл конфигурации модуля отчета для {0} уже существует в указанной папке. Хотите перезаписать его? (y/N)
    CopyFile = Копирование '{0}' в '{1}'.
    OverwriteFile = Копирование '{0}' в '{1}'. Перезапись существующего файла.
    SaveAsBuiltConfig = Хотите сохранить файл конфигурации основного модуля As Built Report? (Y/n)
    AsBuiltName = Введите имя для файла конфигурации As Built Report [AsBuiltReport]
    AsBuiltExportPath = Введите путь для сохранения файла конфигурации As Built Report [{0}]
    ConfigFolder = Создание папки конфигурации As Built Report '{0}'.
    SaveConfig = Сохранение файла конфигурации As Built Report '{0}.json' по пути '{1}'.
    NotSaved = Файл конфигурации As Built Report не сохранен.
'@
}
