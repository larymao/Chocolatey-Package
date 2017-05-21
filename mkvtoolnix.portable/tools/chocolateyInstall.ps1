$ErrorActionPreference = 'Stop'

$packageName    = 'mkvtoolnix.portable'
$url32          = 'https://mkvtoolnix.download/windows/releases/12.0.0/mkvtoolnix-32bit-12.0.0.7z'
$url64          = 'https://mkvtoolnix.download/windows/releases/12.0.0/mkvtoolnix-64bit-12.0.0.7z'
$checksum32     = '4c9327b01ed46cfc75a6e80dacb2eba6ebf521b4'
$checksumType32 = 'sha1'
$checksum64     = '64bf269080078b54a57cf1a5514124df19228a13'
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
