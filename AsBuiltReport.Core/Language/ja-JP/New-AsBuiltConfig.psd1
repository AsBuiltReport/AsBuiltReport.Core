# culture = 'ja-JP'
@{

# As Built Report Information
ReportInfo = ConvertFrom-StringData @'
    BannerTitle = As Built Report 情報
    ReportAuthor = この As Built Report の作成者名を入力してください [{0}]
'@

# Company Configuration
CompanyConfig = ConvertFrom-StringData @'
    BannerTitle = 会社情報
    CompanyInfo = As Built Report の会社情報を入力しますか? (y/N)
    CompanyFullName = 会社の正式名称を入力してください
    CompanyShortName = 会社の略称を入力してください
    CompanyContact = 会社の連絡先を入力してください
    CompanyEmail = 会社のメールアドレスを入力してください
    CompanyPhone = 会社の電話番号を入力してください
    CompanyAddress = 会社の住所を入力してください
'@

# Email Configuration
EmailConfig = ConvertFrom-StringData @'
    BannerTitle = メール設定
    ConfigureMailSettings = SMTP設定を入力しますか? (y/N)
    MailServer = メールサーバーのFQDN / IPアドレスを入力してください
    EmptyMailServerAddress = メールサーバーのアドレスは空にできません。有効なメールサーバーのFQDN / IPアドレスを入力してください。
    InvalidMailServer = '{0}' は有効なFQDNまたはIPアドレスではありません。有効なメールサーバーのFQDN / IPアドレスを入力してください。
    MailServerPort587 = メールサーバーのポート番号を入力してください [587]
    InvalidMailServerPort587 = 無効なポート番号です。1から65535の間の数値を入力するか、デフォルト [587] の場合はEnterキーを押してください。
    MailServerPort25 = メールサーバーのポート番号を入力してください [25]
    InvalidMailServerPort25 = 無効なポート番号です。1から65535の間の数値を入力するか、デフォルト [25] の場合はEnterキーを押してください。
    MailServerUseSSL = メールサーバー接続にSSLを使用しますか? (y/N)
    MailCredentials = メールサーバーの認証が必要ですか? (y/N)
    MailFrom = 送信者のメールアドレスを入力してください
    MailTo = 受信者のメールアドレスを入力してください
    EmptyEmail = メールアドレスは空にできません。有効なメールアドレスを入力してください。
    InvalidEmail = '{0}' は有効なメールアドレスではありません。有効なメールアドレスを入力してください。
    AnotherRecipient = 別の受信者を入力しますか? (y/N)
    MailBodyPrompt = メールメッセージの本文内容を入力してください
    MailBody = As Built Report を添付
'@

# Report Configuration
ReportConfig = ConvertFrom-StringData @'
    BannerTitle = As Built Report 設定
    ReportConfigFolder = レポートモジュール設定ファイルとカスタムスタイルスクリプトを保存するフォルダの完全パスを入力してください [{0}]
    OverwriteReportConfig = 指定されたフォルダに {0} のレポートモジュール設定ファイルが既に存在します。上書きしますか? (y/N)
    CopyFile = '{0}' を '{1}' にコピーしています。
    OverwriteFile = '{0}' を '{1}' にコピーしています。既存のファイルを上書きします。
    SaveAsBuiltConfig = As Built Report コアモジュール設定ファイルを保存しますか? (Y/n)
    AsBuiltName = As Built Report 設定ファイルの名前を入力してください [AsBuiltReport]
    AsBuiltExportPath = As Built Report 設定ファイルを保存するパスを入力してください [{0}]
    ConfigFolder = As Built Report 設定フォルダ '{0}' を作成しています。
    SaveConfig = As Built Report 設定ファイル '{0}.json' をパス '{1}' に保存しています。
    NotSaved = As Built Report 設定ファイルは保存されませんでした。
'@
}
