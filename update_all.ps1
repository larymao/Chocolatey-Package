$dirs = Get-ChildItem -Directory -Exclude ".git"
foreach ($dir in $dirs) {
    Set-Location $dir
    $ps1 = Join-Path $dir "update_all.ps1"
    if (Test-Path $ps1) {
        & $ps1
    }
}