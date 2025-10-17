# culture = 'es-ES'
ConvertFrom-StringData @'
    FolderNotExist = La carpeta '{0}' no existe. Créela y ejecútela New-AsBuiltReportConfig de nuevo.
    ProcessConfig = Procesando archivo de configuración de informe {0} del módulo {1}, versión {2}.
    CopyConfig = Copiando el archivo de configuración del informe '{0}' a '{1}'.
    CopyModuleConfig = Copiando {0} archivo de configuración de informe '{1}' a '{2}'.
    CreateConfig = {0} Archivo de configuración de informe '{1}.json' creado en '{2}'.
    OverWriteConfig = Copiando el archivo de configuración del informe '{0})' a '{1}'. Sobrescribiendo el archivo existente.
    ForceOverwrite = El archivo de configuración del informe {0} '{1}.json' ya existe en '{2}'. Use '-Force' para sobrescribir el archivo existente.
    ConfigNotFound = Archivo de configuración del informe no encontrado en la ruta del módulo '{0}'.
'@