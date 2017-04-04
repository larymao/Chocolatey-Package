Import-Module AU

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(^[$]url32\s*=\s*)('.*')"          = "`$1'$($Latest.URL32)'"
            "(^[$]url64\s*=\s*)('.*')"          = "`$1'$($Latest.URL64)'"
            "(^[$]checksum32\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum32)'"
            "(^[$]checksumType32\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
            "(^[$]checksum64\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum64)'"
            "(^[$]checksumType64\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType64)'"
        }
    }
}

function global:au_GetLatest {
    $page = Invoke-WebRequest -UseBasicParsing -Uri 'https://wireshark.org/download.html'

    $url = $page.links | Where-Object href -Match '(http[s]?|[s]?)(:\/\/)([^\s,]+)\/win64\/[Ww]ire[Ss]hark-win64-[\d\.]+\.exe$' | Select-Object -First 1 -ExpandProperty href
    $version = $url -split '-|.exe' | Select-Object -Last 1 -Skip 1

    $page = Invoke-WebRequest -UseBasicParsing -Uri "https://www.wireshark.org/download/SIGNATURES-${version}.txt"
    $sha256sum32 = ($page.Content -split "\n" -like "SHA256(Wireshark-win32-*.exe)=*" -split '=' | Select-Object -Last 1).Trim()
    $sha256sum64 = ($page.Content -split "\n" -like "SHA256(Wireshark-win64-*.exe)=*" -split '=' | Select-Object -Last 1).Trim()
    return @{
        URL32          = "https://www.wireshark.org/download/win32/Wireshark-win32-${version}.exe";
        URL64          = "https://www.wireshark.org/download/win64/Wireshark-win64-${version}.exe";
        Checksum32     = $sha256sum32
        ChecksumType32 = 'SHA256'
        Checksum64     = $sha256sum64
        ChecksumType64 = 'SHA256'
        Version        = $version 
    }
}

Update-Package -NoCheckUrl -NoCheckChocoVersion -ChecksumFor none
