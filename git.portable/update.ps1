import-module AU

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(^[$]url32\s*=\s*)('.*')" = "`$1'$($Latest.URL32)'"
            "(^[$]url64\s*=\s*)('.*')" = "`$1'$($Latest.URL64)'"
        }
    }
}

function global:au_GetLatest {
    $page = Invoke-WebRequest -UseBasicParsing -Uri "https://git-scm.com/download/win" 
    $url32 = $page.links | Where-Object href -match "PortableGit-.+-32-bit.7z.exe" | Select-Object -First 1 -ExpandProperty href
    $url64 = $page.links | Where-Object href -match "PortableGit-.+-64-bit.7z.exe" | Select-Object -First 1 -ExpandProperty href
    $version = [IO.Path]::GetFileName($url32) -split '-' | Select-Object -Skip 1 -First 1

    return @{
        Version = $version
        URL32 = "https://npm.taobao.org/mirrors/git-for-windows/" + $($url32 -split "/v" | Select-Object -Last 1)
        URL64 = "https://npm.taobao.org/mirrors/git-for-windows/" + $($url64 -split "/v" | Select-Object -Last 1)

    }
}

Update-Package -NoCheckUrl -NoCheckChocoVersion -ChecksumFor none
