Import-Module AU

function global:au_SearchReplace {
    @{
        'tools\chocolateyInstall.ps1' = @{
            "(^[$]url32\s*=\s*)('.*')" = "`$1'$($Latest.URL32)'"
            "(^[$]url64\s*=\s*)('.*')" = "`$1'$($Latest.URL64)'"
        }
    }
}

function global:au_GetLatest {
    $page = Invoke-WebRequest -UseBasicParsing -Uri "https://ipmsg.org/tools/fastcopy.html.en"
    $version = ($page.Content -split "\n|<|>" -match "FastCopy\s+v\d+(\.\d+)+\s+download").Trim() -split "\s|v" -match "^\d+(\.\d+)+$"
		
    return @{
        Version = $version;
        URL32 = "https://ipmsg.org/archive/FastCopy$($version.Replace(".", '')).zip";
        URL64 = "https://ipmsg.org/archive/FastCopy$($version.Replace(".", ''))_x64.zip";
    }
}

Update-Package -NoCheckUrl -NoCheckChocoVersion -ChecksumFor none
