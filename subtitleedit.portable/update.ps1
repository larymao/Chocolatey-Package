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
    $request = Invoke-WebRequest -UseBasicParsing -Uri "https://github.com/SubtitleEdit/subtitleedit/releases/latest"  -MaximumRedirection 0 -ErrorAction Ignore
    $url = $request.Headers.Location
    $version = $url -Split "/" | Select-Object -Last 1
    $url = "https://github.com/SubtitleEdit/subtitleedit/releases/download/$version/SE$($version.Replace(".", '')).zip"
    $page = Invoke-WebRequest -Uri "https://github.com/SubtitleEdit/subtitleedit/releases/tag/$version"
    $html = $page.AllElements | Where-Object {$_.tagName -eq "P" -and $_.innerText -Match "SE$($version.Replace(".", '')).zip*"} | Select-Object -First 1 -ExpandProperty innerText
    $html = $html -split "\n"
    $sha1sum = $html -match "SHA1" | ConvertFrom-String -PropertyNames algorithmic, usage, sum | Select-Object -First 1 -ExpandProperty sum
	
    return @{
        Version = $version;
        URL32 = $url;
        Checksum32 = $sha1sum;
        ChecksumType32 = 'sha1';
    }
}

Update-Package -NoCheckUrl -ChecksumFor none
