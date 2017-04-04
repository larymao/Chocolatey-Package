$ErrorActionPreference = 'Stop'

$packageName  = 'reflector'
$url          = 'https://download.red-gate.com/checkforupdates/NETReflectorDesktop/NETReflectorDesktop_9.0.2.546.exe'

$packageArgs = @{
	packageName    = $packageName
	url            = $url
	silentArgs     = '/IAgreeToTheEULA RG_PRUR_ENABLED=1'
	validExitCodes = @(0)
}
Install-ChocolateyPackage @packageArgs
Get-ChildItem $toolsPath -Include "*.exe" -File -Recurse | ForEach-Object { New-Item "$($_.FullName).ignore" -Type file -Force | Out-Null }
