﻿Import-Module AU

function global:au_SearchReplace {
    @{
        'tools\chocolateyInstall.ps1' = @{
        }
    }
}

function global:au_GetLatest {
    $page = Invoke-WebRequest -UseBasicParsing -Uri "https://www.hhdsoftware.com/Products"
    $version = (($page.Links | Where-Object {$_.href -like "*free-hex-editor*" -and $_.outerHTML -match "\d+(\.\d+){2,4}"} | Select-Object -First 1 -ExpandProperty outerHTML) -split " |<|>" -match "\d+(\.\d+){2,4}").Trim()
	
    return @{
        Version = $version;
    }
}

Update-Package -NoCheckUrl -NoCheckChocoVersion -ChecksumFor none