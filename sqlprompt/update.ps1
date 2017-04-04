Import-Module AU

function global:au_SearchReplace {
    @{
        'tools\chocolateyInstall.ps1' = @{
			"(^[$]url\s*=\s*)('.*')" = "`$1'$($Latest.URL32)'"
        }
    }
}

function global:au_GetLatest {
    $page = Invoke-WebRequest -UseBasicParsing -Uri "https://documentation.red-gate.com/dashboard.action"
	$url = "https://documentation.red-gate.com" + ($page.Links -match "SQL\s+Prompt" | Select-Object -First 1 -ExpandProperty href).Trim()
    $page = Invoke-WebRequest -UseBasicParsing -Uri $url
	$url = "https://documentation.red-gate.com" + ($page.Links -match "Release\s+notes\s+for\s+SQL\s+Prompt\s\d+(\.\d+)+" | Select-Object -First 1 -ExpandProperty href).Trim()
    $page = Invoke-WebRequest -UseBasicParsing -Uri $url
    $version = ($page.Content -split " |<|>|-|\n" -match "^\d+(\.\d+){3,}$" | Select-Object -First 1).Trim()

    return @{
        Version = $version;
		URL32 = "https://download.red-gate.com/checkforupdates/SQLPrompt/SQLPrompt_${version}.exe";
    }
}

Update-Package -NoCheckUrl -NoCheckChocoVersion -ChecksumFor none
