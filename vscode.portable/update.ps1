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
	$url = "https://vscode-update.azurewebsites.net/latest/win32-archive/stable"
	$request = Invoke-WebRequest -Uri $url -MaximumRedirection 0 -ErrorAction Ignore
	$url = $request.Headers.Location
	$version = $url.Substring($url.LastIndexOf("-") + 1).Replace(".zip", "").Trim()
	$Latest = @{
		Version = $version;
		URL32 = $url;
	}
	return $Latest
}

Update-Package -NoCheckUrl 
