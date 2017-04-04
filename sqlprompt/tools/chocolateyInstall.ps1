$ErrorActionPreference = 'Stop'

$packageName  = 'sqlprompt'
$url          = 'https://download.red-gate.com/checkforupdates/SQLPrompt/SQLPrompt_7.5.0.912.exe'
$checksum     = 'f3b464112d274018ca379c4131ccb285708604a4c2901825f92ceb84954a5c94'
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

Stop-Service -Name "RedgateClient" -Force
Set-Service -Name "RedgateClient" -StartupType Disabled

Get-ChildItem $toolsPath -Include "*.exe" -File -Recurse | ForEach-Object { New-Item "$($_.FullName).ignore" -Type file -Force | Out-Null }
