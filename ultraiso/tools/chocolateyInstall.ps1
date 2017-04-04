$ErrorActionPreference = 'Stop'

$packageName  = 'ultraiso'
$url          = 'http://dw.ezbsystems.com/uiso9_cn.exe'
$checksum     = '78909d9056a073657f6153a1b346f00b88a3eff146f488493a0c2d69f9db6b99'
$checksumType = 'sha256'

$packageArgs = @{
	packageName    = $packageName
	url            = $url
	checksum       = $checksum
	checksumType   = $checksumType
	silentArgs     = '/SILENT /TASKS="desktopicon,fileassoc"'
	validExitCodes = @(0)
}
Install-ChocolateyPackage @packageArgs

$reg = "HKCU:\SOFTWARE\EasyBoot Systems\UltraISO\5.0"
if (!(Test-Path $reg)) {
	New-Item -Path $reg -Force
}
Set-ItemProperty -Path $reg -Name "UserName" -Value "王涛" -Force
Set-ItemProperty -Path $reg -Name "Registration" -Value "69414b170e136f766a32471009176109" -Force
