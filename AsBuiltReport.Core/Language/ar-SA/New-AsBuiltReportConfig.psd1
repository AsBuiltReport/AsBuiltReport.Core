# culture = 'ar-SA'
ConvertFrom-StringData @'
    FolderNotExist = المجلد '{0}' غير موجود. يرجى إنشاء المجلد وتشغيل New-AsBuiltReportConfig مرة أخرى.
    ProcessConfig = معالجة ملف تكوين التقرير {0} من الوحدة {1}، الإصدار {2}.
    CopyConfig = نسخ ملف تكوين التقرير '{0}' إلى '{1}'.
    CopyModuleConfig = نسخ ملف تكوين التقرير {0} '{1}' إلى '{2}'.
    CreateConfig = تم إنشاء ملف تكوين التقرير {0} '{1}.json' في '{2}'.
    OverWriteConfig = نسخ ملف تكوين التقرير '{0}' إلى '{1}'. الكتابة فوق الملف الموجود.
    ForceOverwrite = ملف تكوين التقرير {0} '{1}.json' موجود بالفعل في '{2}'. استخدم '-Force' للكتابة فوق الملف الموجود.
    ConfigNotFound = لم يتم العثور على ملف تكوين التقرير في مسار الوحدة '{0}'.
'@
