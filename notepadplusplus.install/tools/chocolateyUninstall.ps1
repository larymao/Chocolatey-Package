$packageName = 'notepadplusplus'
$toolsPath = Join-Path $(Get-ToolsLocation) $packageName
Remove-Item -Path $toolsPath -Recurse -Force | Out-Null