# AsBuiltReport Default Document Style
try {
    # Try to initialize localized data for style elements
    # Use the report language from parent scope if available, otherwise fallback to OS language
    if ($PSScriptRoot) {
        if ($FinalReportLanguage) {
            Initialize-LocalizedData -ModuleBasePath $PSScriptRoot -LanguageFile 'AsBuiltReportCoreStyle' -ModuleType 'Core' -Language $FinalReportLanguage
        } else {
            Initialize-LocalizedData -ModuleBasePath $PSScriptRoot -LanguageFile 'AsBuiltReportCoreStyle' -ModuleType 'Core'
        }
    } else {
        # Fallback if $PSScriptRoot is not available
        $StyleModulePath = Split-Path -Path $MyInvocation.MyCommand.Path -Parent
        if ($FinalReportLanguage) {
            Initialize-LocalizedData -ModuleBasePath $StyleModulePath -LanguageFile 'AsBuiltReportCoreStyle' -ModuleType 'Core' -Language $FinalReportLanguage
        } else {
            Initialize-LocalizedData -ModuleBasePath $StyleModulePath -LanguageFile 'AsBuiltReportCoreStyle' -ModuleType 'Core'
        }
    }
} catch {
    # If localization fails, continue with default style (don't break report generation)
    Write-Warning "Could not load style localization: $($_.Exception.Message)"
}

# Configure document options
DocumentOption -EnableSectionNumbering -PageSize A4 -DefaultFont 'Segoe Ui' -MarginLeftAndRight 71 -MarginTopAndBottom 71 -Orientation $Orientation

# Configure Title & Heading Styles
Style -Name 'Title' -Size 24 -Color '012456' -Align Left
Style -Name 'Title 2' -Size 18 -Color '1F5FD0' -Align Left
Style -Name 'Title 3' -Size 12 -Color '4A5B78' -Align Left
Style -Name 'Heading 1' -Size 16 -Color '012456'
Style -Name 'Heading 2' -Size 14 -Color '012456'
Style -Name 'Heading 3' -Size 13 -Color '1F5FD0'
Style -Name 'Heading 4' -Size 12 -Color '1F5FD0'
Style -Name 'NO TOC Heading 4' -Size 12 -Color '1F5FD0'
Style -Name 'Heading 5' -Size 11 -Color '4A5B78'
Style -Name 'NO TOC Heading 5' -Size 11 -Color '4A5B78'
Style -Name 'Heading 6' -Size 10 -Color '4A5B78'
Style -Name 'NO TOC Heading 6' -Size 10 -Color '4A5B78'
Style -Name 'NO TOC Heading 7' -Size 10 -Color '4A5B78' -Italic
Style -Name 'Normal' -Size 10 -Color '0A1A33' -Default
# Header & Footer Styles
Style -Name 'Header' -Size 10 -Color '4A5B78' -Align Left
Style -Name 'Footer' -Size 10 -Color '4A5B78' -Align Right
# Table of Contents Style
Style -Name 'TOC' -Size 16 -Color '012456'
# Table Heading & Row Styles
Style -Name 'TableDefaultHeading' -Size 10 -Color 'FFFFFF' -BackgroundColor '012456'
Style -Name 'TableDefaultRow' -Size 10 -Color '0A1A33'
# Table Row/Cell Highlight Styles
Style -Name 'Critical' -Size 10 -Color '0A1A33' -BackgroundColor 'F9D5D0'
Style -Name 'Warning' -Size 10 -Color '0A1A33' -BackgroundColor 'FFE9A3'
Style -Name 'Info' -Size 10 -Color '0A1A33' -BackgroundColor 'DCE8FA'
Style -Name 'OK' -Size 10 -Color '0A1A33' -BackgroundColor 'D9EEDC'
# Table Caption Style
Style -Name 'Caption' -Size 10 -Color '4A5B78' -Italic -Align Left

# Configure Table Styles
$TableDefaultProperties = @{
    Id = 'TableDefault'
    HeaderStyle = 'TableDefaultHeading'
    RowStyle = 'TableDefaultRow'
    BorderColor = 'C5D2E6'
    Align = 'Left'
    CaptionStyle = 'Caption'
    CaptionLocation = 'Below'
    BorderWidth = 0.25
    PaddingTop = 1
    PaddingBottom = 1.5
    PaddingLeft = 2
    PaddingRight = 2
}

TableStyle @TableDefaultProperties -Default
TableStyle -Id 'Borderless' -HeaderStyle Normal -RowStyle Normal -BorderWidth 0

# Cover Page Layout
# Set Header & Footer, if enabled in report JSON configuration
if ($ReportConfig.Report.ShowHeaderFooter) {
    Header -Default {
        Paragraph -Style Header "$($ReportConfig.Report.Name) - v$($ReportConfig.Report.Version)"
    }

    Footer -Default {
        Paragraph -Style Footer $translate.Footer
    }
}

# Set position of cover page image, report titles and other information based on page orientatio
if (-not ($ReportConfig.Report.ShowCoverPageImage)) {
    $LineCount = 7
}
if ($Orientation -eq 'Portrait') {
    BlankLine -Count 11
    $LineCount = 22 + $LineCount
} else {
    BlankLine -Count 7
    $LineCount = 9 + $LineCount
}

# Show cover page image, if enabled in report JSON configuration
if ($ReportConfig.Report.ShowCoverPageImage) {
    try {
        Image -Text $translate.Logo -Align 'Left' -Percent 45 -Base64 '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'
        BlankLine -Count 1
    } catch {
        Write-PScriboMessage -IsWarning $translate.CoverPageWarning
    }
}

# Add Report Name
Paragraph -Style Title $ReportConfig.Report.Name

if ($AsBuiltConfig.Company.FullName) {
    # Add Company Name if specified
    BlankLine -Count 1
    Paragraph -Style Title2 $AsBuiltConfig.Company.FullName
    BlankLine -Count $LineCount
} else {
    BlankLine -Count ($LineCount + 1)
}
Table -Name $translate.CoverPage -List -Style Borderless -Width 0 -Hashtable ([Ordered] @{
        $translate.Author = $AsBuiltConfig.Report.Author
        $translate.Date = (Get-Date).ToLongDateString()
        $translate.Version = $ReportConfig.Report.Version
    })
PageBreak

if ($ReportConfig.Report.ShowTableOfContents) {
    # Add Table of Contents
    TOC -Name $translate.TOC
    PageBreak
}
