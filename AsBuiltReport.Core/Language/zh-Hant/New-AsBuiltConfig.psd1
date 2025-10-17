# culture = 'zh-Hant'
@{

# As Built Report Information
ReportInfo = ConvertFrom-StringData @'
    BannerTitle = As Built Report 資訊
    ReportAuthor = 輸入此 As Built Report 的作者姓名 [{0}]
'@

# Company Configuration
CompanyConfig = ConvertFrom-StringData @'
    BannerTitle = 公司資訊
    CompanyInfo = 是否要為 As Built Report 輸入公司資訊？(y/N)
    CompanyFullName = 輸入公司全稱
    CompanyShortName = 輸入公司簡稱
    CompanyContact = 輸入公司聯絡人
    CompanyEmail = 輸入公司電子郵件地址
    CompanyPhone = 輸入公司電話號碼
    CompanyAddress = 輸入公司地址
'@

# Email Configuration
EmailConfig = ConvertFrom-StringData @'
    BannerTitle = 電子郵件設定
    ConfigureMailSettings = 是否要輸入 SMTP 設定？(y/N)
    MailServer = 輸入郵件伺服器 FQDN / IP 地址
    EmptyMailServerAddress = 郵件伺服器地址不能為空。請輸入有效的郵件伺服器 FQDN / IP 地址。
    InvalidMailServer = '{0}' 不是有效的 FQDN 或 IP 地址。請輸入有效的郵件伺服器 FQDN / IP 地址。
    MailServerPort587 = 輸入郵件伺服器連接埠號 [587]
    InvalidMailServerPort587 = 連接埠號無效。請輸入 1 到 65535 之間的數字，或按 Enter 鍵使用預設值 [587]。
    MailServerPort25 = 輸入郵件伺服器連接埠號 [25]
    InvalidMailServerPort25 = 連接埠號無效。請輸入 1 到 65535 之間的數字，或按 Enter 鍵使用預設值 [25]。
    MailServerUseSSL = 是否使用 SSL 連接郵件伺服器？(y/N)
    MailCredentials = 是否需要郵件伺服器身份驗證？(y/N)
    MailFrom = 輸入寄件人電子郵件地址
    MailTo = 輸入收件人電子郵件地址
    EmptyEmail = 電子郵件地址不能為空。請輸入有效的電子郵件地址。
    InvalidEmail = '{0}' 不是有效的電子郵件地址。請輸入有效的電子郵件地址。
    AnotherRecipient = 是否要輸入其他收件人？(y/N)
    MailBodyPrompt = 輸入電子郵件正文內容
    MailBody = 已附加 As Built Report
'@

# Report Configuration
ReportConfig = ConvertFrom-StringData @'
    BannerTitle = As Built Report 設定
    ReportConfigFolder = 輸入用於儲存報告模組設定檔案和自訂樣式指令碼的資料夾完整路徑 [{0}]
    OverwriteReportConfig = 指定資料夾中已存在 {0} 的報告模組設定檔案。是否要覆寫它？(y/N)
    CopyFile = 正在將 '{0}' 複製到 '{1}'。
    OverwriteFile = 正在將 '{0}' 複製到 '{1}'。正在覆寫現有檔案。
    SaveAsBuiltConfig = 是否要儲存 As Built Report 核心模組設定檔案？(Y/n)
    AsBuiltName = 輸入 As Built Report 設定檔案的名稱 [AsBuiltReport]
    AsBuiltExportPath = 輸入儲存 As Built Report 設定檔案的路徑 [{0}]
    ConfigFolder = 正在建立 As Built Report 設定資料夾 '{0}'。
    SaveConfig = 正在將 As Built Report 設定檔案 '{0}.json' 儲存到路徑 '{1}'。
    NotSaved = As Built Report 設定檔案未儲存。
'@
}
