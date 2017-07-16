$ErrorActionPreference = 'Stop'

$packageName = 'subtitleedit.portable'
$url = 'https://github.com/SubtitleEdit/subtitleedit/releases/download/3.5.3/SE353.zip'
$checksum = '5f4979f887e6d1fedeb2ee67dad18eb42333b1f2'
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
