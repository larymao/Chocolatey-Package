Import-Module AU

function global:au_SearchReplace {
    @{
        'tools\chocolateyInstall.ps1' = @{
            "(^[$]url\s*=\s*)('.*')" = "`$1'$($Latest.URL32)'"
        }
    }
}

function global:au_GetLatest {
    $page = Invoke-WebRequest -UseBasicParsing -Uri "https://www.sourcetreeapp.com/"
    $url = ($page.Links | Where-Object href -Match "SourceTreeSetup" | Select-Object -First 1 -ExpandProperty href).Trim()
    $version = $url -split "-|\.exe" -match "\d+(\.\d+){2,4}"
	
    return @{
        Version = $version
        URL32 = $url
    }
}

Update-Package -NoCheckUrl -NoCheckChocoVersion -ChecksumFor none
