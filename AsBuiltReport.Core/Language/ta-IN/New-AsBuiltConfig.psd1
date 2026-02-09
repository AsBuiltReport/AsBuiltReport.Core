# culture = 'ta-IN'
@{

# As Built Report Information
ReportInfo = ConvertFrom-StringData @'
    BannerTitle = As Built Report தகவல்
    ReportAuthor = இந்த As Built Report இன் ஆசிரியர் பெயரை உள்ளிடவும் [{0}]
'@

# Company Configuration
CompanyConfig = ConvertFrom-StringData @'
    BannerTitle = நிறுவனத் தகவல்
    CompanyInfo = As Built Report க்கு நிறுவனத் தகவலை உள்ளிட விரும்புகிறீர்களா? (y/N)
    CompanyFullName = நிறுவனத்தின் முழு பெயரை உள்ளிடவும்
    CompanyShortName = நிறுவனத்தின் சுருக்கப் பெயரை உள்ளிடவும்
    CompanyContact = நிறுவன தொடர்பை உள்ளிடவும்
    CompanyEmail = நிறுவன மின்னஞ்சல் முகவரியை உள்ளிடவும்
    CompanyPhone = நிறுவன தொலைபேசி எண்ணை உள்ளிடவும்
    CompanyAddress = நிறுவன முகவரியை உள்ளிடவும்
'@

# Email Configuration
EmailConfig = ConvertFrom-StringData @'
    BannerTitle = மின்னஞ்சல் உள்ளமைவு
    ConfigureMailSettings = SMTP உள்ளமைவை உள்ளிட விரும்புகிறீர்களா? (y/N)
    MailServer = அஞ்சல் சேவையக FQDN / IP முகவரியை உள்ளிடவும்
    EmptyMailServerAddress = அஞ்சல் சேவையக முகவரி காலியாக இருக்க முடியாது. தயவுசெய்து சரியான அஞ்சல் சேவையக FQDN / IP முகவரியை உள்ளிடவும்.
    InvalidMailServer = '{0}' சரியான FQDN அல்லது IP முகவரி அல்ல. தயவுசெய்து சரியான அஞ்சல் சேவையக FQDN / IP முகவரியை உள்ளிடவும்.
    MailServerPort587 = அஞ்சல் சேவையக போர்ட் எண்ணை உள்ளிடவும் [587]
    InvalidMailServerPort587 = தவறான போர்ட் எண். தயவுசெய்து 1 மற்றும் 65535 க்கு இடையில் ஒரு எண்ணை உள்ளிடவும், அல்லது இயல்புநிலைக்கு [587] Enter அழுத்தவும்.
    MailServerPort25 = அஞ்சல் சேவையக போர்ட் எண்ணை உள்ளிடவும் [25]
    InvalidMailServerPort25 = தவறான போர்ட் எண். தயவுசெய்து 1 மற்றும் 65535 க்கு இடையில் ஒரு எண்ணை உள்ளிடவும், அல்லது இயல்புநிலைக்கு [25] Enter அழுத்தவும்.
    MailServerUseSSL = அஞ்சல் சேவையக இணைப்புக்கு SSL பயன்படுத்தவா? (y/N)
    MailCredentials = அஞ்சல் சேவையக அங்கீகாரம் தேவையா? (y/N)
    MailFrom = அனுப்புநர் மின்னஞ்சல் முகவரியை உள்ளிடவும்
    MailTo = பெறுநர் மின்னஞ்சல் முகவரியை உள்ளிடவும்
    EmptyEmail = மின்னஞ்சல் முகவரி காலியாக இருக்க முடியாது. தயவுசெய்து சரியான மின்னஞ்சல் முகவரியை உள்ளிடவும்.
    InvalidEmail = '{0}' சரியான மின்னஞ்சல் முகவரி அல்ல. தயவுசெய்து சரியான மின்னஞ்சல் முகவரியை உள்ளிடவும்.
    AnotherRecipient = மற்றொரு பெறுநரை உள்ளிட விரும்புகிறீர்களா? (y/N)
    MailBodyPrompt = மின்னஞ்சல் செய்தி உள்ளடக்கத்தை உள்ளிடவும்
    MailBody = As Built Report இணைக்கப்பட்டுள்ளது
'@

# Report Configuration
ReportConfig = ConvertFrom-StringData @'
    BannerTitle = As Built Report உள்ளமைவு
    ReportConfigFolder = அறிக்கை தொகுதி உள்ளமைவு கோப்புகள் மற்றும் தனிப்பயன் நடை ஸ்கிரிப்டுகளை சேமிக்க கோப்புறையின் முழு பாதையை உள்ளிடவும் [{0}]
    OverwriteReportConfig = குறிப்பிட்ட கோப்புறையில் {0} க்கான அறிக்கை தொகுதி உள்ளமைவு கோப்பு ஏற்கனவே உள்ளது. மேலெழுத விரும்புகிறீர்களா? (y/N)
    CopyFile = '{0}' ஐ '{1}' க்கு நகலெடுக்கிறது.
    OverwriteFile = '{0}' ஐ '{1}' க்கு நகலெடுக்கிறது. ஏற்கனவே உள்ள கோப்பை மேலெழுதுகிறது.
    SaveAsBuiltConfig = As Built Report அடிப்படை தொகுதி உள்ளமைவு கோப்பை சேமிக்க விரும்புகிறீர்களா? (Y/n)
    AsBuiltName = As Built Report உள்ளமைவு கோப்புக்கு ஒரு பெயரை உள்ளிடவும் [AsBuiltReport]
    AsBuiltExportPath = As Built Report உள்ளமைவு கோப்பை சேமிக்க பாதையை உள்ளிடவும் [{0}]
    ConfigFolder = As Built Report உள்ளமைவு கோப்புறை '{0}' உருவாக்கப்படுகிறது.
    SaveConfig = As Built Report உள்ளமைவு கோப்பு '{0}.json' '{1}' பாதையில் சேமிக்கப்படுகிறது.
    NotSaved = As Built Report உள்ளமைவு கோப்பு சேமிக்கப்படவில்லை.
'@
}
