$ErrorActionPreference = 'Stop'

$packageName    = 'everything.portable'
$url32          = 'https://www.voidtools.com/Everything-1.4.1.867b.x86.zip'
$checksum32     = 'ebe915968d83ed40b56ad88bb4f358b4'
$checksumType32 = 'md5'
$url64          = 'https://www.voidtools.com/Everything-1.4.1.867b.x64.zip'
$checksum64     = 'cecaf07a245e99127acff1e0b1b19094'
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
