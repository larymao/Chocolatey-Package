$ErrorActionPreference = 'Stop';

$installationPath = Join-Path $(Get-ToolsLocation) 'opencv'
Remove-Item $installationPath -Recurse -Force

$envPath = [Environment]::GetEnvironmentVariable('Path', [EnvironmentVariableTarget]::Machine) -split ';' -notmatch 'opencv'
[Environment]::SetEnvironmentVariable('Path', $envPath -join ';', [EnvironmentVariableTarget]::Machine)
