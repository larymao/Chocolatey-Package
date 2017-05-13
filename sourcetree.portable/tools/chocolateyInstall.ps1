$ErrorActionPreference = 'Stop'

$packageName = 'sourcetree.portable'
$url = 'https://downloads.atlassian.com/software/sourcetree/windows/ga/SourceTreeSetup-2.0.20.1.exe'
$checksum = 'df4fb4abf3385f3a73ec47d83689af73f42367d01ff0afd394b50c1190e01d01'
$checksumType = 'sha256'
$toolsPath = Split-Path -parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
    packageName   = $packageName
    url           = $url
    unzipLocation = $toolsPath
}
Install-ChocolateyZipPackage @packageArgs

$filePath = Get-Item $(Join-Path $toolsPath "SourceTree*.nupkg")
$packageArgs = @{
    packageName   = $packageName
    url           = $filePath
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
