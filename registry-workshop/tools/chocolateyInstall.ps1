$ErrorActionPreference = 'Stop'

$packageName  = 'registry-workshop'
$url          = 'http://www.torchsoft.com/download/RegistryWorkshop_chs.exe'
$checksum     = 'cac833119633357a966e3b64b165da7fc10bf787efef8e1f9bb3029d7310a97e'
$checksumType = 'sha256'
$toolsPath    = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
    packageName    = $packageName
    url            = $url
    checksum       = $checksum
    checksumType   = $checksumType
    url64          = $url
    checksum64     = $checksum
    checksumType64 = $checksumType
    unzipLocation  = $toolsPath
}

Install-ChocolateyZipPackage @packageArgs
Remove-Item -Force -Path "$toolsPath\`$PLUGINSDIR" -Recurse
Remove-Item -Force -Path "$toolsPath\Uninstall.exe"
Get-ChildItem "$toolsPath" -Include "keygen.exe" -Recurse | ForEach-Object { New-Item "$($_.FullName).ignore" -Type file -Force | Out-Null }
if (!(Get-ProcessorBits 64)) {
    Get-ChildItem "$toolsPath" -File -Include "*64*.exe" -Recurse | ForEach-Object { New-Item "$($_.FullName).ignore" -Type file -Force | Out-Null }
}
