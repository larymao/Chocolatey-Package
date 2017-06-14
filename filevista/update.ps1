Import-Module AU

function global:au_SearchReplace {
    @{
        'tools\chocolateyInstall.ps1' = @{
            "(^[$]url\s*=\s*)('.*')" = "`$1'$($Latest.URL32)'"
        }
    }
}

function global:au_GetLatest {
    $page = Invoke-WebRequest -UseBasicParsing -Uri "https://www.gleamtech.com/trials"
    $url = $page.Links | Where-Object href -Match "FileVista-v\d+(\.\d+){1,}-Installer.zip" | Select-Object -First 1 -ExpandProperty href
    $version = ($url -split "-|v" -match "\d+(\.\d+){1,4}").Trim()

    return @{
        Version = $version;
        URL32 = "https://www.gleamtech.com${url}";
    }
}

Update-Package -NoCheckUrl -NoCheckChocoVersion -ChecksumFor none
