$ErrorActionPreference = 'Stop'

$packageName = 'sqlitestudio.portable'
$url = 'http://www.angusj.com/resourcehacker/resource_hacker.zip'
$toolsPath = Split-Path -parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
    packageName = $packageName
    url = $url
    unzipLocation = $toolsPath
}
Install-ChocolateyZipPackage @packageArgs
