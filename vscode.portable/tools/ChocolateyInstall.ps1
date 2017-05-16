$ErrorActionPreference = 'Stop'

$packageName = 'vscode.portable'
$url = 'https://vscode.cdn.azure.cn/stable/19222cdc84ce72202478ba1cec5cb557b71163de/VSCode-win32-1.12.2.zip'
$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
    packageName = $packageName
    url = $url
    unzipLocation = $toolsPath
}

Install-ChocolateyZipPackage @packageArgs
Get-ChildItem $toolsPath -Include "*.exe" -Exclude "Code.exe" -Recurse | ForEach-Object { New-Item "$($_.FullName).ignore" -Type file -Force | Out-Null }
