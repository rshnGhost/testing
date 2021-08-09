$python = 0
$pipenv = 0
$choco = 0

function checkChocolatey {
	Write-Host -NoNewline "Checking Chocolatey..."
	$er = (invoke-expression "choco -v") 2>&1
	if ($lastexitcode) {
		Write-Output "[Not Found]"
		$choco = 0
	}
	if (!$lastexitcode) {
		Write-Output "[Found]"
		$choco = 1
	}
}

function checkPython {
	Write-Host -NoNewline "Checking Python..."
	$er = (invoke-expression "python -V") 2>&1
	if ($lastexitcode) {
		Write-Output "[Not Found]"
		$python = 0
	}
	if (!$lastexitcode) {
		Write-Output "[Found]"
		$python = 1
	}
}

function checkPipenv {
	Write-Host -NoNewline "Checking Pipenv..."
	$er = (invoke-expression "python -m pipenv --version") 2>&1
	if ($lastexitcode) {
		Write-Output "[Not Found]"
		$pipenv = 0
	}
	if (!$lastexitcode) {
		Write-Output "[Found]"
		$pipenv = 1
	}
}

function installChocolatey {
	Write-Host -NoNewline "Installing Chocolatey..."
	$InstallDir='C:\ProgramData\chocolatey'
	$env:ChocolateyInstall="$InstallDir"
	Set-ExecutionPolicy Bypass -Scope Process -Force;
	iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
	$er = (invoke-expression "choco -v") 2>&1
	if ($lastexitcode) {
		Write-Output "[Not Installed]"
		$choco = 0
	}
	if (!$lastexitcode) {
		Write-Output "[Installed]"
		$choco = 1
	}
}

function installPython {
	Write-Host -NoNewline "Installing Python..."
	$er = (invoke-expression "choco install python --version=3.9.6 -y") 2>&1
	if ($lastexitcode) {
		Write-Output "[Not Installed]"
		$python = 0
	}
	if (!$lastexitcode) {
		Write-Output "[Installed]"
		$python = 1
	}
}

function installPipenv {
	Write-Host -NoNewline "Installing Pipenv..."
	$er = (invoke-expression "python -m pip install pipenv") 2>&1
	if ($lastexitcode) {
		Write-Output "[Not Installed]"
		$pipenv = 0
	}
	if (!$lastexitcode) {
		Write-Output "[Installed]"
		$pipenv = 1
	}
}

