$ErrorActionPreference = 'Stop'

$packageName = 'notepadplusplus'
$url = 'https://notepad-plus-plus.org/repository/7.x/7.4.1/npp.7.4.1.bin.7z'
$checksum = '4c953575dc6c4144a19956983273feabb6cab022'
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

$urlExtra = 'https://notepad-plus-plus.org/repository/7.x/7.4.1/npp.7.4.1.Installer.exe'
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
