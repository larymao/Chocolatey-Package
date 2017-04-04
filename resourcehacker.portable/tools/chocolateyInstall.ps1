$ErrorActionPreference = 'Stop'

$packageName  = 'sqlitestudio.portable'
$url          = 'http://www.angusj.com/resourcehacker/resource_hacker.zip'
$checksum     = '2010fd5c5411838647d7fc5a2dedd29cbb600f5076e241bd8a2c3e2f6cba2469'
$checksumType = 'sha256'
$toolsPath    = Split-Path -parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
	packageName    = $packageName
	url            = $url
	checksum       = $checksum
	checksumType   = $checksumType
	unzipLocation  = $toolsPath
}

Install-ChocolateyZipPackage @packageArgs
