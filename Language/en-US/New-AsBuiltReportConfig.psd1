# culture = 'en-US'
ConvertFrom-StringData @'
    FolderNotExist = The folder '{0}' does not exist. Please create the folder and run New-AsBuiltReportConfig again.
    ProcessConfig = Processing {0} report configuration file from module {1}, version {2}.
    CopyConfig = Copying report configuration file '{0}' to '{1}'.
    CopyModuleConfig = Copying {0} report configuration file '{1}' to '{2}'.
    CreateConfig = {0} report configuration file '{1}.json' created in '{2}'.
    OverWriteConfig = Copying report configuration file '{0})' to '{1}'. Overwriting existing file.
    ForceOverwrite = {0} report configuration file '{1}.json' already exists in '{2}'. Use '-Force' to overwrite existing file.
    ConfigNotFound = Report configuration file not found in module path '{0}'.
'@