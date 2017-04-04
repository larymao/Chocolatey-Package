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
	
    if ($global:Latest.NuspecVersion -ne $version) {
        $page = Invoke-WebRequest -UseBasicParsing -Uri "https://projectpokemon.org/forums/files/file/1-pkhex/" -SessionVariable session
        $url = [System.Net.WebUtility]::HtmlDecode(($page.Links | Where-Object outerHTML -CMatch "Download\s+this\s+file" | Select-Object -ExpandProperty href))
	
        $page = Invoke-WebRequest -UseBasicParsing -Uri $url -WebSession $session
        $url = [System.Net.WebUtility]::HtmlDecode(($page.Links | Where-Object outerHTML -CLike "*confirm*Download*" | Select-Object -First 1 -ExpandProperty href))

        $fileName = "PKHeX.zip"
        Invoke-WebRequest -WebSession $session -Uri $url -OutFile $fileName
        $sha256sum = Get-FileHash -Algorithm sha256 -Path $fileName | Select-Object -First 1 -ExpandProperty Hash
    }
	
    return @{
        Version = $version;
        ChecksumType32 = 'sha256';
        Checksum32 = $sha256sum;
    }
}

Update-Package -NoCheckUrl -NoCheckChocoVersion -ChecksumFor none
