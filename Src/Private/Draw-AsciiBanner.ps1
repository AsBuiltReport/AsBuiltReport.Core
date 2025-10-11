function Draw-AsciiBanner {
    <#
    .SYNOPSIS
        Draws a decorative banner with text for console output.
    .DESCRIPTION
        Draws a simple banner with horizontal line separators above and below text.
        Uses Unicode characters for a clean appearance that works reliably across all
        languages, scripts, and terminal types.
    .PARAMETER Lines
        An array of strings to display in the banner. Each string will be displayed on its own line.
    .PARAMETER TextColor
        The color to use for the text content. Accepts standard PowerShell console colors.
    .PARAMETER SeparatorColor
        The color to use for the separator lines. Accepts standard PowerShell console colors.
    .PARAMETER SeparatorLength
        The length of the separator lines. Default is 60 characters.
    .EXAMPLE
        Draw-AsciiBanner -Lines @("Welcome", "AsBuiltReport") -TextColor 'Cyan' -SeparatorColor 'Cyan'

        Displays a cyan-colored banner with "Welcome" and "AsBuiltReport" on separate lines.
    .EXAMPLE
        Draw-AsciiBanner -Lines @("Configuration") -TextColor 'Green' -SeparatorColor 'Yellow'

        Displays a banner with green text and yellow separator lines.
    .NOTES
        This is a private function used internally by the AsBuiltReport.Core module.
        Uses a simple horizontal line format that works reliably with all character sets.
    #>
    param(
        [string[]]$Lines,
        [string]$TextColor,
        [string]$SeparatorColor,
        [int]$SeparatorLength = 60
    )

    # Use heavy horizontal line character for visual separation
    $separator = [char]0x2500  # ─
    $separatorLine = $separator.ToString() * $SeparatorLength

    # Draw top separator
    Write-Host $separatorLine -ForegroundColor $SeparatorColor

    # Draw each line of text with padding
    foreach ($line in $Lines) {
        Write-Host "  $line" -ForegroundColor $TextColor
    }

    # Draw bottom separator
    Write-Host $separatorLine -ForegroundColor $SeparatorColor
}
