# AU Packages Template: https://github.com/majkinetor/au-packages-template

param([string[]] $Name, [string] $ForcedPackages, [string] $Root = $PSScriptRoot)

if (Test-Path $PSScriptRoot/update_vars.ps1) {
    . $PSScriptRoot/update_vars.ps1
}

$Options = [ordered]@{
    Timeout        = 60
    UpdateTimeout  = 600
    Threads        = 10
    Push           = $true

    Git            = @{
        User     = $Env:github_user
        Password = $Env:github_password
        Force    = $true
    }
	
    ForcedPackages = $ForcedPackages -split ' '
	
    BeforeEach     = {
        param($PackageName, $Options)
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
if ($ForcedPackages) {
    Write-Host "FORCED PACKAGES: $ForcedPackages"
}
$global:au_Root = $Root
$global:info = Update-AUPackages -Name $Name -Options $Options
