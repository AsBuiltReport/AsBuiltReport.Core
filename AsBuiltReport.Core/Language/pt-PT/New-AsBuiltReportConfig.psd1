# culture = 'pt-PT'
ConvertFrom-StringData @'
    FolderNotExist = A pasta '{0}' não existe. Crie a pasta e execute New-AsBuiltReportConfig novamente.
    ProcessConfig = A processar o ficheiro de configuração do relatório {0} do módulo {1}, versão {2}.
    CopyConfig = A copiar o ficheiro de configuração do relatório '{0}' para '{1}'.
    CopyModuleConfig = A copiar o ficheiro de configuração do relatório {0} '{1}' para '{2}'.
    CreateConfig = Ficheiro de configuração do relatório {0} '{1}.json' criado em '{2}'.
    OverWriteConfig = A copiar o ficheiro de configuração do relatório '{0}' para '{1}'. A substituir ficheiro existente.
    ForceOverwrite = O ficheiro de configuração do relatório {0} '{1}.json' já existe em '{2}'. Use '-Force' para substituir o ficheiro existente.
    ConfigNotFound = Ficheiro de configuração do relatório não encontrado no caminho do módulo '{0}'.
'@
