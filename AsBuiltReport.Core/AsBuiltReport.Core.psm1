# Get public and private function definition files and dot source them
$Public = @(Get-ChildItem -Path $PSScriptRoot\Src\Public\*.ps1 -ErrorAction SilentlyContinue)
$Private = @(Get-ChildItem -Path $PSScriptRoot\Src\Private\*.ps1 -ErrorAction SilentlyContinue)

foreach ($Module in @($Public + $Private)) {
    try {
        . $Module.FullName
    } catch {
        Write-Error -Message "Failed to import function $($Module.FullName): $_"
    }
}

# Export public functions
Export-ModuleMember -Function $Public.BaseName

# Make helper functions available globally for report modules to use
# This keeps them out of the public API but accessible from report modules
$GlobalFunctions = @('Write-ReportModuleInfo', 'Get-RequiredModule')
foreach ($FunctionName in $GlobalFunctions) {
    if (Get-Command -Name $FunctionName -ErrorAction SilentlyContinue) {
        Set-Item -Path "Function:\Global:$FunctionName" -Value (Get-Command $FunctionName).ScriptBlock
    }
}
