$ErrorActionPreference = 'Stop'

$packageName = 'x64dbg.portable'
$url = 'https://sourceforge.net/projects/x64dbg/files/snapshots/snapshot_2017-04-22_05-05.zip/download'
$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
    packageName = $packageName
    url = $url
    url64 = $url
    unzipLocation = $toolsPath
}
Install-ChocolateyZipPackage @packageArgs

if (!(Get-ProcessorBits 64) -and $env:chocolateyForceX86 -ne $True) {
    Get-ChildItem "$toolsPath" -File -Include "*64*.exe" -Recurse | ForEach-Object { New-Item "$($_.FullName).ignore" -Type file -Force | Out-Null }
}
