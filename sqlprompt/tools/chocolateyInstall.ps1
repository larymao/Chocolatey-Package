$ErrorActionPreference = 'Stop'

$packageName  = 'sqlprompt'
$url          = 'https://download.red-gate.com/checkforupdates/SQLPrompt/SQLPrompt_7.5.1.1000.exe'

$packageArgs = @{
	packageName    = $packageName
	url            = $url
	silentArgs     = '/IAgreeToTheEULA RG_PRUR_ENABLED=1'
	validExitCodes = @(0)
}
Install-ChocolateyPackage @packageArgs

Stop-Service -Name "RedgateClient" -Force
Set-Service -Name "RedgateClient" -StartupType Disabled

Get-ChildItem $toolsPath -Include "*.exe" -File -Recurse | ForEach-Object { New-Item "$($_.FullName).ignore" -Type file -Force | Out-Null }
