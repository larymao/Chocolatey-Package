$ErrorActionPreference = 'Stop'

$packageName = 'subtitleedit.portable'
$url = 'https://github.com/SubtitleEdit/subtitleedit/releases/download/3.5.2/SE352.zip'
$checksum = 'ae686d0a6ccbc425846692aa4290a13b5fdea628'
$checksumType = 'sha1'
$toolsPath = Split-Path -parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
    packageName = $packageName
    url = $url
    checksum = $checksum
    checksumType = $checksumType
    unzipLocation = $toolsPath
}

Install-ChocolateyZipPackage @packageArgs
Get-ChildItem "$toolsPath" -Include "*.exe" -Exclude "SubtitleEdit.exe" -Recurse  | ForEach-Object { New-Item "$($_.FullName).ignore" -Type file -Force | Out-Null }
