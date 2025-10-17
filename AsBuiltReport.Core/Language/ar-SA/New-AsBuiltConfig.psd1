# culture = 'ar-SA'
@{

# As Built Report Information
ReportInfo = ConvertFrom-StringData @'
    BannerTitle = معلومات As Built Report
    ReportAuthor = أدخل اسم المؤلف لهذا As Built Report [{0}]
'@

# Company Configuration
CompanyConfig = ConvertFrom-StringData @'
    BannerTitle = معلومات الشركة
    CompanyInfo = هل ترغب في إدخال معلومات الشركة لـ As Built Report؟ (y/N)
    CompanyFullName = أدخل الاسم الكامل للشركة
    CompanyShortName = أدخل الاسم المختصر للشركة
    CompanyContact = أدخل جهة اتصال الشركة
    CompanyEmail = أدخل عنوان البريد الإلكتروني للشركة
    CompanyPhone = أدخل رقم هاتف الشركة
    CompanyAddress = أدخل عنوان الشركة
'@

# Email Configuration
EmailConfig = ConvertFrom-StringData @'
    BannerTitle = إعدادات البريد الإلكتروني
    ConfigureMailSettings = هل ترغب في إدخال إعدادات SMTP؟ (y/N)
    MailServer = أدخل FQDN / عنوان IP لخادم البريد
    EmptyMailServerAddress = لا يمكن أن يكون عنوان خادم البريد فارغًا. يرجى إدخال FQDN / عنوان IP صالح لخادم البريد.
    InvalidMailServer = '{0}' ليس FQDN أو عنوان IP صالحًا. يرجى إدخال FQDN / عنوان IP صالح لخادم البريد.
    MailServerPort587 = أدخل رقم منفذ خادم البريد [587]
    InvalidMailServerPort587 = رقم منفذ غير صالح. يرجى إدخال رقم بين 1 و 65535، أو اضغط على Enter للقيمة الافتراضية [587].
    MailServerPort25 = أدخل رقم منفذ خادم البريد [25]
    InvalidMailServerPort25 = رقم منفذ غير صالح. يرجى إدخال رقم بين 1 و 65535، أو اضغط على Enter للقيمة الافتراضية [25].
    MailServerUseSSL = استخدام SSL لاتصال خادم البريد؟ (y/N)
    MailCredentials = هل يتطلب خادم البريد المصادقة؟ (y/N)
    MailFrom = أدخل عنوان البريد الإلكتروني للمرسل
    MailTo = أدخل عنوان البريد الإلكتروني للمستلم
    EmptyEmail = لا يمكن أن يكون عنوان البريد الإلكتروني فارغًا. يرجى إدخال عنوان بريد إلكتروني صالح.
    InvalidEmail = '{0}' ليس عنوان بريد إلكتروني صالحًا. يرجى إدخال عنوان بريد إلكتروني صالح.
    AnotherRecipient = هل تريد إدخال مستلم آخر؟ (y/N)
    MailBodyPrompt = أدخل محتوى نص رسالة البريد الإلكتروني
    MailBody = As Built Report مرفق
'@

# Report Configuration
ReportConfig = ConvertFrom-StringData @'
    BannerTitle = إعدادات As Built Report
    ReportConfigFolder = أدخل المسار الكامل للمجلد لاستخدامه لتخزين ملفات تكوين وحدة التقرير والنصوص البرمجية المخصصة [{0}]
    OverwriteReportConfig = يوجد بالفعل ملف تكوين وحدة التقرير لـ {0} في المجلد المحدد. هل تريد الكتابة فوقه؟ (y/N)
    CopyFile = نسخ '{0}' إلى '{1}'.
    OverwriteFile = نسخ '{0}' إلى '{1}'. الكتابة فوق الملف الموجود.
    SaveAsBuiltConfig = هل تريد حفظ ملف تكوين الوحدة الأساسية لـ As Built Report؟ (Y/n)
    AsBuiltName = أدخل اسمًا لملف تكوين As Built Report [AsBuiltReport]
    AsBuiltExportPath = أدخل المسار لحفظ ملف تكوين As Built Report [{0}]
    ConfigFolder = إنشاء مجلد تكوين As Built Report '{0}'.
    SaveConfig = حفظ ملف تكوين As Built Report '{0}.json' إلى المسار '{1}'.
    NotSaved = لم يتم حفظ ملف تكوين As Built Report.
'@
}
