$packageName = 'python2'
$toolsPath = Split-Path -Parent $MyInvocation.MyCommand.Definition
$unPath = Join-Path $toolsPath 'Uninstall-ChocolateyPath.psm1'
$installPath = Join-Path $(Get-ToolsLocation) $packageName

Import-Module $unPath
Uninstall-ChocolateyPath $installPath 'Machine'
Uninstall-ChocolateyPath $(Join-Path $installPath "Script") 'Machine'

if (Test-Path $installPath) {
    Remove-Item -Path $installPath -Recurse -Force
}
