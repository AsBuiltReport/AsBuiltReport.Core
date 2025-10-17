# culture = 'en-US'
ConvertFrom-StringData @'
    Footer = Page <!# PageNumber #!>
    Logo = AsBuiltReport Logo
    CoverPageWarning = Unable to display cover page image. Please set 'ShowCoverPageImage' to 'false' in the report JSON configuration file to avoid this error.
    CoverPage = Cover Page
    Author = Author:
    Date = Date:
    Version = Version:
    TOC = Table of Contents
'@