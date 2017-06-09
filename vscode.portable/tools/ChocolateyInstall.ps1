$ErrorActionPreference = 'Stop'

$packageName = 'vscode.portable'
$url = 'https://vscode.cdn.azure.cn/stable/376c52b955428d205459bea6619fc161fc8faacf/VSCode-win32-ia32-1.13.0.zip'
$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
    packageName = $packageName
    url = $url
    unzipLocation = $toolsPath
}

Install-ChocolateyZipPackage @packageArgs
Get-ChildItem $toolsPath -Include "*.exe" -Exclude "Code.exe" -Recurse | ForEach-Object { New-Item "$($_.FullName).ignore" -Type file -Force | Out-Null }
