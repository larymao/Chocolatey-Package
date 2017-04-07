$ErrorActionPreference = 'Stop'

$packageName = 'vscode.portable'
$url = 'https://az764295.vo.msecnd.net/stable/d9484d12b38879b7f4cdd1150efeb2fd2c1fbf39/VSCode-win32-1.11.1.zip'
$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
    packageName = $packageName
    url = $url
    unzipLocation = $toolsPath
}

Install-ChocolateyZipPackage @packageArgs
Get-ChildItem $toolsPath -Include "*.exe" -Exclude "Code.exe" -Recurse | ForEach-Object { New-Item "$($_.FullName).ignore" -Type file -Force | Out-Null }
