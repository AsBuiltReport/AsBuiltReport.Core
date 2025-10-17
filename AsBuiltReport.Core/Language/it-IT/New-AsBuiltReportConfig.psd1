# culture = 'it-IT'
ConvertFrom-StringData @'
    FolderNotExist = La cartella '{0}' non esiste. Creare la cartella ed eseguire nuovamente New-AsBuiltReportConfig.
    ProcessConfig = Elaborazione del file di configurazione del report {0} dal modulo {1}, versione {2}.
    CopyConfig = Copia del file di configurazione del report '{0}' in '{1}'.
    CopyModuleConfig = Copia del file di configurazione del report {0} '{1}' in '{2}'.
    CreateConfig = File di configurazione del report {0} '{1}.json' creato in '{2}'.
    OverWriteConfig = Copia del file di configurazione del report '{0}' in '{1}'. Sovrascrittura del file esistente.
    ForceOverwrite = Il file di configurazione del report {0} '{1}.json' esiste già in '{2}'. Utilizzare '-Force' per sovrascrivere il file esistente.
    ConfigNotFound = File di configurazione del report non trovato nel percorso del modulo '{0}'.
'@
