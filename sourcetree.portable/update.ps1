Import-Module AU

function global:au_SearchReplace {
    @{
        'tools\chocolateyInstall.ps1' = @{
            "(^[$]url\s*=\s*)('.*')"          = "`$1'$($Latest.URL32)'"
            "(^[$]checksum\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum32)'"
            "(^[$]checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
        }
    }
}

function global:au_GetLatest {
    $page = Invoke-WebRequest -UseBasicParsing -Uri "https://www.sourcetreeapp.com/update/windows/ga/RELEASES"
    $page = [System.Text.Encoding]::ASCII.GetString($page.Content)

    $release = ($page -split "\n" -notmatch "delta"  | ConvertFrom-String -PropertyNames sha1sum, filename, filesize) | Select-Object -Last 1

    $url = "https://www.sourcetreeapp.com/update/windows/ga/" + $release.filename
    $version = $release.filename -split "-|\.exe" -match "^\d+(\.\d+){2,}$"
	
    return @{
        Version        = $version
        URL32          = $url
        Checksum32     = ($release.sha1sum).ToLower()
        ChecksumType32 = 'sha1'
    }
}

Update-Package -NoCheckUrl -NoCheckChocoVersion -ChecksumFor none
