$pythonVersion = '3.9.6'

## checking Chocolatey
Write-Host -NoNewline "checking chocolatey..."
Try{
	# Check if winget is already installed
	$er = (invoke-expression "choco -v") 2>&1
	if ($lastexitcode) {throw $er}
	Write-Output "[Found]"
}
Catch{
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
}

## checking python
Write-Host -NoNewline "checking python..."
Try{
	# Check if python is already installed
	$er = (invoke-expression "python -V") 2>&1
	if ($lastexitcode) {throw $er}
	Write-Output "[Found]"
}
Catch{
	Write-Output "[Not Found]"
	Write-Host "installing python..."
	choco install python --version=$pythonVersion -y
}

## checking pipenv
Write-Host -NoNewline "checking pipenv..."
Try{
	# Check if pipenv is already installed
	$er = (invoke-expression "python -m pipenv --version") 2>&1
	if ($lastexitcode) {throw $er}
	Write-Output "[Found]"
}
Catch{
	Write-Output "[Not Found]"
	Write-Host "installing pipenv..."
	python -m pip install pipenv
}
