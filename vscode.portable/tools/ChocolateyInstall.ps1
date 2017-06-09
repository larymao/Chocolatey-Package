$ErrorActionPreference = 'Stop'

$PackageName = 'vscode.portable'
$Url = 'https://vscode.cdn.azure.cn/stable/376c52b955428d205459bea6619fc161fc8faacf/VSCode-win32-ia32-1.13.0.zip'
$ToolsPath = Split-Path $MyInvocation.MyCommand.Definition

$PackageArgs = @{
    PackageName   = $PackageName
    Url           = $Url
    UnzipLocation = $ToolsPath
}
Install-ChocolateyZipPackage @PackageArgs

$FileName = [IO.Path]::GetFileNameWithoutExtension($Url)
$UnzipPath = $FileName.SubString(0, $FileName.LastIndexOf('-'))
$UnzipPath = Join-Path $ToolsPath $UnzipPath 
Move-Item -Path $UnzipPath -Destination $ToolsPath -Force
Remove-Item -Path $UnzipPath -Recurse -Force
Get-ChildItem $ToolsPath -Include "*.exe" -Exclude "Code.exe" -Recurse | ForEach-Object { New-Item "$($_.FullName).ignore" -Type file -Force | Out-Null }
