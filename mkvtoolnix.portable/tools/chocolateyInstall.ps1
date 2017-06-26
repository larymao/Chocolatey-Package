$ErrorActionPreference = 'Stop'

$packageName    = 'mkvtoolnix.portable'
$url32          = 'https://mkvtoolnix.download/windows/releases/13.0.0/mkvtoolnix-32bit-13.0.0.7z'
$url64          = 'https://mkvtoolnix.download/windows/releases/13.0.0/mkvtoolnix-64bit-13.0.0.7z'
$checksum32     = '2fc70635ed248cf77e43295059eae94edca16678'
$checksumType32 = 'sha1'
$checksum64     = '747cdbb742861bce421a5b6660c8a4d8b71b04d9'
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
