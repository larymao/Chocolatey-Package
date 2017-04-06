$ErrorActionPreference = 'Stop'

$packageName    = 'newfiletime'
$url32          = 'http://www.softwareok.com/Download/NewFileTime.zip'
$checksum32     = 'df4fb4abf3385f3a73ec47d83689af73f42367d01ff0afd394b50c1190e01d01'
$checksumType32 = 'sha256'
$url64          = 'http://www.softwareok.com/Download/NewFileTime_x64.zip'
$checksum64     = '20f9f25ceb14acee961e4335538bdf68376a9207dcaef9aea10cf74bf962d1ac'
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
