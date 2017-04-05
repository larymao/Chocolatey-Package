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
    $request = Invoke-WebRequest -UseBasicParsing -Uri "https://github.com/cmderdev/cmder/releases/latest" -MaximumRedirection 0 -ErrorAction Ignore
    $version = ($request.Headers.Location -split "/" -match "^v\d+(\.\d+)+").Replace("v", '').Trim()

    $page = Invoke-WebRequest -UseBasicParsing -Uri "https://github.com/cmderdev/cmder/releases/download/v$version/hashes.txt"
    $md5sum = ($page.RawContent -split "\n" | Select-Object -Last 1 -Skip 1).Trim()
	
    return @{
        Version = $version
        URL32 = "https://github.com/cmderdev/cmder/releases/download/v${version}/cmder_mini.zip"
        Checksum32 = $md5sum
        ChecksumType32 = 'md5'
    }
}

Update-Package -NoCheckUrl -NoCheckChocoVersion -ChecksumFor none