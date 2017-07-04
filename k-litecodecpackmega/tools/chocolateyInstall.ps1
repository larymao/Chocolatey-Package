$ErrorActionPreference = 'Stop'

$packageName  = 'k-litecodecpackmega'
$url          = 'http://files2.codecguide.com/K-Lite_Codec_Pack_1330_Mega.exe'
$checksum     = '81506626b082cf33be54470d751e585aee29964e8c445693428ab370a67eb8a5'
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
