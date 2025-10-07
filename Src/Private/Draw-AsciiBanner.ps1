function Draw-AsciiBanner {
    <#
    .SYNOPSIS
        Draws a decorative ASCII banner box around text for console output.
    .DESCRIPTION
        Draws a decorative ASCII banner box with rounded corners around one or more lines of text.
        Uses Unicode box-drawing characters for a clean, modern appearance in the console.
        Supports customizable text and border colors, and adjustable padding.
        Properly handles double-width characters (CJK, emoji, etc.) for correct alignment.
    .PARAMETER Lines
        An array of strings to display inside the banner. Each string will be centered on its own line.
    .PARAMETER TextColor
        The color to use for the text content. Accepts standard PowerShell console colors.
    .PARAMETER BorderColor
        The color to use for the border characters. Accepts standard PowerShell console colors.
    .PARAMETER ExtraPadding
        The number of additional spaces to add on each side of the content for padding.
        Default is 2 spaces.
    .EXAMPLE
        Draw-AsciiBanner -Lines @("Welcome", "AsBuiltReport") -TextColor 'Cyan' -BorderColor 'Cyan'

        Displays a cyan-colored banner with "Welcome" and "AsBuiltReport" centered on separate lines.
    .EXAMPLE
        Draw-AsciiBanner -Lines @("Configuration") -TextColor 'Green' -BorderColor 'Yellow' -ExtraPadding 5

        Displays a banner with green text and yellow border, with extra padding of 5 spaces on each side.
    .NOTES
        This is a private function used internally by the AsBuiltReport.Core module.
        Uses Unicode box-drawing characters (U+256D, U+256E, U+2570, U+256F, U+2500, U+2502) for PS 5.1 compatibility.
        Calculates display width accounting for double-width characters (CJK ideographs, full-width forms, etc.).
    #>
    param(
        [string[]]$Lines,
        [string]$TextColor,
        [string]$BorderColor,
        [int]$ExtraPadding = 2
    )

    # Helper function to calculate display width of a string
    # Accounts for double-width characters (CJK, emoji, etc.)
    function Get-DisplayWidth {
        param([string]$Text)

        $width = 0
        foreach ($char in $Text.ToCharArray()) {
            $codePoint = [int][char]$char

            # Check if character is double-width
            # CJK Unified Ideographs: U+4E00-U+9FFF
            # CJK Extension A: U+3400-U+4DBF
            # Hangul Syllables: U+AC00-U+D7AF
            # Hiragana/Katakana: U+3040-U+30FF
            # Full-width Forms: U+FF00-U+FFEF
            # CJK Symbols and Punctuation: U+3000-U+303F
            if (($codePoint -ge 0x4E00 -and $codePoint -le 0x9FFF) -or
                ($codePoint -ge 0x3400 -and $codePoint -le 0x4DBF) -or
                ($codePoint -ge 0xAC00 -and $codePoint -le 0xD7AF) -or
                ($codePoint -ge 0x3040 -and $codePoint -le 0x30FF) -or
                ($codePoint -ge 0xFF00 -and $codePoint -le 0xFFEF) -or
                ($codePoint -ge 0x3000 -and $codePoint -le 0x303F)) {
                $width += 2
            } else {
                $width += 1
            }
        }
        return $width
    }

    # Calculate max display width across all lines
    $maxDisplayWidth = 0
    foreach ($line in $Lines) {
        $displayWidth = Get-DisplayWidth -Text $line
        if ($displayWidth -gt $maxDisplayWidth) {
            $maxDisplayWidth = $displayWidth
        }
    }

    $contentWidth = $maxDisplayWidth + ($ExtraPadding * 2)

    # Top and bottom borders - use Unicode code points for PS 5.1 compatibility
    $topLeft = [char]0x256D      # ╭
    $topRight = [char]0x256E     # ╮
    $bottomLeft = [char]0x2570   # ╰
    $bottomRight = [char]0x256F  # ╯
    $horizontal = [char]0x2500   # ─
    $vertical = [char]0x2502     # │

    $top = $topLeft + ($horizontal.ToString() * ($contentWidth + 2)) + $topRight
    $bottom = $bottomLeft + ($horizontal.ToString() * ($contentWidth + 2)) + $bottomRight

    Write-Host $top -ForegroundColor $BorderColor
    foreach ($line in $Lines) {
        $lineDisplayWidth = Get-DisplayWidth -Text $line
        $totalPadding = $contentWidth - $lineDisplayWidth
        $leftPad  = [math]::Floor($totalPadding / 2)
        $rightPad = $totalPadding - $leftPad
        $padded = (' ' * $leftPad) + $line + (' ' * $rightPad)
        Write-Host "$vertical " -NoNewline -ForegroundColor $BorderColor
        Write-Host $padded -NoNewline -ForegroundColor $TextColor
        Write-Host " $vertical" -ForegroundColor $BorderColor
    }
    Write-Host $bottom -ForegroundColor $BorderColor
}
