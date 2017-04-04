$ErrorActionPreference = 'Stop';

$packageName    = 'golang'
$url32          = 'https://storage.googleapis.com/golang/go1.8.windows-386.zip'
$checksum32     = 'b8199a4af9327807803d2892268dfbffb615f98d717cd824833a97e77f981f46'
$checksumType32 = 'SHA256'
$url64          = 'https://storage.googleapis.com/golang/go1.8.windows-amd64.zip'
$checksum64     = 'cb27fe210f3a9d10329d48514895d2a1e3651125a7c3c758f0358a5bfc0e3060'
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
Install-ChocolateyPath -PathToInstall "$gorootBin" -PathType 'Machine'
