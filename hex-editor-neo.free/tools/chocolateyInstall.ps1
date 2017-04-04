$ErrorActionPreference = 'Stop'

$packageName  = 'hex-editor-neo.free'
$url          = 'https://www.hhdsoftware.com/Download/free-hex-editor-neo.exe'
$toolsPath    = Split-Path -parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
	packageName    = $packageName
	url            = $url
	silentArgs     = "-portable -prop `"INSTALLDIR=$toolsPath`" -silent"
	validExitCodes = @(0)
}
Install-ChocolateyPackage @packageArgs

Get-ChildItem $toolsPath -Include "*.exe" -Exclude "HexFrame.exe" -File -Recurse | ForEach-Object { New-Item "$($_.FullName).ignore" -Type file -Force | Out-Null }
Start-ChocolateyProcessAsAdmin -WorkingDirectory $toolsPath -ExeToRun $(Join-Path $toolsPath "patch.exe")