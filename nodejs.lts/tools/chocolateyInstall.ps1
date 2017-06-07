$ErrorActionPreference = 'Stop';

$packageName = 'nodejs'
$url32 = 'https://npm.taobao.org/mirrors/node/v6.11.0/node-v6.11.0-win-x86.7z'
$checksum32 = '9bed6a3ce1fba503e54ef8f49a109b515f2f872037304edcc4c04eda1fff215b'
$checksumType32 = 'sha256'
$url64 = 'https://npm.taobao.org/mirrors/node/v6.11.0/node-v6.11.0-win-x64.7z'
$checksum64 = '335f5918cbebaf5a819fe575eee0cb1646625a09709416bc293e837b660d1800'
$checksumType64 = 'sha256'
$toolsPath = $(Get-ToolsLocation)

$packageArgs = @{
    packageName = $packageName
    url = $url32
    checksum = $checksum32
    checksumType = $checksumType32
    url64 = $url64
    checksum64 = $checksum64
    checksumType64 = $checksumType64
    unzipLocation = $toolsPath
}
Install-ChocolateyZipPackage @packageArgs

$unzipPath = (Get-ChildItem $toolsPath -Directory | Where-Object Name -Like "node-*-win-x*" | Select-Object -First 1).FullName
$nodejsPath = Join-Path $toolsPath "nodejs"
Move-Item -Path $unzipPath -Destination $nodejsPath -Force
Install-ChocolateyPath -PathToInstall $nodejsPath -PathType 'Machine'
