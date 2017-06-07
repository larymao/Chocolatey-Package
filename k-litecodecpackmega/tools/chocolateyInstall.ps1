$ErrorActionPreference = 'Stop'

$packageName  = 'k-litecodecpackmega'
$url          = 'http://files2.codecguide.com/K-Lite_Codec_Pack_1324_Mega.exe'
$checksum     = 'ae1fcffc4f5b7ababb0e0d83e9c6007c140354eb5ab1d8c47061e713a257f6e9'
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
