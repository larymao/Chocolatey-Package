Import-Module AU

function global:au_SearchReplace {
	@{
		'tools\chocolateyInstall.ps1' = @{
			"(^[$]checksum\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
		}
	}
}

function global:au_GetLatest {
	$page = Invoke-WebRequest -UseBasicParsing -Uri "http://www.angusj.com/resourcehacker"
	$version = ($page.Content -split "\n|<|>" -match "^Version\s+\d+(\.\d+)+$" | Select-Object -First 1).Replace("Version", "").Trim()

	return @{
		Version = $version;
	}
}

Update-Package -NoCheckUrl -NoCheckChocoVersion
