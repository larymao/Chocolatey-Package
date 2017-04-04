Import-Module au

function global:au_SearchReplace {
    @{
        'tools\chocolateyInstall.ps1' = @{
            "(^[$]url\s*=\s*)('.*')" = "`$1'$($Latest.URL32)'"
        }
    }
}

function global:au_GetLatest {
    $page = Invoke-WebRequest -UseBasicParsing -Uri "http://www.netsarang.com/verchk/verchk.php?releasestage=0&source=1&productversion=5.0.0000&productcode=xme"
    $url = ($page.Content -split "\n" -match "^http(.*)+" | Select-Object -First 1).Trim()
    $version = ($page.Content -split "=|\." -match "^xme\d{4,}$" | Select-Object -First 1).Trim().Replace("xme", '')
    $version = ([Version]$version.Insert(2, ".").Insert(5, ".")).ToString()

    return @{
        Version = $version;
        URL32 = $url;
    }
}

Update-Package -NoCheckUrl -NoCheckChocoVersion -ChecksumFor none
