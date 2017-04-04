$ErrorActionPreference = 'Stop'

$packageName  = 'filevista'
$url          = 'https://www.gleamtech.com/downloads/FileVista-v7.8.0.0-Installer.zip'
$checksum     = 'a1675da305cdd92eac2fd3ead81bfcd29f9126a4974ddd15dbcc515791b1ca63'
$checksumType = 'sha256'
$toolsPath    = Split-Path -parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
	packageName    = $packageName
	url            = $url
	checksum       = $checksum
	checksumType   = $checksumType
	url64          = $url
	checksum64     = $checksum
	checksum64Type = $checksumType
	unzipLocation  = $toolsPath
}
Install-ChocolateyZipPackage @packageArgs

Get-ChildItem "$toolsPath" -Include "*.exe" -Recurse | ForEach-Object { New-Item "$($_.FullName).ignore" -Type file -Force | Out-Null }

$packageArgs = @{
	packageName    = $packageName
	url            = Join-Path "${toolsPath}" "FileVista-v${version}.exe"
	url64          = Join-Path "${toolsPath}" "FileVista-v${version}.exe"
	validExitCodes = @(0)
}
Install-ChocolateyPackage @packageArgs

Get-ChildItem $toolsPath -Include "*.exe" -File -Recurse | ForEach-Object { New-Item "$($_.FullName).ignore" -Type file -Force | Out-Null }
