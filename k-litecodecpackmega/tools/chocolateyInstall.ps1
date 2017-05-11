$ErrorActionPreference = 'Stop'

$packageName  = 'k-litecodecpackmega'
$url          = 'http://files2.codecguide.com/K-Lite_Codec_Pack_1316_Mega.exe'
$checksum     = 'b7a8e0009b42fb265a0b7f642a087b57f562671b4549019df0e05bc5da094d40'
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
