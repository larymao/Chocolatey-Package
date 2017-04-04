$ErrorActionPreference = 'Stop'

$packageName  = 'rdpwrapper'
$url          = 'https://github.com/stascorp/rdpwrap/releases/download/v1.6.1/RDPWrap-v1.6.1.zip'
$checksum     = 'fed08bd733b8e60b5805007bd01a7bf0d0b1993059bbe319d1179facc6b73361'
$checksumType = 'sha256'
$toolsPath    = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
	packageName    = $packageName
	url            = $url
	checksum       = $checksum
	checksumType   = $checksumType
	unzipLocation  = $toolsPath
}

Install-ChocolateyZipPackage @packageArgs
