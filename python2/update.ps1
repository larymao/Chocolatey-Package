﻿import-module AU

$releases = 'http://www.python.org/downloads/'

function global:au_SearchReplace {
   @{
		".\tools\chocolateyInstall.ps1" = @{
			"(?i)(^\s*url\s*=\s*)('.*')"        = "`$1'$($Latest.URL32)'"
			"(?i)(^\s*url64bit\s*=\s*)('.*')"   = "`$1'$($Latest.URL64)'"
			"(?i)(^\s*checksum\s*=\s*)('.*')"   = "`$1'$($Latest.Checksum32)'"
			"(?i)(^\s*checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
		}
	}
}

function global:au_GetLatest {
	$download_page = Invoke-WebRequest -Uri $releases
	$url           = $download_page.links | Where-Object href -match 'python-(2.+)\.msi$' | ForEach-Object href
	$version       = $Matches[1]

	@{
		Version = $version
		URL32   = $url
		URL64   = $url.Replace('.msi', '.amd64.msi')
	}
}

update
