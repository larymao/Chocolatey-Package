$ErrorActionPreference = 'Stop'

$packageName  = 'pkhex'
$toolsPath    = Split-Path -parent $MyInvocation.MyCommand.Definition
$filePath     = Join-Path $toolsPath 'PKHex.zip'
$checksum     = '9E63A8CDF7BF4F75A9CBDF3C3B85A79940E40A3CBA80B00DA55DEF262C5E85A3'
$checksumType = 'sha256'

try {
	$page = Invoke-WebRequest -UseBasicParsing -Uri "https://projectpokemon.org/forums/files/file/1-pkhex/" -SessionVariable session
    $url = [System.Net.WebUtility]::HtmlDecode(($page.Links | Where-Object outerHTML -CMatch "Download\s+this\s+file" | Select-Object -ExpandProperty href))
	
    $page = Invoke-WebRequest -UseBasicParsing -Uri $url -WebSession $session
    $url = [System.Net.WebUtility]::HtmlDecode(($page.Links | Where-Object outerHTML -CLike "*confirm*Download*" | Select-Object -First 1 -ExpandProperty href))

    Invoke-WebRequest -WebSession $session -Uri $url -OutFile $filePath
}
catch {
    throw
}

$packageArgs = @{
	packageName    = $packageName
	url            = $filePath
	checksum       = $checksum
	checksumType   = $checksumType
	unzipLocation  = $toolsPath
}
Install-ChocolateyZipPackage @packageArgs
