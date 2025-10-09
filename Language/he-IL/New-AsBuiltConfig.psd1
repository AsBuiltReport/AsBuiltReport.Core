# culture = 'he-IL'
@{

# As Built Report Information
ReportInfo = ConvertFrom-StringData @'
    BannerTitle = מידע על דוח As Built
    ReportAuthor = הזן את שם המחבר של דוח As Built זה [{0}]
'@

# Company Configuration
CompanyConfig = ConvertFrom-StringData @'
    BannerTitle = מידע על החברה
    CompanyInfo = האם ברצונך להזין מידע על החברה עבור דוח As Built? (y/N)
    CompanyFullName = הזן את השם המלא של החברה
    CompanyShortName = הזן את השם המקוצר של החברה
    CompanyContact = הזן את איש הקשר בחברה
    CompanyEmail = הזן את כתובת הדוא"ל של החברה
    CompanyPhone = הזן את מספר הטלפון של החברה
    CompanyAddress = הזן את כתובת החברה
'@

# Email Configuration
EmailConfig = ConvertFrom-StringData @'
    BannerTitle = תצורת דוא"ל
    ConfigureMailSettings = האם ברצונך להזין תצורת SMTP? (y/N)
    MailServer = הזן את FQDN / כתובת IP של שרת הדוא"ל
    EmptyMailServerAddress = כתובת שרת הדוא"ל לא יכולה להיות רקה. אנא הזן FQDN / כתובת IP תקינה של שרת דוא"ל.
    InvalidMailServer = '{0}' אינו FQDN או כתובת IP תקינה. אנא הזן FQDN / כתובת IP תקינה של שרת דוא"ל.
    MailServerPort587 = הזן את מספר הפורט של שרת הדוא"ל [587]
    InvalidMailServerPort587 = מספר פורט לא תקין. אנא הזן מספר בין 1 ל-65535, או לחץ Enter עבור ברירת המחדל [587].
    MailServerPort25 = הזן את מספר הפורט של שרת הדוא"ל [25]
    InvalidMailServerPort25 = מספר פורט לא תקין. אנא הזן מספר בין 1 ל-65535, או לחץ Enter עבור ברירת המחדל [25].
    MailServerUseSSL = האם להשתמש ב-SSL עבור חיבור לשרת דוא"ל? (y/N)
    MailCredentials = האם נדרש אימות לשרת הדוא"ל? (y/N)
    MailFrom = הזן את כתובת הדוא"ל של השולח
    MailTo = הזן את כתובת הדוא"ל של הנמען
    EmptyEmail = כתובת דוא"ל לא יכולה להיות רקה. אנא הזן כתובת דוא"ל תקינה.
    InvalidEmail = '{0}' אינה כתובת דוא"ל תקינה. אנא הזן כתובת דוא"ל תקינה.
    AnotherRecipient = האם ברצונך להזין נמען נוסף? (y/N)
    MailBodyPrompt = הזן את תוכן גוף הודעת הדוא"ל
    MailBody = דוח As Built מצורף
'@

# Report Configuration
ReportConfig = ConvertFrom-StringData @'
    BannerTitle = תצורת דוח As Built
    ReportConfigFolder = הזן את הנתיב המלא של התיקייה לאחסון קבצי תצורת מודול הדוח וסקריפטים מותאמים אישית של סגנון [{0}]
    OverwriteReportConfig = קובץ תצורת מודול דוח עבור {0} כבר קיים בתיקייה שצוינה. האם ברצונך לדרוס אותו? (y/N)
    CopyFile = מעתיק את '{0}' אל '{1}'.
    OverwriteFile = מעתיק את '{0}' אל '{1}'. דורס קובץ קיים.
    SaveAsBuiltConfig = האם ברצונך לשמור את קובץ התצורה של מודול הליבה של As Built Report? (Y/n)
    AsBuiltName = הזן שם עבור קובץ תצורת As Built Report [AsBuiltReport]
    AsBuiltExportPath = הזן את הנתיב לשמירת קובץ תצורת As Built Report [{0}]
    ConfigFolder = יוצר תיקיית תצורת As Built Report '{0}'.
    SaveConfig = שומר קובץ תצורת As Built Report '{0}.json' בנתיב '{1}'.
    NotSaved = קובץ תצורת As Built Report לא נשמר.
'@
}
