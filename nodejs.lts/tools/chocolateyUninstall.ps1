$ErrorActionPreference = 'Stop';

$packageName = 'nodejs'
$toolsPath = Join-Path $(Get-ToolsLocation) $packageName

$envPath = [Environment]::GetEnvironmentVariable('Path', [System.EnvironmentVariableTarget]::Machine)
if (!$envPath.ToLower().Contains($toolsPath.ToLower())) {
    Write-Host "PATH environment variable does not have $toolsPath in it."
    return
}

$envPath = $envPath -split ";"
$envPath = $envPath -ne $toolsPath
[Environment]::SetEnvironmentVariable('Path', $envPath, [System.EnvironmentVariableTarget]::Machine)
Remove-Item $toolsPath -Recurse -Force