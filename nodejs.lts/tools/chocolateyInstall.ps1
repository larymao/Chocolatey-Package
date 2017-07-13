$ErrorActionPreference = 'Stop';

$packageName = 'nodejs'
$url32 = 'https://npm.taobao.org/mirrors/node/v6.11.1/node-v6.11.1-win-x86.7z'
$checksum32 = '117bdeec7008492e2b313b637773375f07bf9582d13083566d3ad5e089f30875'
$checksumType32 = 'sha256'
$url64 = 'https://npm.taobao.org/mirrors/node/v6.11.1/node-v6.11.1-win-x64.7z'
$checksum64 = '22adcce6cbf2e40a879906be662f1818073f4668964d3b4ce544da56c17051f9'
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
