$ErrorActionPreference = 'Stop'

$packageName = 'opencv'
$url64 = 'https://github.com/opencv/opencv/releases/download/3.2.0/opencv-3.2.0-vc14.exe'
$installationPath = Get-ToolsLocation
$OpenCV_HOME = Join-Path $installationPath 'opencv'

Remove-Item -Path $OpenCV_HOME -Recurse -Force | Out-Null

$packageArgs = @{
    packageName   = $packageName
    url64         = $url64
    unzipLocation = $installationPath
}
Install-ChocolateyZipPackage @packageArgs

$envPath = [Environment]::GetEnvironmentVariable('Path', [EnvironmentVariableTarget]::Machine) -split ';' -notmatch 'opencv'
[Environment]::SetEnvironmentVariable('Path', $envPath -join ';', [EnvironmentVariableTarget]::Machine)


$OpenCV_BIN = Get-ChildItem $OpenCV_HOME -Include "bin" -Directory -Recurse
foreach ($bin in $OpenCV_BIN) {
    Install-ChocolateyPath -PathToInstall $bin -PathType 'Machine'
}

$OpenCV_HOME = Join-Path $OpenCV_HOME 'build'
Install-ChocolateyEnvironmentVariable -VariableName 'OpenCV_HOME' -VariableValue $OpenCV_HOME -VariableType 'Machine'

$OpenCV_LIB = Get-ChildItem $OpenCV_HOME -Include "lib" -Directory -Recurse
Install-ChocolateyEnvironmentVariable -VariableName 'OpenCV_LIB' -VariableValue $OpenCV_LIB -VariableType 'Machine'

$OpenCV_INCLUDE = Get-ChildItem $OpenCV_HOME -Include "include" -Directory -Recurse
Install-ChocolateyEnvironmentVariable -VariableName 'OpenCV_INCLUDE' -VariableValue $OpenCV_HOME -VariableType 'Machine'
