Import-Module AU

function global:au_SearchReplace {
    @{
        'tools\chocolateyInstall.ps1' = @{
            "(^[$]url\s*=\s*)('.*')" = "`$1'$($Latest.URL32)'"
        }
    }
}

function global:au_GetLatest {
    $page = Invoke-WebRequest -UseBasicParsing -Uri "https://sourceforge.net/projects/gmkvextractgui/"
    $version = (($page.Links | Where-Object title -Like "*gMKVExtractGUI*7z*" | Select-Object -First 1 -ExpandProperty title) -split " |/" -match "^v\d+(\.\d+)+$" | Select-Object -First 1).Replace("v", '').Trim()
	
    return @{
        Version = $version;
        URL32 = "https://sourceforge.net/projects/gmkvextractgui/files/v${version}/gMKVExtractGUI.v${version}.7z/download";
    }
}

Update-Package -NoCheckUrl -NoCheckChocoVersion -ChecksumFor none
