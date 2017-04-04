Import-Module AU

function global:au_SearchReplace {
    @{
        'tools\chocolateyInstall.ps1' = @{
            "(^[$]url\s*=\s*)('.*')" = "`$1'$($Latest.URL32)'"
        }
    }
}

function global:au_GetLatest {
    $page = Invoke-WebRequest -Uri "https://github.com/upx/upx/tags"
    $version = $page.Links | Where-Object innerText -Match "^v\d+(\.\d+){1,2}" | Select-Object -First 1 -Expand innerText
    $version = $version.Replace("v", "").Trim()
    $url = "https://github.com/upx/upx/releases/download/v${version}/upx$($version.Replace(".", ''))w.zip"
    $Latest = @{
        Version = $version;
        URL32 = $url;
    }
    return $Latest
}

Update-Package -NoCheckUrl -NoCheckChocoVersion -ChecksumFor none
