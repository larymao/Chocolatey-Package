$ErrorActionPreference = 'Stop'

$packageName = 'filevista'
$url = 'https://www.gleamtech.com/downloads/FileVista-v7.10.0.0-Installer.zip'
$toolsPath = Split-Path -parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
    packageName = $packageName
    url = $url
    url64 = $url
    unzipLocation = $toolsPath
}
Install-ChocolateyZipPackage @packageArgs

$packageArgs = @{
    packageName = $packageName
    url = Join-Path "${toolsPath}" "FileVista-v${version}.exe"
    url64 = Join-Path "${toolsPath}" "FileVista-v${version}.exe"
    validExitCodes = @(0)
}
Install-ChocolateyPackage @packageArgs
Get-ChildItem $toolsPath -Include "*.exe" -File -Recurse | ForEach-Object { New-Item "$($_.FullName).ignore" -Type file -Force | Out-Null }
