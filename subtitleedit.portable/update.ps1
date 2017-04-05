Import-Module AU

function global:au_SearchReplace {
    @{
        'tools\chocolateyInstall.ps1' = @{
            "(^[$]url\s*=\s*)('.*')" = "`$1'$($Latest.URL32)'"
            "(^[$]checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
            "(^[$]checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
        }
    }
}

function global:au_GetLatest {
    $request = Invoke-WebRequest -UseBasicParsing -Uri "https://github.com/SubtitleEdit/subtitleedit/releases/latest" -MaximumRedirection 0 -ErrorAction Ignore
    $url = $request.Headers.Location
    $version = $url -Split "/" | Select-Object -Last 1
    $url = "https://github.com/SubtitleEdit/subtitleedit/releases/download/$version/SE$($version.Replace(".", '')).zip"
    $page = Invoke-WebRequest -UseBasicParsing -Uri "https://github.com/SubtitleEdit/subtitleedit/releases/tag/$version"
    $sha1sum = $page.Content -split "<|>|\n" -match "^[0-9a-f]{40}$" | Select-Object -First 1 -Skip 1
	
    return @{
        Version = $version
        URL32 = $url
        Checksum32 = $sha1sum
        ChecksumType32 = 'sha1'
    }
}

Update-Package -NoCheckUrl -NoCheckChocoVersion -ChecksumFor none
