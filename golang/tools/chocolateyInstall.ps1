$ErrorActionPreference = 'Stop';

$packageName = 'golang'
$url32 = 'https://storage.googleapis.com/golang/go1.8.3.windows-386.zip'
$checksum32 = '9e2bfcb8110a3c56f23b91f859963269bc29fd114190fecfd0a539395272a1c7'
$checksumType32 = 'SHA256'
$url64 = 'https://storage.googleapis.com/golang/go1.8.3.windows-amd64.zip'
$checksum64 = 'de026caef4c5b4a74f359737dcb2d14c67ca45c45093755d3b0d2e0ee3aafd96'
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
