function Draw-AsciiBanner {
    <#
    .SYNOPSIS
        Draws a decorative ASCII banner box around text for console output.
    .DESCRIPTION
        Draws a decorative ASCII banner box with rounded corners around one or more lines of text.
        Uses Unicode box-drawing characters for a clean, modern appearance in the console.
        Supports customizable text and border colors, and adjustable padding.
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
    #>
    param(
        [string[]]$Lines,
        [string]$TextColor,
        [string]$BorderColor,
        [int]$ExtraPadding = 2
    )

    $maxLen = ($Lines | Measure-Object Length -Maximum).Maximum
    $contentWidth = $maxLen + ($ExtraPadding * 2)

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
        $totalPadding = $contentWidth - $line.Length
        $leftPad  = [math]::Floor($totalPadding / 2)
        $rightPad = $totalPadding - $leftPad
        $padded = (' ' * $leftPad) + $line + (' ' * $rightPad)
        Write-Host "$vertical " -NoNewline -ForegroundColor $BorderColor
        Write-Host $padded -NoNewline -ForegroundColor $TextColor
        Write-Host " $vertical" -ForegroundColor $BorderColor
    }
    Write-Host $bottom -ForegroundColor $BorderColor
}
