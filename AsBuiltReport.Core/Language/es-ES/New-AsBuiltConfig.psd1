# culture = 'es-ES'
@{

# Información del Informe As Built
ReportInfo = ConvertFrom-StringData @'
    BannerTitle = Información del Informe As Built
    ReportAuthor = Ingrese el nombre del autor para este Informe As Built [{0}]
'@

# Configuración de la Empresa
CompanyConfig = ConvertFrom-StringData @'
    BannerTitle = Información de la Empresa
    CompanyInfo = ¿Desea ingresar información de la empresa para el Informe Según Construcción? (y/N)
    CompanyFullName = Ingrese el Nombre Completo de la Empresa
    CompanyShortName = Ingrese el Nombre Corto de la Empresa
    CompanyContact = Ingrese el Contacto de la Empresa
    CompanyEmail = Ingrese la Dirección de Correo Electrónico de la Empresa
    CompanyPhone = Ingrese el Número de Teléfono de la Empresa
    CompanyAddress = Ingrese la Dirección de la Empresa
'@

# Configuración de Correo Electrónico
EmailConfig = ConvertFrom-StringData @'
    BannerTitle = Configuración de Correo Electrónico
    ConfigureMailSettings = ¿Le gustaría ingresar la configuración SMTP? (y/N)
    MailServer = Ingrese el FQDN / dirección IP del servidor de correo
    EmptyMailServerAddress = La dirección del servidor de correo no puede estar vacía. Por favor ingrese un FQDN / dirección IP válida del servidor de correo.
    InvalidMailServer = '{0}' no es un FQDN o dirección IP válida. Por favor ingrese un FQDN / dirección IP válida del servidor de correo.
    MailServerPort587 = Ingrese el número de puerto del servidor de correo [587]
    InvalidMailServerPort587 = Número de puerto inválido. Por favor ingrese un número entre 1 y 65535, o presione Enter para el valor predeterminado [587].
    MailServerPort25 = Ingrese el número de puerto del servidor de correo [25]
    InvalidMailServerPort25 = Número de puerto inválido. Por favor ingrese un número entre 1 y 65535, o presione Enter para el valor predeterminado [25].
    MailServerUseSSL = ¿Se requiere autenticación del servidor de correo? (y/N)
    MailCredentials = ¿Requiere autenticación del servidor de correo? (y/N)
    MailFrom = Ingrese la dirección de correo electrónico del remitente
    MailTo = Introduzca la dirección de correo electrónico del destinatario del servidor de correo
    EmptyEmail = La dirección de correo electrónico no puede estar vacía. Por favor ingrese una dirección de correo electrónico válida.
    InvalidEmail = '{0}' no es una dirección de correo electrónico válida. Por favor ingrese una dirección de correo electrónico válida.
    AnotherRecipient = ¿Quieres introducir otro destinatario? (y/N)
    MailBodyPrompt = Ingrese el contenido del cuerpo del mensaje de correo electrónico
    MailBody = Informe As Built adjunto
'@

# Configuración del Informe
ReportConfig = ConvertFrom-StringData @'
    BannerTitle = Configuración del Informe Según Construcción
    ReportConfigFolder = Ingrese la ruta completa de la carpeta a usar para almacenar archivos de configuración del módulo de informe y scripts de estilo personalizados [{0}]
    OverwriteReportConfig = Ya existe un archivo de configuración del módulo de informe para {0} en la carpeta especificada. ¿Le gustaría sobrescribirlo? (y/N)
    CopyFile = Copiando '{0}' a '{1}'.
    OverwriteFile = Copiando '{0}' a '{1}'. Sobrescribiendo archivo existente.
    SaveAsBuiltConfig = ¿Le gustaría guardar el archivo de configuración del módulo principal del Informe As Built? (Y/n)
    AsBuiltName = Ingrese un nombre para el archivo de configuración del Informe As Built [AsBuiltReport]
    AsBuiltExportPath = Ingrese la ruta para guardar el archivo de configuración del Informe As Built [{0}]
    ConfigFolder = Creando carpeta de configuración del Informe As Built '{0}'.
    SaveConfig = Guardando archivo de configuración del Informe As Built '{0}.json' en la ruta '{1}'.
    NotSaved = Archivo de configuración del Informe As Built no guardado.
'@
}