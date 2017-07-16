$ErrorActionPreference = 'Stop'

$packageName = 'fastcopy.portable'
$url32 = 'https://ipmsg.org/archive/FastCopy330.zip'
$url64 = 'https://ipmsg.org/archive/FastCopy330_x64.zip'
$toolsPath = Split-Path -parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
    packageName = $packageName
    url = $url32
    url64 = $url64
    unzipLocation = $toolsPath
}
Install-ChocolateyZipPackage @packageArgs
Get-ChildItem $toolsPath -File -Include "setup.exe" -Recurse | ForEach-Object { New-Item "$($_.FullName).ignore" -Type file -Force | Out-Null }
