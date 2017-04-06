$ErrorActionPreference = 'Stop';

$packageName = 'nodejs'
$url32 = 'https://npm.taobao.org/mirrors/node/v6.10.2/node-v6.10.2-win-x86.7z'
$checksum32 = '4149533ef54039cef1e49eb5e41cbb1688e5509751a4f518b05d330e38dc5eea'
$checksumType32 = 'sha256'
$url64 = 'https://npm.taobao.org/mirrors/node/v6.10.2/node-v6.10.2-win-x64.7z'
$checksum64 = '08572d6714ab8e76cfac6211b63fcf2062ff443355be28a0f106d2cc05c45e46'
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