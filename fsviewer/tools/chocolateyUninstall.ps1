$ErrorActionPreference = 'Stop';

$packageName = 'fsviewer'
$toolsPath = Join-Path $(Get-ToolsLocation) $packageName

Remove-Item $toolsPath -Recurse -Force
