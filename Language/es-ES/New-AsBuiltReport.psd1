# culture = 'es-ES'
ConvertFrom-StringData @'
    PwshISE = AsBuiltReport no se puede ejecutar desde Windows PowerShell ISE. Utilice una ventana de comandos de PowerShell.
    Password = Contraseña para usuario {0}
    OutputFolderPath = OutputFolderPath '{0}' no es una ruta de carpeta válida.
    LoadConfig = Cargando configuración de informe según construcción desde {0}.
    NoConfigFound = No se pudo encontrar la configuración del Informe tal como fue construido en la ruta '{0}'.
    GeneratingReport = Generando nueva configuración de Informe As Built.
    StyleScriptNotFound = No se pudo encontrar el script de estilo de informe en la ruta '{0}'.
    ReportModuleNotFound = No se pudo encontrar el archivo de configuración del informe {0} en la ruta '{1}'.
    LoadingReportConfig = Cargando archivo de configuración de informe {0} desde la ruta '{1}'.
    ReportConfigNotFound = Configuración del informe no encontrada en la ruta del módulo '{0}'.
    SetReportFileName = Establecer el nombre del archivo de informe a '{0}'.
    EmailBannerTitle = Credenciales del servidor de correo electrónico
    EmailCredentials = Ingrese las credenciales para {0}.
    InstalledModule = AsBuiltReport.Core {0} está actualmente instalado.
    AvailableModule = AsBuiltReport.Core {0} está disponible.
    UpdateModule = Correr 'Update-Module -Name AsBuiltReport.Core -Force' para instalar la última versión.
    ReportGenerating = Espere mientras se genera el informe As Built {0}.
    ReportStyleScript = Ejecutando script de estilo de informe desde la ruta '{0}'.
    MfaEnabled = MFA está habilitado, verifique las ventanas de autenticación de MFA para generar su informe.
    OutputFolder = {0} As Built Report '{1}' se ha guardado en '{2}'.
'@