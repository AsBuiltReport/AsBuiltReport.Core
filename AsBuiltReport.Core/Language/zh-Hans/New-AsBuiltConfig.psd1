# culture = 'zh-Hans'
@{

# As Built Report Information
ReportInfo = ConvertFrom-StringData @'
    BannerTitle = As Built Report 信息
    ReportAuthor = 输入此 As Built Report 的作者姓名 [{0}]
'@

# Company Configuration
CompanyConfig = ConvertFrom-StringData @'
    BannerTitle = 公司信息
    CompanyInfo = 是否要为 As Built Report 输入公司信息？(y/N)
    CompanyFullName = 输入公司全称
    CompanyShortName = 输入公司简称
    CompanyContact = 输入公司联系人
    CompanyEmail = 输入公司电子邮件地址
    CompanyPhone = 输入公司电话号码
    CompanyAddress = 输入公司地址
'@

# Email Configuration
EmailConfig = ConvertFrom-StringData @'
    BannerTitle = 电子邮件配置
    ConfigureMailSettings = 是否要输入 SMTP 配置？(y/N)
    MailServer = 输入邮件服务器 FQDN / IP 地址
    EmptyMailServerAddress = 邮件服务器地址不能为空。请输入有效的邮件服务器 FQDN / IP 地址。
    InvalidMailServer = '{0}' 不是有效的 FQDN 或 IP 地址。请输入有效的邮件服务器 FQDN / IP 地址。
    MailServerPort587 = 输入邮件服务器端口号 [587]
    InvalidMailServerPort587 = 端口号无效。请输入 1 到 65535 之间的数字，或按 Enter 键使用默认值 [587]。
    MailServerPort25 = 输入邮件服务器端口号 [25]
    InvalidMailServerPort25 = 端口号无效。请输入 1 到 65535 之间的数字，或按 Enter 键使用默认值 [25]。
    MailServerUseSSL = 是否使用 SSL 连接邮件服务器？(y/N)
    MailCredentials = 是否需要邮件服务器身份验证？(y/N)
    MailFrom = 输入发件人电子邮件地址
    MailTo = 输入收件人电子邮件地址
    EmptyEmail = 电子邮件地址不能为空。请输入有效的电子邮件地址。
    InvalidEmail = '{0}' 不是有效的电子邮件地址。请输入有效的电子邮件地址。
    AnotherRecipient = 是否要输入其他收件人？(y/N)
    MailBodyPrompt = 输入电子邮件正文内容
    MailBody = 已附加 As Built Report
'@

# Report Configuration
ReportConfig = ConvertFrom-StringData @'
    BannerTitle = As Built Report 配置
    ReportConfigFolder = 输入用于存储报告模块配置文件和自定义样式脚本的文件夹完整路径 [{0}]
    OverwriteReportConfig = 指定文件夹中已存在 {0} 的报告模块配置文件。是否要覆盖它？(y/N)
    CopyFile = 正在将 '{0}' 复制到 '{1}'。
    OverwriteFile = 正在将 '{0}' 复制到 '{1}'。正在覆盖现有文件。
    SaveAsBuiltConfig = 是否要保存 As Built Report 核心模块配置文件？(Y/n)
    AsBuiltName = 输入 As Built Report 配置文件的名称 [AsBuiltReport]
    AsBuiltExportPath = 输入保存 As Built Report 配置文件的路径 [{0}]
    ConfigFolder = 正在创建 As Built Report 配置文件夹 '{0}'。
    SaveConfig = 正在将 As Built Report 配置文件 '{0}.json' 保存到路径 '{1}'。
    NotSaved = As Built Report 配置文件未保存。
'@
}
