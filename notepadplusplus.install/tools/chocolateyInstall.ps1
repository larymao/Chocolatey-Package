$ErrorActionPreference = 'Stop'

$packageName = 'notepadplusplus'
$url = 'https://notepad-plus-plus.org/repository/7.x/7.4/npp.7.4.Installer.exe'
$checksum = '378acfa0a7b65a41fbe7542f4a47d008a3574f3b'
$checksumType = 'sha1'
$toolsPath = Join-Path $(Get-ToolsLocation) $packageName

$packageArgs = @{
    packageName = $packageName
    url = $url
    checksum = $checksum
    checksumType = $checksumType
    silentArgs = "/S /D=`"$toolsPath`""
    validExitCodes = @(0)
}
Install-ChocolateyPackage @packageArgs
