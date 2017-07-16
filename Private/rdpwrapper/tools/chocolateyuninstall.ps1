$packageName = 'rdpwrapper'
$toolsDir = $(Split-Path -parent $MyInvocation.MyCommand.Definition)

Start-ChocolateyProcessAsAdmin '-u' (Join-Path $toolsDir 'RDPWInst.exe')
