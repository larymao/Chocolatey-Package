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
    $page = Invoke-WebRequest -UseBasicParsing -Uri "https://documentation.red-gate.com/dashboard.action"
	$url = "https://documentation.red-gate.com" + ($page.Links -match "\.NET\s+Reflector" | Select-Object -First 1 -ExpandProperty href).Trim()
    $major = ($url -split "/|\+" -match "^\d+$" | Select-Object -First 1).Trim()

    $page = Invoke-WebRequest -UseBasicParsing -Uri "http://update.red-gate.com/UpdateServer/check.asmx" -Method Post -ContentType "text/xml" -Body "<?xml version=`"1.0`" encoding=`"utf-8`"?><soap:Envelope xmlns:soap=`"http://schemas.xmlsoap.org/soap/envelope/`" xmlns:xsi=`"http://www.w3.org/2001/XMLSchema-instance`" xmlns:xsd=`"http://www.w3.org/2001/XMLSchema`"><soap:Body><CheckForUpdates xmlns=`"http://www.red-gate.com/webservices/`"><xmlArgument>&lt;container&gt;&lt;update version=`"2`"&gt;&lt;product&gt;&lt;name&gt;.NET Reflector Installer&lt;/name&gt;&lt;currentVersion major=`"$major`" minor=`"0`" build=`"0`" revision=`"0`" /&gt;&lt;serialNumber&gt;&lt;/serialNumber&gt;&lt;/product&gt;&lt;machineID&gt;4559F3D3-1502-4C99-BF3B-4ED94D8816B7&lt;/machineID&gt;&lt;userID&gt;2824bdd9-2e4e-4eca-a0fe-96902fc44c24&lt;/userID&gt;&lt;automatic&gt;False&lt;/automatic&gt;&lt;culture&gt;zh-CN&lt;/culture&gt;&lt;showTest&gt;False&lt;/showTest&gt;&lt;id&gt;&lt;/id&gt;&lt;/update&gt;&lt;/container&gt;</xmlArgument></CheckForUpdates></soap:Body></soap:Envelope>"
    [xml]$result = $page.Content
    [xml]$result = $result.Envelope.Body.CheckForUpdatesResponse.xmlResponse
    $version = "$($result.container.result.update.version.major).$($result.container.result.update.version.minor).$($result.container.result.update.version.build).$($result.container.result.update.version.revision)"
		
    return @{
        Version = $version;
        URL32 = "https://download.red-gate.com/checkforupdates/NETReflectorDesktop/NETReflectorDesktop_${version}.exe";
    }
}

Update-Package -NoCheckUrl -NoCheckChocoVersion
