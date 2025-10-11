# culture = 'pt-PT'
@{

# As Built Report Information
ReportInfo = ConvertFrom-StringData @'
    BannerTitle = Informações do As Built Report
    ReportAuthor = Introduza o nome do autor para este As Built Report [{0}]
'@

# Company Configuration
CompanyConfig = ConvertFrom-StringData @'
    BannerTitle = Informações da Empresa
    CompanyInfo = Gostaria de introduzir informações da empresa para o As Built Report? (y/N)
    CompanyFullName = Introduza o Nome Completo da Empresa
    CompanyShortName = Introduza o Nome Abreviado da Empresa
    CompanyContact = Introduza o Contacto da Empresa
    CompanyEmail = Introduza o Endereço de Email da Empresa
    CompanyPhone = Introduza o Número de Telefone da Empresa
    CompanyAddress = Introduza o Endereço da Empresa
'@

# Email Configuration
EmailConfig = ConvertFrom-StringData @'
    BannerTitle = Configuração de Email
    ConfigureMailSettings = Gostaria de introduzir a configuração SMTP? (y/N)
    MailServer = Introduza o FQDN / endereço IP do servidor de email
    EmptyMailServerAddress = O endereço do servidor de email não pode estar vazio. Introduza um FQDN / endereço IP válido do servidor de email.
    InvalidMailServer = '{0}' não é um FQDN ou endereço IP válido. Introduza um FQDN / endereço IP válido do servidor de email.
    MailServerPort587 = Introduza o número de porta do servidor de email [587]
    InvalidMailServerPort587 = Número de porta inválido. Introduza um número entre 1 e 65535, ou pressione Enter para o padrão [587].
    MailServerPort25 = Introduza o número de porta do servidor de email [25]
    InvalidMailServerPort25 = Número de porta inválido. Introduza um número entre 1 e 65535, ou pressione Enter para o padrão [25].
    MailServerUseSSL = Usar SSL para a ligação ao servidor de email? (y/N)
    MailCredentials = Requer autenticação no servidor de email? (y/N)
    MailFrom = Introduza o endereço de email do remetente
    MailTo = Introduza o endereço de email do destinatário
    EmptyEmail = O endereço de email não pode estar vazio. Introduza um endereço de email válido.
    InvalidEmail = '{0}' não é um endereço de email válido. Introduza um endereço de email válido.
    AnotherRecipient = Deseja introduzir outro destinatário? (y/N)
    MailBodyPrompt = Introduza o conteúdo do corpo da mensagem de email
    MailBody = As Built Report anexado
'@

# Report Configuration
ReportConfig = ConvertFrom-StringData @'
    BannerTitle = Configuração do As Built Report
    ReportConfigFolder = Introduza o caminho completo da pasta para armazenar ficheiros de configuração do módulo de relatório e scripts de estilo personalizados [{0}]
    OverwriteReportConfig = Já existe um ficheiro de configuração do módulo de relatório para {0} na pasta especificada. Gostaria de o substituir? (y/N)
    CopyFile = A copiar '{0}' para '{1}'.
    OverwriteFile = A copiar '{0}' para '{1}'. A substituir ficheiro existente.
    SaveAsBuiltConfig = Gostaria de guardar o ficheiro de configuração do módulo core do As Built Report? (Y/n)
    AsBuiltName = Introduza um nome para o ficheiro de configuração do As Built Report [AsBuiltReport]
    AsBuiltExportPath = Introduza o caminho para guardar o ficheiro de configuração do As Built Report [{0}]
    ConfigFolder = A criar pasta de configuração do As Built Report '{0}'.
    SaveConfig = A guardar ficheiro de configuração do As Built Report '{0}.json' no caminho '{1}'.
    NotSaved = Ficheiro de configuração do As Built Report não guardado.
'@
}
