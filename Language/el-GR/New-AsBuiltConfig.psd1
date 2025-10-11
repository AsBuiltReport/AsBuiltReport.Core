# culture = 'el-GR'
@{

# As Built Report Information
ReportInfo = ConvertFrom-StringData @'
    BannerTitle = Πληροφορίες As Built Report
    ReportAuthor = Εισάγετε το όνομα του συγγραφέα για αυτό το As Built Report [{0}]
'@

# Company Configuration
CompanyConfig = ConvertFrom-StringData @'
    BannerTitle = Πληροφορίες Εταιρείας
    CompanyInfo = Θέλετε να εισάγετε πληροφορίες εταιρείας για το As Built Report; (y/N)
    CompanyFullName = Εισάγετε το Πλήρες Όνομα της Εταιρείας
    CompanyShortName = Εισάγετε το Σύντομο Όνομα της Εταιρείας
    CompanyContact = Εισάγετε το Στοιχείο Επικοινωνίας της Εταιρείας
    CompanyEmail = Εισάγετε τη Διεύθυνση Email της Εταιρείας
    CompanyPhone = Εισάγετε τον Αριθμό Τηλεφώνου της Εταιρείας
    CompanyAddress = Εισάγετε τη Διεύθυνση της Εταιρείας
'@

# Email Configuration
EmailConfig = ConvertFrom-StringData @'
    BannerTitle = Διαμόρφωση Email
    ConfigureMailSettings = Θέλετε να εισάγετε τη διαμόρφωση SMTP; (y/N)
    MailServer = Εισάγετε το FQDN / τη διεύθυνση IP του διακομιστή αλληλογραφίας
    EmptyMailServerAddress = Η διεύθυνση του διακομιστή αλληλογραφίας δεν μπορεί να είναι κενή. Εισάγετε ένα έγκυρο FQDN / διεύθυνση IP διακομιστή αλληλογραφίας.
    InvalidMailServer = Το '{0}' δεν είναι έγκυρο FQDN ή διεύθυνση IP. Εισάγετε ένα έγκυρο FQDN / διεύθυνση IP διακομιστή αλληλογραφίας.
    MailServerPort587 = Εισάγετε τον αριθμό θύρας του διακομιστή αλληλογραφίας [587]
    InvalidMailServerPort587 = Μη έγκυρος αριθμός θύρας. Εισάγετε έναν αριθμό μεταξύ 1 και 65535 ή πατήστε Enter για την προεπιλογή [587].
    MailServerPort25 = Εισάγετε τον αριθμό θύρας του διακομιστή αλληλογραφίας [25]
    InvalidMailServerPort25 = Μη έγκυρος αριθμός θύρας. Εισάγετε έναν αριθμό μεταξύ 1 και 65535 ή πατήστε Enter για την προεπιλογή [25].
    MailServerUseSSL = Χρήση SSL για τη σύνδεση με τον διακομιστή αλληλογραφίας; (y/N)
    MailCredentials = Απαιτείται έλεγχος ταυτότητας διακομιστή αλληλογραφίας; (y/N)
    MailFrom = Εισάγετε τη διεύθυνση email του αποστολέα
    MailTo = Εισάγετε τη διεύθυνση email του παραλήπτη
    EmptyEmail = Η διεύθυνση email δεν μπορεί να είναι κενή. Εισάγετε μια έγκυρη διεύθυνση email.
    InvalidEmail = Το '{0}' δεν είναι έγκυρη διεύθυνση email. Εισάγετε μια έγκυρη διεύθυνση email.
    AnotherRecipient = Θέλετε να εισάγετε άλλον παραλήπτη; (y/N)
    MailBodyPrompt = Εισάγετε το περιεχόμενο του σώματος του μηνύματος email
    MailBody = As Built Report επισυνάπτεται
'@

# Report Configuration
ReportConfig = ConvertFrom-StringData @'
    BannerTitle = Διαμόρφωση As Built Report
    ReportConfigFolder = Εισάγετε την πλήρη διαδρομή του φακέλου που θα χρησιμοποιηθεί για την αποθήκευση αρχείων διαμόρφωσης λειτουργικής μονάδας αναφορών και προσαρμοσμένων σεναρίων στυλ [{0}]
    OverwriteReportConfig = Υπάρχει ήδη ένα αρχείο διαμόρφωσης λειτουργικής μονάδας αναφοράς για {0} στον καθορισμένο φάκελο. Θέλετε να το αντικαταστήσετε; (y/N)
    CopyFile = Αντιγραφή του '{0}' στο '{1}'.
    OverwriteFile = Αντιγραφή του '{0}' στο '{1}'. Αντικατάσταση υπάρχοντος αρχείου.
    SaveAsBuiltConfig = Θέλετε να αποθηκεύσετε το αρχείο διαμόρφωσης της κύριας λειτουργικής μονάδας As Built Report; (Y/n)
    AsBuiltName = Εισάγετε ένα όνομα για το αρχείο διαμόρφωσης As Built Report [AsBuiltReport]
    AsBuiltExportPath = Εισάγετε τη διαδρομή για την αποθήκευση του αρχείου διαμόρφωσης As Built Report [{0}]
    ConfigFolder = Δημιουργία φακέλου διαμόρφωσης As Built Report '{0}'.
    SaveConfig = Αποθήκευση αρχείου διαμόρφωσης As Built Report '{0}.json' στη διαδρομή '{1}'.
    NotSaved = Το αρχείο διαμόρφωσης As Built Report δεν αποθηκεύτηκε.
'@
}
