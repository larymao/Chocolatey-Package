$ErrorActionPreference = 'Stop'

$packageName  = 'battoexeconverter'
$url          = 'http://www.f2ko.de/downloads/Bat_To_Exe_Converter.zip'
$checksum     = '2d125a6a328ebfcc9ff5e6ddcb172565'
$checksumType = 'md5'
$toolsPath    = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
    packageName    = $packageName
    url            = $url
    checksum       = $checksum
    checksumType   = $checksumType
    url64          = $url
    checksum64     = $checksum
    checksumType64 = $checksumType
    unzipLocation  = $toolsPath
}

Install-ChocolateyZipPackage @packageArgs

Get-ChildItem "$toolsPath" -File -Include "*Setup*.exe" -Recurse | ForEach-Object { New-Item "$($_.FullName).ignore" -Type file -Force | Out-Null }
if (!(Get-ProcessorBits 64)) {
    Get-ChildItem "$toolsPath" -File -Include "*64*.exe" -Recurse | ForEach-Object { New-Item "$($_.FullName).ignore" -Type file -Force | Out-Null }
}
