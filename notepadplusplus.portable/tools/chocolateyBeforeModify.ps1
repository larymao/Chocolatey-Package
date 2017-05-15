$ErrorActionPreference = 'Stop';

$packageName = 'notepadplusplus'
$installationPath = Join-Path $(Get-ToolsLocation) $packageName

$NppShell = Join-Path $installationPath "NppShell_06.dll"
if (Test-Path $NppShell) {
    regsvr32.exe /s /u "$NppShell"
}