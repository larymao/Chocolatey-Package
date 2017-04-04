$ErrorActionPreference = 'Stop'

$packageName  = 'hex-editor-neo.free'
$url          = 'https://www.hhdsoftware.com/Download/free-hex-editor-neo.exe'
$checksum     = '7693f631f9e89cf5e266b65fea3c3f37b3c3ec54b3c637a6ce1134c57d245aec'
$checksumType = 'sha256'
$toolsPath    = Split-Path -parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
	packageName    = $packageName
	url            = $url
	checksum       = $checksum
	checksumType   = $checksumType
	silentArgs     = "-portable -prop `"INSTALLDIR=$toolsPath`" -silent"
	validExitCodes = @(0)
}
Install-ChocolateyPackage @packageArgs

Get-ChildItem $toolsPath -Include "*.exe" -Exclude "HexFrame.exe" -File -Recurse | ForEach-Object { New-Item "$($_.FullName).ignore" -Type file -Force | Out-Null }
Start-ChocolateyProcessAsAdmin -WorkingDirectory $toolsPath -ExeToRun $(Join-Path $toolsPath "patch.exe")