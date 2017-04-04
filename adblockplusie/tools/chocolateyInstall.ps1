$ErrorActionPreference = 'Stop'

$packageName = 'adblockplusie'
$url = 'https://downloads.adblockplus.org/devbuilds/adblockplusie/adblockplusie-1.5.856.exe'

$packageArgs = @{
    packageName = $packageName
    url = $url
    silentArgs = '/SILENT /NORESTART'
    validExitCodes = @(0)
}
Install-ChocolateyPackage @packageArgs
Get-ChildItem $toolsPath -Include "*.exe" -File -Recurse | ForEach-Object { New-Item "$($_.FullName).ignore" -Type file -Force | Out-Null }