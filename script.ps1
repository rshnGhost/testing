$pythonVersion = '3.9'

## checking Chocolatey
Write-Host -NoNewline "checking chocolatey..."
if ((!$env:ChocolateyInstall) -or !(Test-Path "$env:ChocolateyInstall")){
	Write-Output "[Not Found]"
	Write-Host "installing chocolatey..."
	## installing Chocolatey
	# Set directory for installation - Chocolatey does not lock
	# down the directory if not the default
	$InstallDir='C:\ProgramData\chocolatey'
	## $env:ChocolateyInstall="$InstallDir"

	# If your PowerShell Execution policy is restrictive, you may
	# not be able to get around that. Try setting your session to
	# Bypass.
	Set-ExecutionPolicy Bypass -Scope Process -Force;

	# All install options - offline, proxy, etc at
	# https://chocolatey.org/install
	iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}else{
	Write-Output "[Found]"
}

## checking python
Write-Host -NoNewline "checking python..."
$testpython = python -V
if($testpython -eq ""){
	Write-Output "[Not Found]"
	Write-Host "installing python..."
	## installing python
	choco install python --version=$pythonVersion -y
}else{
	Write-Output "[Found]"
}

## checking pipenv
Write-Host -NoNewline "checking pipenv..."
$testpipenv = python -m pipenv --version
if($testpipenv -eq ""){
	Write-Output "[Not Found]"
	Write-Host "installing pipenv..."
	## install pipenv module
	python -m pip install pipenv
}else{
	Write-Output "[Found]"
}
