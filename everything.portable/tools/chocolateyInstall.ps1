$ErrorActionPreference = 'Stop'

$packageName    = 'everything.portable'
$url32          = 'https://www.voidtools.com/Everything-1.4.1.873b.x86.zip'
$checksum32     = '350f0052ede86709da8c6deed2d2bae2'
$checksumType32 = 'md5'
$url64          = 'https://www.voidtools.com/Everything-1.4.1.873b.x64.zip'
$checksum64     = 'c8b1e540e3702369921a10f77d869a9a'
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
