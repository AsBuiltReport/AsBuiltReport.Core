function Draw-AsciiBanner {
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