$ErrorActionPreference = 'Stop'

$packageName  = 'vscode.portable'
$url          = 'https://az764295.vo.msecnd.net/stable/8076a19fdcab7e1fc1707952d652f0bb6c6db331/VSCode-win32-1.10.2.zip'
$checksum     = 'ed28bfb19aa1e94880e5084ec4a2c808512c5a54f54f95f5aabb190a5edfe810'
$checksumType = 'sha256'
$toolsPath    = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
	packageName    = $packageName
	url            = $url
	checksum       = $checksum
	checksumType   = $checksumType
	unzipLocation  = $toolsPath
}

Install-ChocolateyZipPackage @packageArgs

Get-ChildItem "$toolsPath" -Include "*.exe" -Exclude "Code.exe" -Recurse | ForEach-Object { New-Item "$($_.FullName).ignore" -Type file -Force | Out-Null }
