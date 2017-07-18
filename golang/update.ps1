﻿Import-Module AU

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
    $page = Invoke-WebRequest -Uri 'https://golang.org/dl/'
    $html = ($page.AllElements | Where-Object tagName -CEQ "TABLE" | Select-Object -First 1 -ExpandProperty innerText) -split "\n" | Select-Object -Skip 1
    $version = $html -match "src.tar.gz" | Select-Object -First 1
    $version = $version.SubString(0, $version.IndexOf(".src.tar.gz")).Replace("go", '').Trim()

    $sha256sum32 = ($html -like "*windows*386*zip*" -split 'MB' | Select-Object -Last 1).Trim()
    $sha256sum64 = ($html -like "*windows*64*zip*" -split 'MB' | Select-Object -Last 1).Trim()
    return @{
        URL32          = "https://storage.googleapis.com/golang/go${version}.windows-386.zip";
        URL64          = "https://storage.googleapis.com/golang/go${version}.windows-amd64.zip";
        Checksum32     = $sha256sum32;
        ChecksumType32 = 'SHA256';
        Checksum64     = $sha256sum64;
        ChecksumType64 = 'SHA256';
        Version        = $version;
    }
}

Update-Package -NoCheckUrl -NoCheckChocoVersion -ChecksumFor none
