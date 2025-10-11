# culture = 'tr-TR'
@{

# As Built Report Information
ReportInfo = ConvertFrom-StringData @'
    BannerTitle = As Built Report Bilgileri
    ReportAuthor = Bu As Built Report için yazarın adını girin [{0}]
'@

# Company Configuration
CompanyConfig = ConvertFrom-StringData @'
    BannerTitle = Şirket Bilgileri
    CompanyInfo = As Built Report için şirket bilgilerini girmek ister misiniz? (y/N)
    CompanyFullName = Şirketin Tam Adını Girin
    CompanyShortName = Şirketin Kısa Adını Girin
    CompanyContact = Şirket İletişim Bilgisini Girin
    CompanyEmail = Şirket E-posta Adresini Girin
    CompanyPhone = Şirket Telefon Numarasını Girin
    CompanyAddress = Şirket Adresini Girin
'@

# Email Configuration
EmailConfig = ConvertFrom-StringData @'
    BannerTitle = E-posta Yapılandırması
    ConfigureMailSettings = SMTP yapılandırmasını girmek ister misiniz? (y/N)
    MailServer = Posta sunucusu FQDN / IP adresini girin
    EmptyMailServerAddress = Posta sunucusu adresi boş olamaz. Lütfen geçerli bir posta sunucusu FQDN / IP adresi girin.
    InvalidMailServer = '{0}' geçerli bir FQDN veya IP adresi değil. Lütfen geçerli bir posta sunucusu FQDN / IP adresi girin.
    MailServerPort587 = Posta sunucusu port numarasını girin [587]
    InvalidMailServerPort587 = Geçersiz port numarası. Lütfen 1 ile 65535 arasında bir sayı girin veya varsayılan değer [587] için Enter tuşuna basın.
    MailServerPort25 = Posta sunucusu port numarasını girin [25]
    InvalidMailServerPort25 = Geçersiz port numarası. Lütfen 1 ile 65535 arasında bir sayı girin veya varsayılan değer [25] için Enter tuşuna basın.
    MailServerUseSSL = Posta sunucusu bağlantısı için SSL kullanılsın mı? (y/N)
    MailCredentials = Posta sunucusu kimlik doğrulaması gerekli mi? (y/N)
    MailFrom = Gönderici e-posta adresini girin
    MailTo = Alıcı e-posta adresini girin
    EmptyEmail = E-posta adresi boş olamaz. Lütfen geçerli bir e-posta adresi girin.
    InvalidEmail = '{0}' geçerli bir e-posta adresi değil. Lütfen geçerli bir e-posta adresi girin.
    AnotherRecipient = Başka bir alıcı girmek istiyor musunuz? (y/N)
    MailBodyPrompt = E-posta mesajı gövde içeriğini girin
    MailBody = As Built Report eklendi
'@

# Report Configuration
ReportConfig = ConvertFrom-StringData @'
    BannerTitle = As Built Report Yapılandırması
    ReportConfigFolder = Rapor modülü yapılandırma dosyalarını ve özel stil betiklerini saklamak için kullanılacak klasörün tam yolunu girin [{0}]
    OverwriteReportConfig = Belirtilen klasörde {0} için bir rapor modülü yapılandırma dosyası zaten var. Üzerine yazmak ister misiniz? (y/N)
    CopyFile = '{0}' dosyası '{1}' konumuna kopyalanıyor.
    OverwriteFile = '{0}' dosyası '{1}' konumuna kopyalanıyor. Mevcut dosyanın üzerine yazılıyor.
    SaveAsBuiltConfig = As Built Report çekirdek modülü yapılandırma dosyasını kaydetmek ister misiniz? (Y/n)
    AsBuiltName = As Built Report yapılandırma dosyası için bir ad girin [AsBuiltReport]
    AsBuiltExportPath = As Built Report yapılandırma dosyasını kaydetmek için yolu girin [{0}]
    ConfigFolder = As Built Report yapılandırma klasörü '{0}' oluşturuluyor.
    SaveConfig = As Built Report yapılandırma dosyası '{0}.json' yoluna '{1}' kaydediliyor.
    NotSaved = As Built Report yapılandırma dosyası kaydedilmedi.
'@
}
