import-module AU

$releases = 'https://nodejs.org/en/download/'

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(^[$]url32\s*=\s*)('.*')" = "`$1'$($Latest.URL32)'"
            "(^[$]url64\s*=\s*)('.*')" = "`$1'$($Latest.URL64)'"
        }
    }
}

function global:au_GetLatest {
    $page = Invoke-WebRequest -UseBasicParsing -Uri "https://slproweb.com/products/Win32OpenSSL.html"
    $url = ($page.Links | Where-Object href -Match "Win32OpenSSL_Light" | Select-Object -First 1 -ExpandProperty href).Trim()
    $url64 = ($page.Links | Where-Object href -Match "Win64OpenSSL_Light" | Select-Object -First 1 -ExpandProperty href).Trim()
    $version = ($url -split "-|\." -match "^\d+(_\d+)+" | Select-Object -First 1).Trim().Replace("_", ".")
    $char = [char]$version.SubString($version.Length - 1)
    $version = $version.SubString(0, $version.Length - 1) + "." + ($char - [char]'a' + 1)
    
    return @{
        Version = $version
        URL32 = "https://slproweb.com/" + $url
        URL64 = "https://slproweb.com/" + $url
    }
}

Update-Package -NoCheckUrl -NoCheckChocoVersion -ChecksumFor none
