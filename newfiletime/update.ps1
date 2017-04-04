Import-Module AU

function global:au_SearchReplace {
    @{
        'tools\chocolateyInstall.ps1' = @{
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

Update-Package -NoCheckUrl -NoCheckChocoVersion -ChecksumFor none
