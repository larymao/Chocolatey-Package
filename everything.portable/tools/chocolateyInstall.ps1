$ErrorActionPreference = 'Stop'

$packageName    = 'everything.portable'
$url32          = 'https://www.voidtools.com/Everything-1.4.1.877.x86.zip'
$checksum32     = '522a8c98336fd038f0b7643b17a88317'
$checksumType32 = 'md5'
$url64          = 'https://www.voidtools.com/Everything-1.4.1.877.x64.zip'
$checksum64     = 'bd63a317ba10623b3fc3406e7d448b63'
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
