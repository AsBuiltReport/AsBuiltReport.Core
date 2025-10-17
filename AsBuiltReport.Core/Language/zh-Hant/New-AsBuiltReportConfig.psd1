# culture = 'zh-Hant'
ConvertFrom-StringData @'
    FolderNotExist = 資料夾 '{0}' 不存在。請建立該資料夾並再次執行 New-AsBuiltReportConfig。
    ProcessConfig = 正在處理模組 {1} 版本 {2} 的 {0} 報告設定檔案。
    CopyConfig = 正在將報告設定檔案 '{0}' 複製到 '{1}'。
    CopyModuleConfig = 正在將 {0} 報告設定檔案 '{1}' 複製到 '{2}'。
    CreateConfig = 已在 '{2}' 中建立 {0} 報告設定檔案 '{1}.json'。
    OverWriteConfig = 正在將報告設定檔案 '{0}' 複製到 '{1}'。正在覆寫現有檔案。
    ForceOverwrite = {0} 報告設定檔案 '{1}.json' 已存在於 '{2}' 中。使用 '-Force' 覆寫現有檔案。
    ConfigNotFound = 在模組路徑 '{0}' 中未找到報告設定檔案。
'@
