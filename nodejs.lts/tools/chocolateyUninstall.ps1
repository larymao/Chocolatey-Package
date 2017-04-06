$ErrorActionPreference = 'Stop';

$packageName = 'nodejs'
$toolsPath = Join-Path $(Get-ToolsLocation) $packageName

# Remove from PATH of System
$envPath = [Environment]::GetEnvironmentVariable('Path', [System.EnvironmentVariableTarget]::Machine)
if (!$envPath.ToLower().Contains($toolsPath.ToLower())) {
    Write-Host "PATH environment variable does not have $toolsPath in it."
    return
}
$envPath = $envPath -split ";"
$envPath = $envPath -ne $toolsPath
[Environment]::SetEnvironmentVariable('Path', $envPath, [System.EnvironmentVariableTarget]::Machine)

if (Test-Path $toolsPath) {
    Remove-Item -Path $toolsPath -Recurse -Force
}