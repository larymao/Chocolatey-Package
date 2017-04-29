$ErrorActionPreference = 'Stop'

$packageName = 'sourcetree.portable'
$url = 'https://downloads.atlassian.com/software/sourcetree/windows/ga/SourceTreeSetup-2.0.19.1.exe'
$toolsPath = Split-Path -parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
    packageName = $packageName
    url = $url
    unzipLocation = $toolsPath
}
Install-ChocolateyZipPackage @packageArgs

$filePath = Get-Item $(Join-Path $toolsPath "SourceTree*.nupkg")
$packageArgs = @{
    packageName = $packageName
    url = $filePath
    unzipLocation = $toolsPath
}
Install-ChocolateyZipPackage @packageArgs

Get-Item $(Join-Path $toolsPath "*") -Exclude "*.ps1", "lib" | Remove-Item -Force -Recurse
$files = Join-Path $(Get-Item $(Join-Path $toolsPath "lib\*")) "*"
Move-Item $files $toolsPath -Force
Remove-Item $(Join-Path $toolsPath "lib") -Force -Recurse

Get-ChildItem $toolsPath -Include "*.exe" -Exclude "SourceTree.exe" -File -Recurse | ForEach-Object { New-Item "$($_.FullName).ignore" -Type file -Force | Out-Null }
