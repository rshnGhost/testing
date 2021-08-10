## iex ((New-Object System.Net.WebClient).DownloadString('https://git.io/JRCsv'))

$python = 0
$pipenv = 0
$choco = 0

function checkChocolatey {
	try{
		Write-Host -NoNewline "Checking Chocolatey..."
		$er = (invoke-expression "choco -v") 2>&1
		if ($lastexitcode) {throw $er}
		if (!$lastexitcode) {
			Write-Host "[Found]"
			$choco = 1
			return 1
		}
	}
	catch{
		Write-Host "[Not Found]"
		$choco = 0
		return 0
	}
}

function checkPython {
	try{
		Write-Host -NoNewline "Checking Python..."
		$er = (invoke-expression "python -V") 2>&1
		if ($lastexitcode) {throw $er}
		if (!$lastexitcode) {
			Write-Host "[Found]"
			$python = 1
			return 1
		}
	}
	catch{
		Write-Host "[Not Found]"
		$python = 0
		return 0
	}
}

function checkPipenv {
	try{
		Write-Host -NoNewline "Checking Pipenv..."
		$er = (invoke-expression "python -m pipenv --version") 2>&1
		if ($lastexitcode) {throw $er}
		if (!$lastexitcode) {
			Write-Host "[Found]"
			$pipenv = 1
			return 1
		}
	}
	catch{
		Write-Host "[Not Found]"
		$pipenv = 0
		return 0
	}
}

function installChocolatey {
	try{
		Write-Host -NoNewline "Installing Chocolatey..."
		$InstallDir='C:\ProgramData\chocolatey'
		$env:ChocolateyInstall="$InstallDir"
		Set-ExecutionPolicy Bypass -Scope Process -Force;
		iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
		$er = (invoke-expression "choco -v") 2>&1
		if ($lastexitcode) {throw $er}
		if (!$lastexitcode) {
			Write-Host "[Installed]"
			$choco = 1
			return 1
		}
	}
	catch{
		Write-Host "[Not Installed]"
		$choco = 0
		return 0
	}
}

function installPython {
	try{
		Write-Host -NoNewline "Installing Python..."
		$er = (invoke-expression "choco install python --version=3.9.6 -y") 2>&1
		if ($lastexitcode) {throw $er}
		checkPython
		if (!$lastexitcode) {
			Write-Host "[Installed]"
			$python = 1
			return 1
		}
	}
	catch{
		Write-Host "[Not Installed]"
		$python = 0
		return 0
	}
}

function installPipenv {
	try{
		Write-Host -NoNewline "Installing Pipenv..."
		$er = (invoke-expression "python -m pip install pipenv") 2>&1
		if ($lastexitcode) {throw $er}
		if (!$lastexitcode) {
			Write-Host "[Installed]"
			$pipenv = 1
			return 1
		}
	}
	catch{
		Write-Host "[Not Installed]"
		$pipenv = 0
		return 0
	}
}

$valuepipenv = checkPipenv
$valuepython = checkPython
$valuechoco = checkChocolatey

if($valuepipenv -eq 0) {
	if($valuepython -eq 0) {
		if($valuechoco -eq 0) {
			$value = installChocolatey
			if(($python -eq 0) -and ($value -eq 1)) {
				$value = installPython
				$value = installPipenv
			}
		}
		else{
			$value = installPython
			if(($python -eq 1) -and ($value -eq 1)) {
				$value = installPipenv
			}
		}
	}
	else{
		$value = installPipenv
	}
}
