$ErrorActionPreference = 'Stop'

$packageName  = 'pkhex'
$toolsPath    = Split-Path -parent $MyInvocation.MyCommand.Definition
$filePath     = Join-Path $toolsPath 'PKHex.zip'

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
	unzipLocation  = $toolsPath
}
Install-ChocolateyZipPackage @packageArgs
