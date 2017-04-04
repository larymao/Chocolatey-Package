Import-Module AU

function global:au_SearchReplace {
    @{
        'tools\chocolateyInstall.ps1' = @{
            "(^[$]checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
            "(^[$]checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
        }
    }
}

function global:au_GetLatest {
    $page = Invoke-WebRequest -Uri "https://projectpokemon.org/forums/files/file/1-pkhex/"
    $version = ($page.Links | Where-Object outerHTML -Match "\d+(\.\d+){1,4}" | Select-Object -First 1 -ExpandProperty innerText).Trim()
	
    return @{
        Version = $version;
    }
}

Update-Package -NoCheckUrl -NoCheckChocoVersion -ChecksumFor none
