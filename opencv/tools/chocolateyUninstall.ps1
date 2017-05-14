$ErrorActionPreference = 'Stop';

$OpenCV_HOME = Join-Path $(Get-ToolsLocation) 'opencv'
Remove-Item $OpenCV_HOME -Recurse -Force

$envPath = [Environment]::GetEnvironmentVariable('Path', [EnvironmentVariableTarget]::Machine) -split ';' -notmatch 'opencv'
[Environment]::SetEnvironmentVariable('Path', $envPath -join ';', [EnvironmentVariableTarget]::Machine)

Uninstall-ChocolateyEnvironmentVariable -VariableName 'OpenCV_HOME' -VariableType 'Machine'
Uninstall-ChocolateyEnvironmentVariable -VariableName 'OpenCV_LIB' -VariableType 'Machine'
Uninstall-ChocolateyEnvironmentVariable -VariableName 'OpenCV_INCLUDE' -VariableType 'Machine'
