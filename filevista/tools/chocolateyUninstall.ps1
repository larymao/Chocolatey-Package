$ErrorActionPreference = 'Stop';
 
$packageName = 'filevista'
[array]$key = Get-UninstallRegistryKey -SoftwareName 'FileVista*' | Select-Object -First 1
 
if ($key.Count -eq 1) {
	$key | ForEach-Object {
		$string = "$($_.UninstallString)"
		$file = $string.Substring(0, $string.IndexOf(" ", $string.IndexOf(" ") + 1)).Trim()
		$args = $string.Substring($string.IndexOf(" ", $string.IndexOf(" ") + 1)).Trim()

		$packageArgs = @{
			file           = $file
			packageName    = $packageName
			silentArgs     = $args
			validExitCodes = @(0)
		}
		Uninstall-ChocolateyPackage @packageArgs
	}
}
