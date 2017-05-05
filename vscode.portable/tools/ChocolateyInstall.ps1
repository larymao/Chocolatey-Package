$ErrorActionPreference = 'Stop'

$packageName = 'vscode.portable'
$url = 'https://vscode.cdn.azure.cn/stable/f6868fce3eeb16663840eb82123369dec6077a9b/VSCode-win32-1.12.1.zip'
$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
    packageName = $packageName
    url = $url
    unzipLocation = $toolsPath
}

Install-ChocolateyZipPackage @packageArgs
Get-ChildItem $toolsPath -Include "*.exe" -Exclude "Code.exe" -Recurse | ForEach-Object { New-Item "$($_.FullName).ignore" -Type file -Force | Out-Null }
