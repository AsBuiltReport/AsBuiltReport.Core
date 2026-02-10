# culture = 'si-LK'
@{

# As Built Report Information
ReportInfo = ConvertFrom-StringData @'
    BannerTitle = As Built Report තොරතුරු
    ReportAuthor = මෙම As Built Report හි කතුවරයාගේ නම ඇතුළත් කරන්න [{0}]
'@

# Company Configuration
CompanyConfig = ConvertFrom-StringData @'
    BannerTitle = සමාගම් තොරතුරු
    CompanyInfo = As Built Report සඳහා සමාගම් තොරතුරු ඇතුළත් කිරීමට ඔබ කැමතිද? (y/N)
    CompanyFullName = සමාගමේ සම්පූර්ණ නම ඇතුළත් කරන්න
    CompanyShortName = සමාගමේ කෙටි නම ඇතුළත් කරන්න
    CompanyContact = සමාගම් සම්බන්ධතාව ඇතුළත් කරන්න
    CompanyEmail = සමාගම් විද්‍යුත් තැපැල් ලිපිනය ඇතුළත් කරන්න
    CompanyPhone = සමාගම් දුරකථන අංකය ඇතුළත් කරන්න
    CompanyAddress = සමාගම් ලිපිනය ඇතුළත් කරන්න
'@

# Email Configuration
EmailConfig = ConvertFrom-StringData @'
    BannerTitle = විද්‍යුත් තැපැල් වින්‍යාසය
    ConfigureMailSettings = SMTP වින්‍යාසය ඇතුළත් කිරීමට ඔබ කැමතිද? (y/N)
    MailServer = තැපැල් සේවාදායක FQDN / IP ලිපිනය ඇතුළත් කරන්න
    EmptyMailServerAddress = තැපැල් සේවාදායක ලිපිනය හිස් විය නොහැක. කරුණාකර වලංගු තැපැල් සේවාදායක FQDN / IP ලිපිනයක් ඇතුළත් කරන්න.
    InvalidMailServer = '{0}' වලංගු FQDN හෝ IP ලිපිනයක් නොවේ. කරුණාකර වලංගු තැපැල් සේවාදායක FQDN / IP ලිපිනයක් ඇතුළත් කරන්න.
    MailServerPort587 = තැපැල් සේවාදායක පෝට් අංකය ඇතුළත් කරන්න [587]
    InvalidMailServerPort587 = වලංගු නොවන පෝට් අංකය. කරුණාකර 1 සහ 65535 අතර අංකයක් ඇතුළත් කරන්න, නැතහොත් පෙරනිමිය [587] සඳහා Enter ඔබන්න.
    MailServerPort25 = තැපැල් සේවාදායක පෝට් අංකය ඇතුළත් කරන්න [25]
    InvalidMailServerPort25 = වලංගු නොවන පෝට් අංකය. කරුණාකර 1 සහ 65535 අතර අංකයක් ඇතුළත් කරන්න, නැතහොත් පෙරනිමිය [25] සඳහා Enter ඔබන්න.
    MailServerUseSSL = තැපැල් සේවාදායක සම්බන්ධතාවය සඳහා SSL භාවිතා කරන්නද? (y/N)
    MailCredentials = තැපැල් සේවාදායක සත්‍යාපනය අවශ්‍යද? (y/N)
    MailFrom = යවන්නාගේ විද්‍යුත් තැපැල් ලිපිනය ඇතුළත් කරන්න
    MailTo = ලබන්නාගේ විද්‍යුත් තැපැල් ලිපිනය ඇතුළත් කරන්න
    EmptyEmail = විද්‍යුත් තැපැල් ලිපිනය හිස් විය නොහැක. කරුණාකර වලංගු විද්‍යුත් තැපැල් ලිපිනයක් ඇතුළත් කරන්න.
    InvalidEmail = '{0}' වලංගු විද්‍යුත් තැපැල් ලිපිනයක් නොවේ. කරුණාකර වලංගු විද්‍යුත් තැපැල් ලිපිනයක් ඇතුළත් කරන්න.
    AnotherRecipient = තවත් ලබන්නෙකු ඇතුළත් කිරීමට ඔබ කැමතිද? (y/N)
    MailBodyPrompt = විද්‍යුත් තැපැල් පණිවිඩයේ අන්තර්ගතය ඇතුළත් කරන්න
    MailBody = As Built Report ඇමුණුම් කර ඇත
'@

# Report Configuration
ReportConfig = ConvertFrom-StringData @'
    BannerTitle = As Built Report වින්‍යාසය
    ReportConfigFolder = වාර්තා මොඩියුල වින්‍යාස ගොනු සහ අභිරුචි මෝස්තර ස්ක්‍රිප්ට් ගබඩා කිරීමට ෆෝල්ඩරයේ සම්පූර්ණ මාර්ගය ඇතුළත් කරන්න [{0}]
    OverwriteReportConfig = නිශ්චිත ෆෝල්ඩරයේ {0} සඳහා වාර්තා මොඩියුල වින්‍යාස ගොනුවක් දැනටමත් පවතී. ඔබට එය උඩින් ලිවීමට අවශ්‍යද? (y/N)
    CopyFile = '{0}' '{1}' වෙත පිටපත් කරමින්.
    OverwriteFile = '{0}' '{1}' වෙත පිටපත් කරමින්. පවතින ගොනුව උඩින් ලිවීම.
    SaveAsBuiltConfig = As Built Report මූලික මොඩියුල වින්‍යාස ගොනුව සුරැකීමට ඔබ කැමතිද? (Y/n)
    AsBuiltName = As Built Report වින්‍යාස ගොනුව සඳහා නමක් ඇතුළත් කරන්න [AsBuiltReport]
    AsBuiltExportPath = As Built Report වින්‍යාස ගොනුව සුරැකීමට මාර්ගය ඇතුළත් කරන්න [{0}]
    ConfigFolder = As Built Report වින්‍යාස ෆෝල්ඩරය '{0}' සාදමින්.
    SaveConfig = As Built Report වින්‍යාස ගොනුව '{0}.json' '{1}' මාර්ගයට සුරකිමින්.
    NotSaved = As Built Report වින්‍යාස ගොනුව සුරැකූයේ නැත.
'@
}
