# culture = 'vi-VN'
@{

# As Built Report Information
ReportInfo = ConvertFrom-StringData @'
    BannerTitle = Thông tin As Built Report
    ReportAuthor = Nhập tên tác giả cho As Built Report này [{0}]
'@

# Company Configuration
CompanyConfig = ConvertFrom-StringData @'
    BannerTitle = Thông tin Công ty
    CompanyInfo = Bạn có muốn nhập thông tin công ty cho As Built Report không? (y/N)
    CompanyFullName = Nhập Tên Đầy đủ của Công ty
    CompanyShortName = Nhập Tên Viết tắt của Công ty
    CompanyContact = Nhập Liên hệ Công ty
    CompanyEmail = Nhập Địa chỉ Email Công ty
    CompanyPhone = Nhập Số Điện thoại Công ty
    CompanyAddress = Nhập Địa chỉ Công ty
'@

# Email Configuration
EmailConfig = ConvertFrom-StringData @'
    BannerTitle = Cấu hình Email
    ConfigureMailSettings = Bạn có muốn nhập cấu hình SMTP không? (y/N)
    MailServer = Nhập FQDN / địa chỉ IP của máy chủ thư
    EmptyMailServerAddress = Địa chỉ máy chủ thư không được để trống. Vui lòng nhập FQDN / địa chỉ IP hợp lệ của máy chủ thư.
    InvalidMailServer = '{0}' không phải là FQDN hoặc địa chỉ IP hợp lệ. Vui lòng nhập FQDN / địa chỉ IP hợp lệ của máy chủ thư.
    MailServerPort587 = Nhập số cổng máy chủ thư [587]
    InvalidMailServerPort587 = Số cổng không hợp lệ. Vui lòng nhập số từ 1 đến 65535 hoặc nhấn Enter cho giá trị mặc định [587].
    MailServerPort25 = Nhập số cổng máy chủ thư [25]
    InvalidMailServerPort25 = Số cổng không hợp lệ. Vui lòng nhập số từ 1 đến 65535 hoặc nhấn Enter cho giá trị mặc định [25].
    MailServerUseSSL = Sử dụng SSL cho kết nối máy chủ thư? (y/N)
    MailCredentials = Yêu cầu xác thực máy chủ thư? (y/N)
    MailFrom = Nhập địa chỉ email người gửi
    MailTo = Nhập địa chỉ email người nhận
    EmptyEmail = Địa chỉ email không được để trống. Vui lòng nhập địa chỉ email hợp lệ.
    InvalidEmail = '{0}' không phải là địa chỉ email hợp lệ. Vui lòng nhập địa chỉ email hợp lệ.
    AnotherRecipient = Bạn có muốn nhập người nhận khác không? (y/N)
    MailBodyPrompt = Nhập nội dung thông điệp email
    MailBody = Đã đính kèm As Built Report
'@

# Report Configuration
ReportConfig = ConvertFrom-StringData @'
    BannerTitle = Cấu hình As Built Report
    ReportConfigFolder = Nhập đường dẫn đầy đủ của thư mục sử dụng để lưu trữ tệp cấu hình mô-đun báo cáo và tập lệnh kiểu tùy chỉnh [{0}]
    OverwriteReportConfig = Tệp cấu hình mô-đun báo cáo cho {0} đã tồn tại trong thư mục được chỉ định. Bạn có muốn ghi đè nó không? (y/N)
    CopyFile = Đang sao chép '{0}' vào '{1}'.
    OverwriteFile = Đang sao chép '{0}' vào '{1}'. Ghi đè tệp hiện có.
    SaveAsBuiltConfig = Bạn có muốn lưu tệp cấu hình mô-đun lõi As Built Report không? (Y/n)
    AsBuiltName = Nhập tên cho tệp cấu hình As Built Report [AsBuiltReport]
    AsBuiltExportPath = Nhập đường dẫn để lưu tệp cấu hình As Built Report [{0}]
    ConfigFolder = Đang tạo thư mục cấu hình As Built Report '{0}'.
    SaveConfig = Đang lưu tệp cấu hình As Built Report '{0}.json' vào đường dẫn '{1}'.
    NotSaved = Tệp cấu hình As Built Report chưa được lưu.
'@
}
