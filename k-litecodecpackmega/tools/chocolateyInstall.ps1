$ErrorActionPreference = 'Stop'

$packageName  = 'k-litecodecpackmega'
$url          = 'http://files2.codecguide.com/K-Lite_Codec_Pack_1333_Mega.exe'
$checksum     = '41e3984aa2db587c301d56e48310268b610f67905497654f71774b0698976699'
$checksumType = 'sha256'

$packageArgs = @{
	packageName    = $packageName
	url            = $url
	checksum       = $checksum
	checksumType   = $checksumType
	silentArgs     = '/VERYSILENT'
	validExitCodes = @(0)
}
Install-ChocolateyPackage @packageArgs
