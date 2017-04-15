$ErrorActionPreference = 'Stop';

$packageName = 'openssl'
$url32 = 'https://slproweb.com//download/Win32OpenSSL_Light-1_1_0e.exe'
$url64 = 'https://slproweb.com//download/Win32OpenSSL_Light-1_1_0e.exe'
$toolsPath = Join-Path $(Get-ToolsLocation) $packageName

$packageArgs = @{
    packageName = $packageName
    #InnoSetup - http://unattended.sourceforge.net/InnoSetup_Switches_ExitCodes.html
    silentArgs = '/silent', '/verysilent', '/sp-', '/suppressmsgboxes',
    "/DIR=`"$toolsPath`"";
    url = $url32
    url64bit = $url64
}
Install-ChocolateyPackage @packageArgs
