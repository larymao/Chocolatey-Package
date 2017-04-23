$ErrorActionPreference = 'Stop'

$packageName    = 'mkvtoolnix.portable'
$url32          = 'https://mkvtoolnix.download/windows/releases/11.0.0/mkvtoolnix-32bit-11.0.0.7z'
$url64          = 'https://mkvtoolnix.download/windows/releases/11.0.0/mkvtoolnix-64bit-11.0.0.7z'
$checksum32     = '5a0bdeca438564197d34ba0e59841fe4d3ad7e22'
$checksumType32 = 'sha1'
$checksum64     = '5af05aa98ca669e0f57f0f245dcb19e9c2960f30'
$checksumType64 = 'sha1'
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
