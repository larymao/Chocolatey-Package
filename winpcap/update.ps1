Import-Module AU

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(^[$]url\s*=\s*)('.*')"          = "`$1'$($Latest.URL32)'"
            "(^[$]checksum\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum32)'"
            "(^[$]checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
        }
    }
}

function global:au_GetLatest {
    $page = Invoke-WebRequest -UseBasicParsing -Uri "https://www.winpcap.org/install/"
    $url = $page.Links | Where-Object href -Match 'WinPcap_\d+(_\d+)+.exe$' | Select-Object -First 1 -expand href
    $version = ($url -split 'WinPcap_|\.exe' | Select-Object -Last 1 -Skip 1).Replace('_', '.')
    $sha1sum = ($page.Content -split "<|>|\n" -match "[0-9a-fA-F]{40}").Trim()

    return @{
        Version        = $version
        URL32          = "https://www.winpcap.org/install/" + $url
        Checksum32     = $sha1sum
        ChecksumType32 = 'sha1'
    }
}

Update-Package -NoCheckUrl -NoCheckChocoVersion -ChecksumFor none
