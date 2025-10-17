# culture = 'ja-JP'
ConvertFrom-StringData @'
    FolderNotExist = フォルダ '{0}' は存在しません。フォルダを作成して、New-AsBuiltReportConfig を再度実行してください。
    ProcessConfig = モジュール {1} バージョン {2} から {0} レポート設定ファイルを処理しています。
    CopyConfig = レポート設定ファイル '{0}' を '{1}' にコピーしています。
    CopyModuleConfig = {0} レポート設定ファイル '{1}' を '{2}' にコピーしています。
    CreateConfig = {0} レポート設定ファイル '{1}.json' が '{2}' に作成されました。
    OverWriteConfig = レポート設定ファイル '{0}' を '{1}' にコピーしています。既存のファイルを上書きします。
    ForceOverwrite = {0} レポート設定ファイル '{1}.json' は既に '{2}' に存在します。既存のファイルを上書きするには '-Force' を使用してください。
    ConfigNotFound = モジュールパス '{0}' にレポート設定ファイルが見つかりません。
'@
