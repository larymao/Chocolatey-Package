$packageName = 'upx'
$url = 'https://github.com/upx/upx/releases/download/v3.94/upx394w.zip'
$toolsPath = $(Split-Path -parent $MyInvocation.MyCommand.Definition)

$packageArgs = @{
    packageName = $packageName
    url = $url
    checksum = $checksum
    checksumType = $checksumType
    unzipLocation = $toolsPath
}
Install-ChocolateyZipPackage @packageArgs
