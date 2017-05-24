$ErrorActionPreference = 'Stop';

$packageName = 'golang'
$url32 = 'https://storage.googleapis.com/golang/go1.8.2.windows-386.zip'
$checksum32 = '75e295f5cd0eb3236e68324ac51b9e54a1aad1fa3a3b259f62cc11e05d948aed'
$checksumType32 = 'SHA256'
$url64 = 'https://storage.googleapis.com/golang/go1.8.2.windows-amd64.zip'
$checksum64 = '9bfa4d497caee1b7ec8720acdea2fa8af8d51b525ddc7e4648a63a3138a6a8e3'
$checksumType64 = 'SHA256'
$installationPath = Get-ToolsLocation

$packageArgs = @{
    packageName    = $packageName
    url            = $url32
    checksum       = $checksum32
    checksumType   = $checksumType32
    url64          = $url64
    checksum64     = $checksum64
    checksumType64 = $checksumType64
    unzipLocation  = $installationPath
}
Install-ChocolateyZipPackage @packageArgs

$GOROOT = Join-Path $installationPath 'go'
$GOPATH = Join-Path $GOROOT 'opt'
$GOBIN = Join-Path $GOROOT 'bin'
Install-ChocolateyEnvironmentVariable -VariableName 'GOROOT' -VariableValue $GOROOT -VariableType 'Machine'
Install-ChocolateyEnvironmentVariable -VariableName 'GOPATH' -VariableValue $GOPATH -VariableType 'Machine'
Install-ChocolateyPath -PathToInstall $GOBIN -PathType 'Machine'
