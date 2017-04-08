$ErrorActionPreference = 'Stop';

$packageName    = 'golang'
$url32          = 'https://storage.googleapis.com/golang/go1.8.1.windows-386.zip'
$checksum32     = '9738365e64d4d80ea54487915c9bfc0c3bbaa7d68ec78487988f80ebe8129c57'
$checksumType32 = 'SHA256'
$url64          = 'https://storage.googleapis.com/golang/go1.8.1.windows-amd64.zip'
$checksum64     = 'bb6f0fbef8b80c382455af8699bfbb7fe89256d4baf06d927feaeceb7342e4ee'
$checksumType64 = 'SHA256'
$toolsPath      = $env:ChocolateyToolsLocation

$packageArgs = @{
	packageName    = $packageName
	url            = $url32
	checksum       = $checksum32
	checksumType   = $checksumType32
	url64          = $url64
	checksum64     = $checksum64
	checksumType64 = $checksumType64
	unzipLocation  = $toolsPath
}
Install-ChocolateyZipPackage @packageArgs

$goroot = Join-Path "$toolsPath" 'go'
$gopath = Join-Path "$goroot" 'opt'
$gorootBin = Join-Path "$goroot" 'bin'
Install-ChocolateyEnvironmentVariable -VariableName 'GOROOT' -VariableValue "$goroot" -VariableType 'Machine'
Install-ChocolateyEnvironmentVariable -VariableName 'GOPATH' -VariableValue "$gopath" -VariableType 'Machine'
Install-ChocolateyPath -PathToInstall $gorootBin -PathType 'Machine'
