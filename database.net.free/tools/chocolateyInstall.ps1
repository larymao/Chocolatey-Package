$ErrorActionPreference = 'Stop'

$packageName  = 'database.net.free'
$url          = 'http://fishcodelib.com/files/DatabaseNet4.zip'
$checksum     = '7789137f847651aafab34075f4e67bf7a8d5db1d26a3422c6f6398973c87aa6b'
$checksumType = 'sha256'
$toolsPath    = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
    packageName    = $packageName
    url            = $url
    checksum       = $checksum
    checksumType   = $checksumType
    unzipLocation  = $toolsPath
}

Install-ChocolateyZipPackage @packageArgs

Get-ChildItem "$toolsPath" -Include "*.exe" -Recurse | ForEach-Object { New-Item "$($_.FullName).gui" -Type file -Force | Out-Null }
