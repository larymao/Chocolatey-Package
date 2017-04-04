$ErrorActionPreference = 'Stop'

$packageName  = 'sqlite-studio.portable'
$url          = 'https://sqlitestudio.pl/files/sqlitestudio3/complete/win32/sqlitestudio-3.1.1.zip'
$checksum     = 'ddcaae8f6579de62174337f50e3a64a6f2112b8189796a7902933dd1bbe140ac'
$checksumType = 'sha256'
$toolsPath    = Split-Path -parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
	packageName    = $packageName
	url            = $url
	checksum       = $checksum
	checksumType   = $checksumType
	unzipLocation  = $toolsPath
}

Install-ChocolateyZipPackage @packageArgs

Get-ChildItem "$toolsPath" -Include "*.exe" -Exclude "SQLiteStudio.exe" -Recurse | ForEach-Object { New-Item "$($_.FullName).ignore" -Type file -Force | Out-Null }
