$ErrorActionPreference = 'Stop'

$PackageName = 'tesseract'
$Url = 'http://digi.bib.uni-mannheim.de/tesseract/tesseract-ocr-setup-3.05.01-20170602.exe'
$InstallationPath = Join-Path $(Get-ToolsLocation) $PackageName

$PackageArgs = @{
    PackageName   = $PackageName
    Url           = $Url
    UnzipLocation = $InstallationPath
}
Install-ChocolateyZipPackage @PackageArgs
Install-ChocolateyPath -PathToInstall $InstallationPath -PathType 'Machine'
Remove-Item -Path $(Join-Path $InstallationPath '`$PLUGINSDIR') -Recurse -Force
