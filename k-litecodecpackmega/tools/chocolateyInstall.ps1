$ErrorActionPreference = 'Stop'

$packageName  = 'k-litecodecpackmega'
$url          = 'http://files2.codecguide.com/K-Lite_Codec_Pack_1300_Mega.exe'
$checksum     = '49c08d091c4ce703df5200afa326a7d6f35977dc4ff72a5c9265ddb6e848897a'
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
