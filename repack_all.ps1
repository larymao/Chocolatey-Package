if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
	Write-Host "$(Get-Location)"
    Start-Process PowerShell "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`" " -Verb RunAs;
    Exit
}

WorkFlow Choco-Pack {
    $dirs = Get-ChildItem -Directory -Exclude ".git"
    foreach -parallel ($dir in $dirs) {
        $null = choco pack $(Join-Path $dir "$($dir.Name).nuspec") --out "$dir"
    }
}

Push-Location $PSScriptRoot
Remove-Item * -Include "*.nupkg" -Recurse -Force
Choco-Pack