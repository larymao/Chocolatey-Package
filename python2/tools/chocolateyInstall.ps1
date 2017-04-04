# This file should be identical for all python* packages
# https://docs.python.org/3/using/windows.html#installing-without-ui

$packageName = 'python2'
$installDir = Join-Path $(Get-ToolsLocation) $packageName
if ($Env:ChocolateyPackageParameters -match '/InstallDir:\s*(.+)') {
		$installDir = $Matches[1]
		if ($installDir.StartsWith("'") -or $installDir.StartsWith('"')){  $installDir = $installDir -replace '^.|.$' }
}
$installArgs  = '/qn /norestart ALLUSERS=1 ADDLOCAL=ALL TargetDir="{0}"' -f $installDir

$params = @{
	packageName    = $packageName
	fileType       = 'msi'
	silentArgs     = $installArgs
	url            = 'https://www.python.org/ftp/python/2.7.13/python-2.7.13.msi'
	url64Bit       = 'https://www.python.org/ftp/python/2.7.13/python-2.7.13.amd64.msi'
	checksum       = '44ea95356365195b18a5058796285789b0bfc94da1ee2ec1cb8e0a1c2ff6017a'
	checksum64     = '8b3e65fc1aad8809bb69477e922c3609a8e8fa9e2f6d5ab8f00f3553e3c61d7a'
	checksumType   = 'sha256'
	checksumType64 = 'sha256'
}

Install-ChocolateyPackage @params
Write-Host "Installed to '$installDir'"

if (($Env:PYTHONHOME -ne $null) -and ($Env:PYTHONHOME -ne $InstallDir)) {
	 Write-Warning "Environment variable PYTHONHOME points to different version: $Env:PYTHONHOME"
}

Write-Host "Adding $installDir to PATH if needed"
Install-ChocolateyPath $installDir 'Machine'
