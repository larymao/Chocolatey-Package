Import-Module AU

function global:au_SearchReplace {
	@{
		'tools\chocolateyInstall.ps1' = @{
			"(^[$]url32\s*=\s*)('.*')"          = "`$1'$($Latest.URL32)'"
			"(^[$]checksum32\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumType32\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
			"(^[$]url64\s*=\s*)('.*')"          = "`$1'$($Latest.URL64)'"
			"(^[$]checksum64\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum64)'"
			"(^[$]checksumType64\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType64)'"
		}
	}
}

function global:au_GetLatest {
	$page = Invoke-WebRequest -UseBasicParsing -Uri "https://ipmsg.org/tools/fastcopy.html.en"
	$page.Content -match "FastCopy\s+v\d+\.\d+\s+download"
	$version = $Matches[0] -split " |v" -match "\d+\.\d+"
		
	return @{
		Version = $version;
		URL32   = "https://ipmsg.org/archive/FastCopy$($version.Replace(".", '')).zip";
		URL64   = "https://ipmsg.org/archive/FastCopy$($version.Replace(".", ''))_x64.zip";
	}
}

Update-Package -NoCheckUrl -NoCheckChocoVersion
