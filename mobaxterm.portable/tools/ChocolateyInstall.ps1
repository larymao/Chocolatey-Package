﻿$ErrorActionPreference = 'Stop'

$PackageName = 'mobaxterm'
$Url = 'https://download.mobatek.net/10420170816103227/MobaXterm_Portable_v10.4.zip'
$InstallationPath = Join-Path $(Get-ToolsLocation) $PackageName

$PackageArgs = @{
    PackageName   = $PackageName
    url           = $Url
    UnzipLocation = $InstallationPath
}
Install-ChocolateyZipPackage @PackageArgs
$BinFileName = (Get-ChildItem -Path $InstallationPath -Filter "*.exe" -File | Select-Object -Last 1).FullName
Install-ChocolateyShortcut -ShortcutFilePath "$Env:SystemDrive\Users\Public\Desktop\MobaXterm.lnk" -TargetPath $BinFileName