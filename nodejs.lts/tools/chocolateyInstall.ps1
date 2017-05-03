$ErrorActionPreference = 'Stop';

$packageName = 'nodejs'
$url32 = 'https://npm.taobao.org/mirrors/node/v6.10.3/node-v6.10.3-win-x86.7z'
$checksum32 = 'd236ab5607a1cee6ef5f1a7ae1c1bfbe212218dd7d823ea2d57d12e3d3bf7cd8'
$checksumType32 = 'sha256'
$url64 = 'https://npm.taobao.org/mirrors/node/v6.10.3/node-v6.10.3-win-x64.7z'
$checksum64 = '86993d66c110592be3a4d4e78c5d386b17e1d8437cc6fa2a5a227369c1915a1e'
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
