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
	$page = Invoke-WebRequest -UseBasicParsing -Uri "http://cn.ezbsystems.com/ultraiso/download.htm"
	$version = ($page.Content -split "<|>" -match "\d+(\.\d+){2,3}" | Get-Unique | Select-Object -First 1).Trim()

	return @{
		Version = $version;
	}
}

Update-Package -NoCheckUrl
