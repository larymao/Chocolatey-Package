Import-Module AU

function global:au_SearchReplace {
	@{
		'tools\chocolateyInstall.ps1' = @{
		}
	}
}

function global:au_GetLatest {
	$page = Invoke-WebRequest -UseBasicParsing -Uri "http://fishcodelib.com/database.htm"
	$html = $page.Links | Where-Object title -Like "*DatabaseNet4.zip" | Select-Object -Last 1 -ExpandProperty outerHTML
	$html = $html -Split " " -Split "<" -Split ">"	
	$version = ($html -Match "^\d+(\.\d+){0,2}$").Trim()
	$subversion = ($html -Match "^\.\d+$").Trim()
	
	return @{
		Version = "${version}${subversion}";
	}
}

Update-Package -NoCheckUrl -NoCheckChocoVersion -ChecksumFor none
