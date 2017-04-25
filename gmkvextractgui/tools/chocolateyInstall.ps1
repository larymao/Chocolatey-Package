﻿$ErrorActionPreference = 'Stop'

$packageName = 'gmkvextractgui'
$url = 'https://sourceforge.net/projects/gmkvextractgui/files/v1.9.2/gMKVExtractGUI.v1.9.2.7z/download'
$toolsPath = Split-Path -parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
    packageName = $packageName
    url = $url
    unzipLocation = $toolsPath
}
Install-ChocolateyZipPackage @packageArgs
