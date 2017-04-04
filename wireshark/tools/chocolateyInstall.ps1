$ErrorActionPreference = 'Stop'

$packageName = 'wireshark'
$url32 = 'https://www.wireshark.org/download/win32/Wireshark-win32-2.2.5.exe'
$checksum32 = 'a99a8cc1df24b31ab9ad963c2d1133982e0e9f2b33e8bfab8ac313c16e432da3'
$checksumType32 = 'SHA256'
$url64 = 'https://www.wireshark.org/download/win64/Wireshark-win64-2.2.5.exe'
$checksum64 = 'ab2723ba25dcf1e2f60faa579c1cad3e88ebcf53cf1a2a6897094b9f447fb864'
$checksumType64 = 'SHA256'
$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
    packageName = $packageName
    url = $url32
    checksum = $checksum32
    checksumType = $checksumType32
    url64 = $url64
    checksum64 = $checksum64
    checksumType64 = $checksumType64
    silentArgs = '/S'
    registryUninstallerKey = $packageName
}
Install-ChocolateyPackage @packageArgs
