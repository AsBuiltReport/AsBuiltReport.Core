# culture = 'ko-KR'
@{

# As Built Report Information
ReportInfo = ConvertFrom-StringData @'
    BannerTitle = As Built Report 정보
    ReportAuthor = 이 As Built Report의 작성자 이름을 입력하십시오 [{0}]
'@

# Company Configuration
CompanyConfig = ConvertFrom-StringData @'
    BannerTitle = 회사 정보
    CompanyInfo = As Built Report에 대한 회사 정보를 입력하시겠습니까? (y/N)
    CompanyFullName = 회사 전체 이름을 입력하십시오
    CompanyShortName = 회사 약칭을 입력하십시오
    CompanyContact = 회사 연락처를 입력하십시오
    CompanyEmail = 회사 이메일 주소를 입력하십시오
    CompanyPhone = 회사 전화번호를 입력하십시오
    CompanyAddress = 회사 주소를 입력하십시오
'@

# Email Configuration
EmailConfig = ConvertFrom-StringData @'
    BannerTitle = 이메일 구성
    ConfigureMailSettings = SMTP 구성을 입력하시겠습니까? (y/N)
    MailServer = 메일 서버 FQDN / IP 주소를 입력하십시오
    EmptyMailServerAddress = 메일 서버 주소는 비워둘 수 없습니다. 유효한 메일 서버 FQDN / IP 주소를 입력하십시오.
    InvalidMailServer = '{0}'은(는) 유효한 FQDN 또는 IP 주소가 아닙니다. 유효한 메일 서버 FQDN / IP 주소를 입력하십시오.
    MailServerPort587 = 메일 서버 포트 번호를 입력하십시오 [587]
    InvalidMailServerPort587 = 잘못된 포트 번호입니다. 1에서 65535 사이의 숫자를 입력하거나 기본값 [587]을 사용하려면 Enter를 누르십시오.
    MailServerPort25 = 메일 서버 포트 번호를 입력하십시오 [25]
    InvalidMailServerPort25 = 잘못된 포트 번호입니다. 1에서 65535 사이의 숫자를 입력하거나 기본값 [25]을 사용하려면 Enter를 누르십시오.
    MailServerUseSSL = 메일 서버 연결에 SSL을 사용하시겠습니까? (y/N)
    MailCredentials = 메일 서버 인증이 필요합니까? (y/N)
    MailFrom = 보내는 사람 이메일 주소를 입력하십시오
    MailTo = 받는 사람 이메일 주소를 입력하십시오
    EmptyEmail = 이메일 주소는 비워둘 수 없습니다. 유효한 이메일 주소를 입력하십시오.
    InvalidEmail = '{0}'은(는) 유효한 이메일 주소가 아닙니다. 유효한 이메일 주소를 입력하십시오.
    AnotherRecipient = 다른 받는 사람을 입력하시겠습니까? (y/N)
    MailBodyPrompt = 이메일 메시지 본문 내용을 입력하십시오
    MailBody = As Built Report 첨부됨
'@

# Report Configuration
ReportConfig = ConvertFrom-StringData @'
    BannerTitle = As Built Report 구성
    ReportConfigFolder = 보고서 모듈 구성 파일 및 사용자 지정 스타일 스크립트를 저장하는 데 사용할 폴더의 전체 경로를 입력하십시오 [{0}]
    OverwriteReportConfig = 지정된 폴더에 {0}에 대한 보고서 모듈 구성 파일이 이미 있습니다. 덮어쓰시겠습니까? (y/N)
    CopyFile = '{0}'을(를) '{1}'(으)로 복사하는 중입니다.
    OverwriteFile = '{0}'을(를) '{1}'(으)로 복사하는 중입니다. 기존 파일을 덮어씁니다.
    SaveAsBuiltConfig = As Built Report 핵심 모듈 구성 파일을 저장하시겠습니까? (Y/n)
    AsBuiltName = As Built Report 구성 파일의 이름을 입력하십시오 [AsBuiltReport]
    AsBuiltExportPath = As Built Report 구성 파일을 저장할 경로를 입력하십시오 [{0}]
    ConfigFolder = As Built Report 구성 폴더 '{0}'을(를) 만드는 중입니다.
    SaveConfig = As Built Report 구성 파일 '{0}.json'을(를) 경로 '{1}'에 저장하는 중입니다.
    NotSaved = As Built Report 구성 파일이 저장되지 않았습니다.
'@
}
