$ErrorActionPreference = 'Stop'

$packageName = 'database.net.free'
$url = 'http://fishcodelib.com/files/DatabaseNet4.zip'
$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
    packageName = $packageName
    url = $url
    unzipLocation = $toolsPath
}

Install-ChocolateyZipPackage @packageArgs
Get-ChildItem $toolsPath -Include "*.exe" -Recurse | ForEach-Object { New-Item "$($_.FullName).gui" -Type file -Force | Out-Null }
