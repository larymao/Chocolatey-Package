$ErrorActionPreference = 'Stop'

$packageName = 'xmenager'
$url = 'http://download.netsarang.com/files/download.php?fileName=xme05001179.exe&fileExtra=Xme5.exe&log=download_count_xme5.txt'
$toolsPath = Split-Path -parent $MyInvocation.MyCommand.Definition

$filePath = Join-Path $toolsPath "Xme5.exe"
Invoke-WebRequest -UserAgent 'TrueUpdate 3.5' -Uri $url -OutFile $filePath

$packageArgs = @{
    packageName = $packageName
    url = $filePath
    validExitCodes = @(0)
}
Install-ChocolateyPackage @packageArgs
Get-ChildItem $toolsPath -Include "*.exe" -File -Recurse | ForEach-Object { New-Item "$($_.FullName).ignore" -Type file -Force | Out-Null }
