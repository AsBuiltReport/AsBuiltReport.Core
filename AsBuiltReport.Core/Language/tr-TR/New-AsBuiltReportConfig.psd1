# culture = 'tr-TR'
ConvertFrom-StringData @'
    FolderNotExist = '{0}' klasörü mevcut değil. Lütfen klasörü oluşturun ve New-AsBuiltReportConfig'i tekrar çalıştırın.
    ProcessConfig = {1} modülünden, sürüm {2}, {0} rapor yapılandırma dosyası işleniyor.
    CopyConfig = Rapor yapılandırma dosyası '{0}' konumuna '{1}' kopyalanıyor.
    CopyModuleConfig = {0} rapor yapılandırma dosyası '{1}' konumuna '{2}' kopyalanıyor.
    CreateConfig = {0} rapor yapılandırma dosyası '{1}.json' konumunda '{2}' oluşturuldu.
    OverWriteConfig = Rapor yapılandırma dosyası '{0}' konumuna '{1}' kopyalanıyor. Mevcut dosyanın üzerine yazılıyor.
    ForceOverwrite = {0} rapor yapılandırma dosyası '{1}.json' zaten '{2}' konumunda mevcut. Mevcut dosyanın üzerine yazmak için '-Force' kullanın.
    ConfigNotFound = Rapor yapılandırma dosyası modül yolunda '{0}' bulunamadı.
'@
