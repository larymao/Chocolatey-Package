Import-Module AU

function global:au_SearchReplace {
    @{
        'tools\chocolateyInstall.ps1' = @{
            "(^[$]url\s*=\s*)('.*')" = "`$1'$($Latest.URL32)'"
        }
    }
}

function global:au_GetLatest {
    $page = Invoke-WebRequest -UseBasicParsing -Uri "http://www.faststone.org/FSViewerDownload.htm"
    $version = ($page.Content -split "<|>|&|\n" -match "FastStone Image Viewer \d+(\.\d+)+").Trim() -split " " -match "\d+(\.\d+)+" | Select-Object -First 1
    $url = $page.Links | Where-Object href -Match "FSViewer\d+.zip" | Select-Object -First 1 -ExpandProperty href
	
    return @{
        Version = $version
        URL32   = $url
    }
}

Update-Package -NoCheckUrl -NoCheckChocoVersion -ChecksumFor none
