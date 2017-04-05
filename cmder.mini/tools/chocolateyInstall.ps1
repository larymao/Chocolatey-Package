$ErrorActionPreference = 'Stop'

$packageName  = 'cmder'
$url          = 'https://github.com/cmderdev/cmder/releases/download/v1.3.2/cmder_mini.zip'
$checksum     = ''
$checksumType = 'md5'
$toolsPath    = Join-Path $(Get-ToolsLocation) $packageName

$packageArgs = @{
    packageName   = $packageName
    url           = $url
    checksum      = $checksum
    checksumType  = $checksumType
    unzipLocation = $toolsPath
}
Install-ChocolateyZipPackage @packageArgs
Install-ChocolateyPath $toolsPath 'Machine'
