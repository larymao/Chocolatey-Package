$ErrorActionPreference = 'Stop'

$packageName  = 'x64dbg.portable'
$url          = 'https://sourceforge.net/projects/x64dbg/files/snapshots/snapshot_2017-04-02_03-17.zip/download'
$checksum     = '1a800758bab363f0298068a860723b613df07336ea29d312188835ec9c8391c1'
$checksumType = 'sha256'
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

if (!(Get-ProcessorBits 64) -and $env:chocolateyForceX86 -ne $True) {
    Get-ChildItem "$toolsPath" -File -Include "*64*.exe" -Recurse | ForEach-Object { New-Item "$($_.FullName).ignore" -Type file -Force | Out-Null }
}
