$ErrorActionPreference = 'Stop'

$packageName = 'advanced-renamer.portable'
$url = 'https://www.advancedrenamer.com/down/advanced_renamer_portable.zip'
$toolsPath = Split-Path -parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
    packageName = $packageName
    url = $url
    unzipLocation = $toolsPath
}
Install-ChocolateyZipPackage @packageArgs
