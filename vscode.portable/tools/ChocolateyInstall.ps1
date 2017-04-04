$ErrorActionPreference = 'Stop'

$packageName = 'vscode.portable'
$url = 'https://az764295.vo.msecnd.net/stable/8076a19fdcab7e1fc1707952d652f0bb6c6db331/VSCode-win32-1.10.2.zip'
$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
    packageName = $packageName
    url = $url
    unzipLocation = $toolsPath
}

Install-ChocolateyZipPackage @packageArgs
Get-ChildItem $toolsPath -Include "*.exe" -Exclude "Code.exe" -Recurse | ForEach-Object { New-Item "$($_.FullName).ignore" -Type file -Force | Out-Null }
