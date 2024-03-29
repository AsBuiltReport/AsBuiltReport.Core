# Sample Document Style 2

# Configure document options e.g. page size, margins, default font, page orientation
# It is recommended to use a web safe system font. If the configured font is not installed on the
# system from which the report is viewed then a substitute font will be used. This may not result
# in the desired look of the document
DocumentOption -EnableSectionNumbering -PageSize A4 -DefaultFont 'Tahoma' -MarginLeftAndRight 71 -MarginTopAndBottom 71 -Orientation $Orientation

# Title & Heading Styles
Style -Name 'Title' -Size 24 -Color '00785F' -Align Left
Style -Name 'Title 2' -Size 18 -Color '00A956' -Align Left
Style -Name 'Title 3' -Size 12 -Color '006A91' -Align Left
Style -Name 'Heading 1' -Size 16 -Color '00785F'
Style -Name 'Heading 2' -Size 14 -Color '004B6B'
Style -Name 'Heading 3' -Size 12 -Color '00567A'
Style -Name 'Heading 4' -Size 11 -Color '00648F'
Style -Name 'NO TOC Heading 4' -Size 11 -Color '00648F'
Style -Name 'Heading 5' -Size 10 -Color '0072A3'
Style -Name 'NO TOC Heading 5' -Size 10 -Color '0072A3'
Style -Name 'Heading 6' -Size 9 -Color '0072A3'
Style -Name 'NO TOC Heading 6' -Size 9 -Color '0072A3'
Style -Name 'NO TOC Heading 7' -Size 7 -Color '0072A3' -Italic
Style -Name 'Normal' -Size 10 -Color '000000' -Default
# Header & Footer Styles
Style -Name 'Header' -Size 10 -Color '000000' -Align Left
Style -Name 'Footer' -Size 10 -Color '000000' -Align Right
# Table of Contents Style
Style -Name 'TOC' -Size 16 -Color '00785F'
# Table Heading & Row Styles
Style -Name 'TableDefaultHeading' -Size 10 -Color 'FAFAFA' -BackgroundColor '00785F' -Bold
Style -Name 'TableDefaultRow' -Size 10 -Color '000000'
Style -Name 'TableDefaultAltRow' -Size 10 -Color '000000' -BackgroundColor '47CA82'
# Table Row/Cell Highlight Styles
Style -Name 'Critical' -Size 10 -Color '000000' -BackgroundColor 'FEDDD7'
Style -Name 'Warning' -Size 10 -Color '000000' -BackgroundColor 'FFF4C7'
Style -Name 'Info' -Size 10 -Color '000000' -BackgroundColor 'E3F5FC'
Style -Name 'OK' -Size 10 -Color '000000' -BackgroundColor 'DFF0D0'
# Table Caption Style
Style -Name 'Caption' -Size 10 -Color '000000' -Align Left

# Default Table Style Properties
$TableDefaultProperties = @{
    Id = 'TableDefault'
    HeaderStyle = 'TableDefaultHeading'
    RowStyle = 'TableDefaultRow'
    AlternateRowStyle = 'TableDefaultAltRow'
    BorderColor = '00785F'
    Align = 'Left'
    CaptionStyle = 'Caption'
    CaptionLocation = 'Below'
    BorderWidth = 0.25
    PaddingTop = 1
    PaddingBottom = 1.5
    PaddingLeft = 2
    PaddingRight = 2
}

# Table Styles
TableStyle @TableDefaultProperties -Default
TableStyle -Id 'Borderless' -HeaderStyle Normal -RowStyle Normal -BorderWidth 0
TableStyle -Id 'CoverPage' -HeaderStyle 'TableDefaultHeading' -RowStyle Normal -BorderWidth 1 -BorderColor '00785F'

# Cover Page Layout
# Set Header & Footer, if enabled in report JSON configuration
if ($ReportConfig.Report.ShowHeaderFooter) {
    Header -Default {
        Paragraph -Style Header "$($ReportConfig.Report.Name) - v$($ReportConfig.Report.Version)"
    }

    Footer -Default {
        Paragraph -Style Footer 'Page <!# PageNumber #!> of <!# TotalPages #!>'
    }
}

# Show Logo image, if enabled in report JSON configuration
if ($ReportConfig.Report.ShowCoverPageImage) {
    Try {
        Image -Text 'Sample 2 Logo' -Align Left -Percent 30 -Base64 "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"
    } Catch {
        Write-PScriboMessage -IsWarning -Message "Cover page images are not supported for reports generated on Linux or macOS."
    }
}

# Add Report Name
# Position Report Name
BlankLine -Count 12
Paragraph -Style Title $ReportConfig.Report.Name

# Add Company Name if specified
if ($AsBuiltConfig.Company.FullName) {
    # Position Company Name
    BlankLine -Count 1
    Paragraph -Style Title2 $AsBuiltConfig.Company.FullName
}
PageBreak

# Add Custom Tables
# Document Control Table
Section -Style TOC -ExcludeFromTOC 'Document Control' {
    Table -Name 'Document Control' -List -ColumnWidths 30, 70 -Hashtable ([Ordered] @{
            'Title' = $ReportConfig.Report.Name
            'Author' = $AsBuiltConfig.Report.Author
            'Version' = $ReportConfig.Report.Version
            'Status' = $ReportConfig.Report.Status
            'Release Date' = (Get-Date).ToLongDateString()
        })
}

# Version Tracking Table
Section -Style TOC -ExcludeFromTOC 'Version Tracking' {
    Table -Name 'Version Tracking' -ColumnWidths 12, 22, 22, 22, 22 -Hashtable ([Ordered] @{
            'Version' = $ReportConfig.Report.Version
            'Remarks' = $AsBuiltConfig.Report.Status
            'Change Requested' = ""
            'Pages Affected' = ""
            'Released' = (Get-Date).ToLongDateString()
        })
}
PageBreak

# Add Table of Contents
if ($ReportConfig.Report.ShowTableOfContents) {
    TOC -Name 'Table of Contents'
    PageBreak
}