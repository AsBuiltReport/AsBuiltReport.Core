# culture = 'th-TH'
@{

# As Built Report Information
ReportInfo = ConvertFrom-StringData @'
    BannerTitle = ข้อมูล As Built Report
    ReportAuthor = ป้อนชื่อผู้เขียนสำหรับ As Built Report นี้ [{0}]
'@

# Company Configuration
CompanyConfig = ConvertFrom-StringData @'
    BannerTitle = ข้อมูลบริษัท
    CompanyInfo = คุณต้องการป้อนข้อมูลบริษัทสำหรับ As Built Report หรือไม่? (y/N)
    CompanyFullName = ป้อนชื่อบริษัทแบบเต็ม
    CompanyShortName = ป้อนชื่อบริษัทแบบย่อ
    CompanyContact = ป้อนผู้ติดต่อบริษัท
    CompanyEmail = ป้อนที่อยู่อีเมลของบริษัท
    CompanyPhone = ป้อนหมายเลขโทรศัพท์ของบริษัท
    CompanyAddress = ป้อนที่อยู่ของบริษัท
'@

# Email Configuration
EmailConfig = ConvertFrom-StringData @'
    BannerTitle = การกำหนดค่าอีเมล
    ConfigureMailSettings = คุณต้องการป้อนการกำหนดค่า SMTP หรือไม่? (y/N)
    MailServer = ป้อน FQDN / ที่อยู่ IP ของเซิร์ฟเวอร์เมล
    EmptyMailServerAddress = ที่อยู่เซิร์ฟเวอร์เมลต้องไม่ว่างเปล่า โปรดป้อน FQDN / ที่อยู่ IP ที่ถูกต้องของเซิร์ฟเวอร์เมล
    InvalidMailServer = '{0}' ไม่ใช่ FQDN หรือที่อยู่ IP ที่ถูกต้อง โปรดป้อน FQDN / ที่อยู่ IP ที่ถูกต้องของเซิร์ฟเวอร์เมล
    MailServerPort587 = ป้อนหมายเลขพอร์ตของเซิร์ฟเวอร์เมล [587]
    InvalidMailServerPort587 = หมายเลขพอร์ตไม่ถูกต้อง โปรดป้อนตัวเลขระหว่าง 1 ถึง 65535 หรือกด Enter สำหรับค่าเริ่มต้น [587]
    MailServerPort25 = ป้อนหมายเลขพอร์ตของเซิร์ฟเวอร์เมล [25]
    InvalidMailServerPort25 = หมายเลขพอร์ตไม่ถูกต้อง โปรดป้อนตัวเลขระหว่าง 1 ถึง 65535 หรือกด Enter สำหรับค่าเริ่มต้น [25]
    MailServerUseSSL = ใช้ SSL สำหรับการเชื่อมต่อเซิร์ฟเวอร์เมลหรือไม่? (y/N)
    MailCredentials = ต้องการการตรวจสอบสิทธิ์เซิร์ฟเวอร์เมลหรือไม่? (y/N)
    MailFrom = ป้อนที่อยู่อีเมลของผู้ส่ง
    MailTo = ป้อนที่อยู่อีเมลของผู้รับ
    EmptyEmail = ที่อยู่อีเมลต้องไม่ว่างเปล่า โปรดป้อนที่อยู่อีเมลที่ถูกต้อง
    InvalidEmail = '{0}' ไม่ใช่ที่อยู่อีเมลที่ถูกต้อง โปรดป้อนที่อยู่อีเมลที่ถูกต้อง
    AnotherRecipient = คุณต้องการป้อนผู้รับรายอื่นหรือไม่? (y/N)
    MailBodyPrompt = ป้อนเนื้อหาข้อความอีเมล
    MailBody = แนบ As Built Report
'@

# Report Configuration
ReportConfig = ConvertFrom-StringData @'
    BannerTitle = การกำหนดค่า As Built Report
    ReportConfigFolder = ป้อนเส้นทางเต็มของโฟลเดอร์ที่จะใช้สำหรับจัดเก็บไฟล์การกำหนดค่าโมดูลรายงานและสคริปต์สไตล์แบบกำหนดเอง [{0}]
    OverwriteReportConfig = ไฟล์การกำหนดค่าโมดูลรายงานสำหรับ {0} มีอยู่แล้วในโฟลเดอร์ที่ระบุ คุณต้องการเขียนทับหรือไม่? (y/N)
    CopyFile = กำลังคัดลอก '{0}' ไปยัง '{1}'
    OverwriteFile = กำลังคัดลอก '{0}' ไปยัง '{1}' กำลังเขียนทับไฟล์ที่มีอยู่
    SaveAsBuiltConfig = คุณต้องการบันทึกไฟล์การกำหนดค่าโมดูลหลักของ As Built Report หรือไม่? (Y/n)
    AsBuiltName = ป้อนชื่อสำหรับไฟล์การกำหนดค่า As Built Report [AsBuiltReport]
    AsBuiltExportPath = ป้อนเส้นทางเพื่อบันทึกไฟล์การกำหนดค่า As Built Report [{0}]
    ConfigFolder = กำลังสร้างโฟลเดอร์การกำหนดค่า As Built Report '{0}'
    SaveConfig = กำลังบันทึกไฟล์การกำหนดค่า As Built Report '{0}.json' ไปยังเส้นทาง '{1}'
    NotSaved = ไม่ได้บันทึกไฟล์การกำหนดค่า As Built Report
'@
}
