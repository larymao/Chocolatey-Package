﻿Import-Module AU

function global:au_SearchReplace {
	@{
		'tools\chocolateyInstall.ps1' = @{
			"(^[$]checksum\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
		}
	}
}

function global:au_GetLatest {
	$page = Invoke-WebRequest -UseBasicParsing -Uri "http://www.torchsoft.com/node/12"
	$version = $page.Content -Split " " -Match "^\d+(\.\d+){2}$" | Select-Object -First 1

	return @{
		Version = "${version}${subversion}";
	}
}

Update-Package -NoCheckUrl -NoCheckChocoVersion -ChecksumFor none
