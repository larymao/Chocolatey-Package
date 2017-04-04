$ErrorActionPreference = 'Stop'

$packageName    = 'fastcopy.portable'
$url32          = 'https://ipmsg.org/archive/FastCopy330.zip'
$checksum32     = 'c67bd82f9847d759b1fe114934ca724ead7f49a115764dff5473437a2bf5e926'
$checksumType32 = 'sha256'
$url64          = 'https://ipmsg.org/archive/FastCopy330_x64.zip'
$checksum64     = 'b66b8987d52d3d1a2cfad881f435d8d6cef48a9b72295ab2b2447b7550eec842'
$checksumType64 = 'sha256'
$toolsPath      = Split-Path -parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
	packageName    = $packageName
	url            = $url32
	checksum       = $checksum32
	checksumType   = $checksumType32
	url64          = $url64
	checksum64     = $checksum64
	checksumType64 = $checksumType64
	unzipLocation  = $toolsPath
}
Install-ChocolateyZipPackage @packageArgs
Get-ChildItem "$toolsPath" -File -Include "setup.exe" -Recurse | ForEach-Object { New-Item "$($_.FullName).ignore" -Type file -Force | Out-Null }
