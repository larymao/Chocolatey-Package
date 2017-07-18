$ErrorActionPreference = 'Stop'

$packageName = 'sqlite-studio.portable'
$url = 'https://sqlitestudio.pl/files/sqlitestudio3/complete/win32/sqlitestudio-3.1.1.zip'
$toolsPath = Split-Path -parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
    packageName = $packageName
    url = $url
    checksum = $checksum
    checksumType = $checksumType
    unzipLocation = $toolsPath
}
Install-ChocolateyZipPackage @packageArgs
Get-ChildItem "$toolsPath" -Include "*.exe" -Exclude "SQLiteStudio.exe" -Recurse | ForEach-Object { New-Item "$($_.FullName).ignore" -Type file -Force | Out-Null }
