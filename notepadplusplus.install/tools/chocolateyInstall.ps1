$ErrorActionPreference = 'Stop'

$packageName = 'notepadplusplus'
$url = 'https://notepad-plus-plus.org/repository/7.x/7.3.3/npp.7.3.3.Installer.exe'
$checksum = '0a55e43108b289e6d9aff14d5ed0204e5eca6468'
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
