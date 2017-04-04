$ErrorActionPreference = 'Stop'

$packageName    = 'newfiletime'
$url32          = 'http://www.softwareok.com/Download/NewFileTime.zip'
$url64          = 'http://www.softwareok.com/Download/NewFileTime_x64.zip'
$toolsPath      = Split-Path -parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
	packageName    = $packageName
	url            = $url32
	url64          = $url64
	unzipLocation  = $toolsPath
}

Install-ChocolateyZipPackage @packageArgs
