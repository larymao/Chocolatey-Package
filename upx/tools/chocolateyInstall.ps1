$packageName  = 'upx'
$url          = 'https://github.com/upx/upx/releases/download/v3.93/upx393w.zip'
$checksum     = 'e1f21726740b466379c8109daaecb83b7ec7588b698aa958c977235aae50fe56'
$checksumType = 'sha256'
$toolsPath    = $(Split-Path -parent $MyInvocation.MyCommand.Definition)

$packageArgs = @{
	packageName    = $packageName
	url            = $url
	checksum       = $checksum
	checksumType   = $checksumType
	unzipLocation  = $toolsPath
}

Install-ChocolateyZipPackage @packageArgs
