$ErrorActionPreference = 'Stop'

$packageName = 'winpcap'
$url = 'https://www.winpcap.org/install/bin/WinPcap_4_1_3.exe'
$checksumType = 'sha1'
$checksum = 'e2516fcd1573e70334c8f50bee5241cdfdf48a00'

$packageArgs = @{
    packageName    = $packageName
    url            = $url
    checksum       = $checksum
    checksumType   = $checksumType
    validExitCodes = @(0)
}
Install-ChocolateyPackage @packageArgs
