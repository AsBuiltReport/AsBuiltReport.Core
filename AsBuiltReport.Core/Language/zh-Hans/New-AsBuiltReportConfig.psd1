# culture = 'zh-Hans'
ConvertFrom-StringData @'
    FolderNotExist = 文件夹 '{0}' 不存在。请创建该文件夹并再次运行 New-AsBuiltReportConfig。
    ProcessConfig = 正在处理模块 {1} 版本 {2} 的 {0} 报告配置文件。
    CopyConfig = 正在将报告配置文件 '{0}' 复制到 '{1}'。
    CopyModuleConfig = 正在将 {0} 报告配置文件 '{1}' 复制到 '{2}'。
    CreateConfig = 已在 '{2}' 中创建 {0} 报告配置文件 '{1}.json'。
    OverWriteConfig = 正在将报告配置文件 '{0}' 复制到 '{1}'。正在覆盖现有文件。
    ForceOverwrite = {0} 报告配置文件 '{1}.json' 已存在于 '{2}' 中。使用 '-Force' 覆盖现有文件。
    ConfigNotFound = 在模块路径 '{0}' 中未找到报告配置文件。
'@
