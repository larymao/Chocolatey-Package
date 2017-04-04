Import-Module AU

function global:au_SearchReplace {
	@{
		'tools\chocolateyInstall.ps1' = @{
			"(^[$]url\s*=\s*)('.*')"          = "`$1'$($Latest.URL32)'"
			"(^[$]checksum\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
		}
	}
}

function global:au_GetLatest {
	$page = Invoke-WebRequest -Uri "http://www.codecguide.com/download_k-lite_codec_pack_mega.htm"
	$html = $page.AllElements | Where-Object innerText -Match "^Version\s+([\d\.]+)\s+Mega" | Select-Object -First 1 -ExpandProperty innerText
	$version = ($html.SubString(0, $html.IndexOf("Mega")) -split " " -match '^\d+(\.\d+){2,4}$').Trim()
	$url = $page.Links | Where-Object href -Match "exe" | Select-Object -First 1 -ExpandProperty href
	$sha256sum = ((($page.AllElements | Where-Object innerText -Match "SHA256" | Where-Object tagName -CEQ "P" | Select-Object -ExpandProperty innerText -First 1) -split "\n" -match "SHA256").Trim() -split " " | Select-Object -Last 1).Trim()
	
	return @{
		Version        = $version;
		URL32          = $url;
		ChecksumType32 = 'sha256';
		Checksum32     = $sha256sum;
	}
}

Update-Package -NoCheckUrl -ChecksumFor none -NoCheckChocoVersion
