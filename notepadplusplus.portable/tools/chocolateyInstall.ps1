$ErrorActionPreference = 'Stop'

$packageName    = 'notepadplusplus.portable'
$url32          = 'https://notepad-plus-plus.org/repository/7.x/7.3.3/npp.7.3.3.bin.7z'
$checksum32     = '90bdcecca69c4b3017d3a08834f4e8a2f44d2868'
$checksumType32 = 'sha1'
$toolsPath      = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
	packageName    = $packageName
	url            = $url32
	checksum       = $checksum32
	checksumType   = $checksumType32
	unzipLocation  = $toolsPath
}

Install-ChocolateyZipPackage @packageArgs

Get-ChildItem "$toolsPath" -Include "*.exe" -Exclude "notepad++.exe" -Recurse | ForEach-Object { New-Item "$($_.FullName).ignore" -Type file -Force | Out-Null }
regsvr32 $(Join-Path $toolsPath "NppShell_06.dll")
