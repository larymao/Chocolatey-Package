$ErrorActionPreference = 'Stop';

Uninstall-ChocolateyEnvironmentVariable -VariableName 'GOROOT' -VariableType 'Machine'
Uninstall-ChocolateyEnvironmentVariable -VariableName 'GOPATH' -VariableType 'Machine'

$toolsPath = Join-Path $env:ChocolateyToolsLocation "go"
Remove-Item $toolsPath -Recurse -Force