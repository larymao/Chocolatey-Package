$packageName = 'git'
$toolsPath = Join-Path $(Get-ToolsPath) $packageName

# Remove from PATH of System
$envPath = [Environment]::GetEnvironmentVariable('Path', [System.EnvironmentVariableTarget]::Machine) -split ";"
$envPath = $envPath -notmatch $toolsPath
[Environment]::SetEnvironmentVariable('Path', $envPath, [System.EnvironmentVariableTarget]::Machine)

if (Test-Path $toolsPath) {
    Remove-Item -Path $toolsPath -Recurse -Force
}