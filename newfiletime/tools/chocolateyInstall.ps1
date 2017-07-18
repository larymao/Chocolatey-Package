$ErrorActionPreference = 'Stop'

$packageName    = 'newfiletime'
$url32          = 'http://www.softwareok.com/Download/NewFileTime.zip'
$checksum32     = '2cc8a1aef8673cbfe4ed7fe40551330f2619c0e3de949a952a1a16013fba9a86'
$checksumType32 = 'sha256'
$url64          = 'http://www.softwareok.com/Download/NewFileTime_x64.zip'
$checksum64     = 'b1c7764dca7ec8db6c854c29b9280b5c41260b4d0dcc5e022ef0aa9b5a311e24'
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
