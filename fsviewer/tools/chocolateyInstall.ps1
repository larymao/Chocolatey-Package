$ErrorActionPreference = 'Stop';

$packageName = 'fsviewer'
$url = 'http://www.faststonesoft.net/DN/FSViewer62.zip'
$toolsPath = Join-Path $(Get-ToolsLocation) $packageName

$packageArgs = @{
    packageName   = $packageName
    url           = $url
    unzipLocation = $toolsPath
}
Install-ChocolateyZipPackage @packageArgs

$dir = $(Get-ChildItem -Directory $(Join-Path $toolsPath "FSViewer*"))
$files = Join-Path $dir "*"
Move-Item $files $toolsPath -Force
if (Test-Path $dir) {
    Remove-Item $dir -Force -Recurse
}
