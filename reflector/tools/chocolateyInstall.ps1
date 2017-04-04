$ErrorActionPreference = 'Stop'

$packageName  = 'reflector'
$url          = 'https://download.red-gate.com/checkforupdates/NETReflectorDesktop/NETReflectorDesktop_9.0.2.546.exe'
$checksum     = '8a2bbbe31375bdf260f1aeb1699c5a86691e547a07cdec27c1ead73a7ed7bf9a'
$checksumType = 'sha256'

$packageArgs = @{
	packageName    = $packageName
	url            = $url
	checksum       = $checksum
	checksumType   = $checksumType
	silentArgs     = '/IAgreeToTheEULA RG_PRUR_ENABLED=1'
	validExitCodes = @(0)
}
Install-ChocolateyPackage @packageArgs

Get-ChildItem $toolsPath -Include "*.exe" -File -Recurse | ForEach-Object { New-Item "$($_.FullName).ignore" -Type file -Force | Out-Null }
