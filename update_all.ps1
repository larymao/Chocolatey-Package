﻿# AU Packages Template: https://github.com/majkinetor/au-packages-template

if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Start-Process PowerShell "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`" " -Verb RunAs;
    Exit
}

param([string[]] $Name, [string] $ForcedPackages, [string] $Root = $PSScriptRoot)

if (Test-Path $PSScriptRoot/update_vars.ps1) {
    . $PSScriptRoot/update_vars.ps1
}

$Options = [ordered]@{
    Timeout = 60
    UpdateTimeout = 600
    Threads = 10
    Push = $Env:au_Push -eq 'true'

    Report = @{
        Type = 'markdown'
        Path = "$PSScriptRoot\README.md"
        Params = @{
            NoAppVeyor = $false
            NoIcons = $false
            IconSize = 32
        }
    }

    Git = @{
        User = $Env:github_user
        Password = $Env:github_password
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