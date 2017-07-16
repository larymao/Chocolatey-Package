$ErrorActionPreference = 'Stop'

$packageName = 'rdpwrapper'
$url = 'https://github.com/stascorp/rdpwrap/releases/download/v1.6.1/RDPWrap-v1.6.1.zip'
$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
    packageName = $packageName
    url = $url
    unzipLocation = $toolsPath
}

Install-ChocolateyZipPackage @packageArgs
