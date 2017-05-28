$ErrorActionPreference = 'Stop';

$packageName = 'openssl'
$installationPath = Get-ToolsLocation
$OpenSSL_HOME = Join-Path $installationPath $packageName
if (Test-Path $OpenSSL_HOME) {
    Remove-Item -Path $OpenSSL_HOME -Recurse -Force
}