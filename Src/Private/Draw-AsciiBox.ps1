function Draw-AsciiBox {
    param(
        [string[]]$Lines,
        [string]$TextColor,
        [string]$BorderColor,
        [int]$ExtraPadding = 2
    )

    $maxLen = ($Lines | Measure-Object Length -Maximum).Maximum
    $contentWidth = $maxLen + ($ExtraPadding * 2)

    # Top and bottom borders
    $top    = "╭" + ("─" * ($contentWidth + 2)) + "╮"
    $bottom = "╰" + ("─" * ($contentWidth + 2)) + "╯"

    Write-Host $top -ForegroundColor $BorderColor
    foreach ($line in $Lines) {
        $totalPadding = $contentWidth - $line.Length
        $leftPad  = [math]::Floor($totalPadding / 2)
        $rightPad = $totalPadding - $leftPad
        $padded = (" " * $leftPad) + $line + (" " * $rightPad)
        Write-Host "│ " -NoNewline -ForegroundColor $BorderColor
        Write-Host $padded -NoNewline -ForegroundColor $TextColor
        Write-Host " │" -ForegroundColor $BorderColor
    }
    Write-Host $bottom -ForegroundColor $BorderColor
}