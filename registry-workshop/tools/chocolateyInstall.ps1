$ErrorActionPreference = 'Stop'

$packageName = 'registry-workshop'
$url = 'http://www.torchsoft.com/download/RegistryWorkshop_chs.exe'
$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
    packageName = $packageName
    url = $url
    url64 = $url
    unzipLocation = $toolsPath
}

Install-ChocolateyZipPackage @packageArgs
Remove-Item -Force -Path "$toolsPath\`$PLUGINSDIR" -Recurse
Remove-Item -Force -Path "$toolsPath\Uninstall.exe"
Get-ChildItem "$toolsPath" -Include "keygen.exe" -Recurse | ForEach-Object { New-Item "$($_.FullName).ignore" -Type file -Force | Out-Null }
if (!(Get-ProcessorBits 64)) {
    Get-ChildItem "$toolsPath" -File -Include "*64*.exe" -Recurse | ForEach-Object { New-Item "$($_.FullName).ignore" -Type file -Force | Out-Null }
}
