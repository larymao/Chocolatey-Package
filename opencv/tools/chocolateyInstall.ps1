$ErrorActionPreference = 'Stop'

$packageName = 'opencv'
$url64 = ''
$installationPath = Get-ToolsLocation

$packageArgs = @{
    packageName = $packageName
    url64 = $url64
    unzipLocation = $installationPath
}
Install-ChocolateyZipPackage @packageArgs

$envPath = [Environment]::GetEnvironmentVariable('Path', [EnvironmentVariableTarget]::Machine) -split ';' -notmatch 'opencv'
[Environment]::SetEnvironmentVariable('Path', $envPath -join ';', [EnvironmentVariableTarget]::Machine)
$dirs = Get-ChildItem $(Join-Path $installationPath 'opencv') -Include "bin" -Directory -Recurse
foreach ($dir in $dirs) {
    Install-ChocolateyPath -PathToInstall $dir -PathType 'Machine'
}
