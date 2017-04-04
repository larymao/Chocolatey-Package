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
	$page = Invoke-WebRequest -UseBasicParsing -Uri "https://sourceforge.net/projects/x64dbg/files/snapshots/"
	$file = (($page.Links | Where-Object title -Like "*snapshot*zip*" | Select-Object -First 1 -ExpandProperty title) -split " " -match "\d+(-\d+)+").Trim()
	$version = ($file -split "\.|_" -match "\d+(-\d+)+$" -Replace "-","" | Select-Object -First 2) -join "."
	
	return @{
		Version = $version;
		URL32   = "https://sourceforge.net/projects/x64dbg/files/snapshots/$file/download";
	}
}

Update-Package -NoCheckUrl -ChecksumFor 32 
