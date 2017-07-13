$ErrorActionPreference = 'Stop'

$PackageName = 'vscode.portable'
$Url = 'https://vscode.cdn.azure.cn/stable/b8cd5b9556d8b70ea560d35b903422363f6c5c40/VSCode-win32-ia32-1.14.0.zip'
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
Move-Item -Path $(Join-Path $UnzipPath "*") -Destination $ToolsPath -Force
Remove-Item -Path $UnzipPath -Recurse -Force
Get-ChildItem $ToolsPath -Include "*.exe" -Exclude "Code.exe" -Recurse | ForEach-Object { New-Item "$($_.FullName).ignore" -Type file -Force | Out-Null }
