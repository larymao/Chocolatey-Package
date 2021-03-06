﻿import-module AU

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(^[$]url32\s*=\s*)('.*')" = "`$1'$($Latest.URL32)'"
            "(^[$]url64\s*=\s*)('.*')" = "`$1'$($Latest.URL64)'"
        }
    }
}

function global:au_GetLatest {
    $page = Invoke-WebRequest -UseBasicParsing -Uri "https://github.com/git-for-windows/git/releases/latest" 
    $url32 = "https://github.com" + ($page.links | Where-Object href -match "PortableGit-.+-32-bit.7z.exe" | Select-Object -First 1 -ExpandProperty href)
    $url64 = "https://github.com" + ($page.links | Where-Object href -match "PortableGit-.+-64-bit.7z.exe" | Select-Object -First 1 -ExpandProperty href)

    $version = [IO.Path]::GetFileName($url32) -split "-" -match "\d+(\.\d+)+"

    return @{
        Version = $version
        URL32   = $url32
        URL64   = $url64
    }
}

Update-Package -NoCheckUrl -NoCheckChocoVersion -ChecksumFor none
