# AU Packages Template: https://github.com/majkinetor/au-packages-template

param([string[]] $Name, [string] $ForcedPackages, [string] $Root = $PSScriptRoot)

if (Test-Path $PSScriptRoot/update_vars.ps1) {
    . $PSScriptRoot/update_vars.ps1
}

$reportFile = Join-Path $PSScriptRoot "README.md"

$Options = [ordered]@{
    Timeout = 60
    UpdateTimeout = 600
    Threads = 10
    Push = $Env:au_Push -eq 'true'

    Report = @{
        Type = 'markdown'
        Path = "$reportFile.tmp"
        Params = @{
            NoAppVeyor = $false
            NoIcons = $false
            IconSize = 32
        }
    }

    Git = @{
        User = $Env:github_user
        Password = $Env:github_password
        Force = $true
    }

    ForcedPackages = $ForcedPackages -split ' '
    BeforeEach = {
        param($PackageName, $Options )
        $p = $Options.ForcedPackages | Where-Object { $_ -match "^${PackageName}(?:\:(.+))*$" }
        if (!$p) {
            return
        }

        $global:au_Force = $true
        $global:au_Version = ($p -split ':')[1]
    }
}

if ($ForcedPackages) {
    Write-Host "FORCED PACKAGES: $ForcedPackages"
}
$global:au_Root = $Root
$global:info = Update-AUPackages -Name $Name -Options $Options

if (($global:info | Where-Object Updated -eq $true | Measure-Object).Count -gt 0) {
    Get-Content -Path "$reportFile.tmp" | Set-Content -Path $reportFile -Encoding UTF8

    git add "README.md"
    git commit -m "report update"

    Write-Host "Pushing Report"
    git push -q
}
