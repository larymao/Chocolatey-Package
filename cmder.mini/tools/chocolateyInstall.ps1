$ErrorActionPreference = 'Stop'

$packageName  = 'cmder'
$url          = 'https://github.com/cmderdev/cmder/releases/download/v1.3.2/cmder_mini.zip'
$toolsPath    = Join-Path $(Get-ToolsLocation) $packageName

$packageArgs = @{
    packageName   = $packageName
    url           = $url
    unzipLocation = $toolsPath
}
Install-ChocolateyZipPackage @packageArgs
Install-ChocolateyPath $toolsPath 'Machine'
