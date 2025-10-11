# culture = 'hi-IN'
@{

# As Built Report Information
ReportInfo = ConvertFrom-StringData @'
    BannerTitle = As Built Report जानकारी
    ReportAuthor = इस As Built Report के लेखक का नाम दर्ज करें [{0}]
'@

# Company Configuration
CompanyConfig = ConvertFrom-StringData @'
    BannerTitle = कंपनी की जानकारी
    CompanyInfo = क्या आप As Built Report के लिए कंपनी की जानकारी दर्ज करना चाहेंगे? (y/N)
    CompanyFullName = कंपनी का पूरा नाम दर्ज करें
    CompanyShortName = कंपनी का संक्षिप्त नाम दर्ज करें
    CompanyContact = कंपनी संपर्क दर्ज करें
    CompanyEmail = कंपनी का ईमेल पता दर्ज करें
    CompanyPhone = कंपनी का फोन नंबर दर्ज करें
    CompanyAddress = कंपनी का पता दर्ज करें
'@

# Email Configuration
EmailConfig = ConvertFrom-StringData @'
    BannerTitle = ईमेल कॉन्फ़िगरेशन
    ConfigureMailSettings = क्या आप SMTP कॉन्फ़िगरेशन दर्ज करना चाहेंगे? (y/N)
    MailServer = मेल सर्वर FQDN / IP पता दर्ज करें
    EmptyMailServerAddress = मेल सर्वर पता खाली नहीं हो सकता। कृपया एक वैध मेल सर्वर FQDN / IP पता दर्ज करें।
    InvalidMailServer = '{0}' एक वैध FQDN या IP पता नहीं है। कृपया एक वैध मेल सर्वर FQDN / IP पता दर्ज करें।
    MailServerPort587 = मेल सर्वर पोर्ट नंबर दर्ज करें [587]
    InvalidMailServerPort587 = अवैध पोर्ट नंबर। कृपया 1 और 65535 के बीच एक नंबर दर्ज करें, या डिफ़ॉल्ट [587] के लिए Enter दबाएं।
    MailServerPort25 = मेल सर्वर पोर्ट नंबर दर्ज करें [25]
    InvalidMailServerPort25 = अवैध पोर्ट नंबर। कृपया 1 और 65535 के बीच एक नंबर दर्ज करें, या डिफ़ॉल्ट [25] के लिए Enter दबाएं।
    MailServerUseSSL = मेल सर्वर कनेक्शन के लिए SSL का उपयोग करें? (y/N)
    MailCredentials = मेल सर्वर प्रमाणीकरण की आवश्यकता है? (y/N)
    MailFrom = प्रेषक का ईमेल पता दर्ज करें
    MailTo = प्राप्तकर्ता का ईमेल पता दर्ज करें
    EmptyEmail = ईमेल पता खाली नहीं हो सकता। कृपया एक वैध ईमेल पता दर्ज करें।
    InvalidEmail = '{0}' एक वैध ईमेल पता नहीं है। कृपया एक वैध ईमेल पता दर्ज करें।
    AnotherRecipient = क्या आप अन्य प्राप्तकर्ता दर्ज करना चाहते हैं? (y/N)
    MailBodyPrompt = ईमेल संदेश की सामग्री दर्ज करें
    MailBody = As Built Report संलग्न
'@

# Report Configuration
ReportConfig = ConvertFrom-StringData @'
    BannerTitle = As Built Report कॉन्फ़िगरेशन
    ReportConfigFolder = रिपोर्ट मॉड्यूल कॉन्फ़िगरेशन फ़ाइलों और कस्टम स्टाइल स्क्रिप्ट को संग्रहीत करने के लिए फ़ोल्डर का पूरा पथ दर्ज करें [{0}]
    OverwriteReportConfig = निर्दिष्ट फ़ोल्डर में {0} के लिए एक रिपोर्ट मॉड्यूल कॉन्फ़िगरेशन फ़ाइल पहले से मौजूद है। क्या आप इसे अधिलेखित करना चाहेंगे? (y/N)
    CopyFile = '{0}' को '{1}' में कॉपी किया जा रहा है।
    OverwriteFile = '{0}' को '{1}' में कॉपी किया जा रहा है। मौजूदा फ़ाइल को अधिलेखित किया जा रहा है।
    SaveAsBuiltConfig = क्या आप As Built Report कोर मॉड्यूल कॉन्फ़िगरेशन फ़ाइल को सहेजना चाहेंगे? (Y/n)
    AsBuiltName = As Built Report कॉन्फ़िगरेशन फ़ाइल के लिए एक नाम दर्ज करें [AsBuiltReport]
    AsBuiltExportPath = As Built Report कॉन्फ़िगरेशन फ़ाइल को सहेजने के लिए पथ दर्ज करें [{0}]
    ConfigFolder = As Built Report कॉन्फ़िगरेशन फ़ोल्डर '{0}' बनाया जा रहा है।
    SaveConfig = As Built Report कॉन्फ़िगरेशन फ़ाइल '{0}.json' को पथ '{1}' में सहेजा जा रहा है।
    NotSaved = As Built Report कॉन्फ़िगरेशन फ़ाइल सहेजी नहीं गई।
'@
}
