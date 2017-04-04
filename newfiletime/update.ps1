Import-Module AU

function global:au_SearchReplace {
    @{
        'tools\chocolateyInstall.ps1' = @{
            "(^[$]checksum32\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum32)'"
            "(^[$]checksumType32\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
            "(^[$]checksum64\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum64)'"
            "(^[$]checksumType64\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType64)'"
        }
    }
}

function global:au_GetLatest {
    $page = Invoke-WebRequest -UseBasicParsing -Uri "http://www.softwareok.com/?Download=NewFileTime"
    $version = $page -Match "(?<=<title>)([\S\s]*?)(?=</title>)"
    $version = $matches[0].Substring($matches[0].LastIndexOf(" ") + 1).Trim()
	
    return @{
        Version = $version;
    }
}

Update-Package -NoCheckUrl 
