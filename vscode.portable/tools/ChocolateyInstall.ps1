$ErrorActionPreference = 'Stop'

$packageName = 'vscode.portable'
$url = 'https://az764295.vo.msecnd.net/stable/9122ec4b1068bd391e41974f46a4b54c1b9c90f9/VSCode-win32-1.11.0.zip'
$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
    packageName = $packageName
    url = $url
    unzipLocation = $toolsPath
}

Install-ChocolateyZipPackage @packageArgs
Get-ChildItem $toolsPath -Include "*.exe" -Exclude "Code.exe" -Recurse | ForEach-Object { New-Item "$($_.FullName).ignore" -Type file -Force | Out-Null }
