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
    $page = Invoke-WebRequest -UseBasicParsing -Uri "https://github.com/cmderdev/cmder/releases/latest"
    $url = ($page.Links | Where-Object href -Match "/cmderdev/cmder/releases/tag/v\d+(\.\d+)+$" | Select-Object -ExpandProperty href -First 1).Trim()
    $version = ($url -Split "/" -match "^v\d+(\.\d+)+").Replace("v", '').Trim()

    $page = Invoke-WebRequest -UseBasicParsing -Uri "https://github.com/cmderdev/cmder/releases/download/v${version}/hashes.txt"
    $md5sum = ($page.RawContent -split "\n" | Select-Object -Last 1).Trim().ToLower()
	
    return @{
        Version = $version;
        URL32 = "https://github.com/cmderdev/cmder/releases/download/v${version}/cmder_mini.zip";
        Checksum32 = $md5sum;
        ChecksumType32 = 'md5';
    }
}

Update-Package -NoCheckUrl -NoCheckChocoVersion -ChecksumFor none