Import-Module AU

function global:au_SearchReplace {
    @{
        'tools\chocolateyInstall.ps1' = @{
            "(^[$]url\s*=\s*)('.*')"          = "`$1'$($Latest.URL32)'"
        }
    }
}

function global:au_GetLatest {
    $page = Invoke-WebRequest -UseBasicParsing -Uri "https://downloads.adblockplus.org/devbuilds/adblockplusie/"
    $exe = $page.Links | Where-Object href -Match "\d+(\.\d+)" | Select-Object -Property href | Select-Object -First 1 -ExpandProperty href
    $version = ($exe -split "-" -match "\d+(\.\d+)" | Select-Object -First 1).Replace(".exe", '').Trim()

	return @{
        Version = $version;
        URL32   = "https://downloads.adblockplus.org/devbuilds/adblockplusie/" + $exe;
    }
}

Update-Package -NoCheckUrl -NoCheckChocoVersion -ChecksumFor none
