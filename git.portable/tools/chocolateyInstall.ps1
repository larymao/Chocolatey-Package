$ErrorActionPreference = 'Stop'

$packageName = 'git'
$url32 = 'https://npm.taobao.org/mirrors/git-for-windows/2.13.2.windows.1/PortableGit-2.13.2-32-bit.7z.exe'
$url64 = 'https://npm.taobao.org/mirrors/git-for-windows/2.13.2.windows.1/PortableGit-2.13.2-64-bit.7z.exe'
$toolsPath = Join-Path $(Get-ToolsLocation) $packageName

$packageArgs = @{
    packageName = $packageName
    url = $url32
    url64 = $url64
    unzipLocation = $toolsPath
}
Install-ChocolateyZipPackage @packageArgs
Install-ChocolateyPath -PathToInstall $toolsPath -PathType 'Machine'
$cmdPath = Join-Path $toolsPath "cmd"
if (Test-Path $cmdPath) {
    Install-ChocolateyPath -PathToInstall $cmdPath -PathType 'Machine'
}
