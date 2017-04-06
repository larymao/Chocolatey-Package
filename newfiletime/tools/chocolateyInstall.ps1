$ErrorActionPreference = 'Stop'

$packageName    = 'newfiletime'
$url32          = ''
$checksum32     = ''
$checksumType32 = ''
$url64          = ''
$checksum64     = ''
$checksumType64 = ''
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
