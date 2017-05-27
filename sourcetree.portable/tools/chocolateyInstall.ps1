$ErrorActionPreference = 'Stop'

$packageName = 'sourcetree.portable'
$url = 'https://www.sourcetreeapp.com/update/windows/ga/SourceTree-2.1.2.3-full.nupkg'
$checksum = 'bf0b5d60bfaa6e87a37795cdd7946c427e818686'
$checksumType = 'sha1'
$toolsPath = Split-Path -parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
    packageName   = $packageName
    url           = $url
    checksum      = $checksum
    checksumType  = $checksumType
    unzipLocation = $toolsPath
}
Install-ChocolateyZipPackage @packageArgs

Get-Item $(Join-Path $toolsPath "*") -Exclude "*.ps1", "lib" | Remove-Item -Force -Recurse
$lib = Join-Path $toolsPath "lib"
$files = Join-Path $(Get-Item $(Join-Path $lib "net*")) "*"
Move-Item $files $toolsPath -Force
if (Test-Path $lib) {
    Remove-Item $lib -Force -Recurse
}

Get-ChildItem $toolsPath -Include "*.exe" -Exclude "SourceTree.exe" -File -Recurse | ForEach-Object { New-Item "$($_.FullName).ignore" -Type file -Force | Out-Null }
