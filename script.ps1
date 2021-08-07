Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

$ErrorActionPreference = 'SilentlyContinue'
$wshell = New-Object -ComObject Wscript.Shell
$Button = [System.Windows.MessageBoxButton]::YesNoCancel
$ErrorIco = [System.Windows.MessageBoxImage]::Error
If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]'Administrator')) {
	Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
	Exit
}

## checking Chocolatey
try {
	Write-Host "checking Chocolatey..."
	$testchoco = powershell choco -v
	$testchoco
}
catch{
	Write-Host "installing Chocolatey..."
	## installing Chocolatey
	# Set directory for installation - Chocolatey does not lock
	# down the directory if not the default
	## $InstallDir='C:\ProgramData\chocolatey'
	## $env:ChocolateyInstall="$InstallDir"

	# If your PowerShell Execution policy is restrictive, you may
	# not be able to get around that. Try setting your session to
	# Bypass.
	## Set-ExecutionPolicy Bypass -Scope Process -Force;

	# All install options - offline, proxy, etc at
	# https://chocolatey.org/install
	## iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}

## checking python
Write-Host "checking python..."
$testpython = powershell python -V
if($testpython -eq ""){
	Write-Host "installing python..."
	## installing python
	## choco install python --version=3.9 -y
}else{
	Write-Host "found python..."
}

## checking pipenv
Write-Host "checking pipenv..."
$testpipenv = powershell python -m pipenv --version
if($testpipenv -eq ""){
	Write-Host "installing pipenv..."
	## install pipenv module
	## python -m pip install pipenv
}else{
	Write-Host "found pipenv..."
}
