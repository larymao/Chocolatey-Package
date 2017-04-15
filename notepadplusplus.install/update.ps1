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
    $url = "https://notepad-plus-plus.org/download/"
    $request = Invoke-WebRequest -Uri $url -MaximumRedirection 0 -ErrorAction Ignore
    $url = $request.Headers.Location
    $version = $url -Split "/" | Select-Object -Last 1
    $version = $version.Replace("v", "").Replace(".html", "").Trim()
    $base = "https://notepad-plus-plus.org/repository/$($version.Substring(0, $version.IndexOf("."))).x/$version"
    $page = Invoke-WebRequest -Uri "$base\npp.$version.sha1.md5.digest.txt"
    $sha1sum = $page.Content -Split '\n'
    $sha1sum = $sha1sum -like "*.Installer.exe" | Select-Object -First 1
    $sha1sum = $sha1sum.Substring(0, $sha1sum.IndexOf(" "))
	
    return @{
        Version = $version;
        URL32 = "$base/npp.$version.Installer.exe";
        ChecksumType32 = 'sha1';
        Checksum32 = $sha1sum;
    }
}

Update-Package -NoCheckUrl -NoCheckChocoVersion -ChecksumFor none
