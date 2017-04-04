$ErrorActionPreference = 'Stop'

$packageName    = 'everything.portable'
$url32          = 'https://www.voidtools.com/Everything-1.4.1.809b.x86.zip'
$checksum32     = 'da8b29a23731f9c9354958fdcc59a17d'
$checksumType32 = 'md5'
$url64          = 'https://www.voidtools.com/Everything-1.4.1.809b.x64.zip'
$checksum64     = 'a527a9d01430ae76362b08a96624db65'
$checksumType64 = 'md5'
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
Invoke-WebRequest 'https://www.voidtools.com/es.exe' -OutFile "$toolsPath/es.exe"
