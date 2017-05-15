﻿$ErrorActionPreference = 'Stop'

$packageName = 'notepadplusplus'
$url = 'https://notepad-plus-plus.org/repository/7.x/7.4/npp.7.4.bin.7z'
$checksum = '4d070ce5fe72d4ec65feec98dd63ce195eb344b1'
$checksumType = 'sha1'
$installationPath = Join-Path $(Get-ToolsLocation) $packageName
$toolsPath = Split-Path -parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
    packageName   = $packageName
    url           = $url
    checksum      = $checksum
    checksumType  = $checksumType
    unzipLocation = $installationPath
}
Install-ChocolateyZipPackage @packageArgs

$urlExtra = 'https://notepad-plus-plus.org/repository/7.x/7.4/npp.7.4.Installer.exe'
$fileName = [IO.Path]::GetFileName($urlExtra)
$installer = Join-Path $toolsPath $fileName
$packageArgs = @{
    url      = $urlExtra
    fileName = $installer
}
Get-WebFile @packageArgs
$content = 7z.exe l "$installer" "NppShell_*.dll"
$NppShellFileName = $content -split "\n| " -match "NppShell" | Select-Object -First 1
if (!(Test-Path $(Join-Path $installationPath $NppShellFileName))) {
    7z.exe e "$installer" -y -aos "$NppShellFileName" -o"$installationPath"
}
regsvr32.exe /s "$(Join-Path $installationPath $NppShellFileName)"
Remove-Item -Path $installer -Force
