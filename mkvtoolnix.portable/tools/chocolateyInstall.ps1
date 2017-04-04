$ErrorActionPreference = 'Stop'

$packageName    = 'mkvtoolnix.portable'
$url32          = 'https://mkvtoolnix.download/windows/releases/10.0.0/mkvtoolnix-32bit-10.0.0.7z'
$url64          = 'https://mkvtoolnix.download/windows/releases/10.0.0/mkvtoolnix-64bit-10.0.0.7z'
$checksum32     = 'bf0507602faf1115818564139f60be6fb935f49d'
$checksumType32 = 'sha1'
$checksum64     = '84592cb6703deffc6a3ab852cc94858fc8215921'
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
