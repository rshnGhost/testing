function installChocolatey {
	try{
		Write-Host -NoNewline "checking chocolatey..."
		$er = (invoke-expression "choco -v") 2>&1
		if ($lastexitcode) {throw $er}
		if (!$lastexitcode) {Write-Output "[Found]"}
	}
	catch{
		Write-Output "[Not Found]"
		$InstallDir='C:\ProgramData\chocolatey'
		$env:ChocolateyInstall="$InstallDir"
		Set-ExecutionPolicy Bypass -Scope Process -Force;
		iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
	}
}

function installPython {
	try{
		Write-Host -NoNewline "checking python..."
		$er = (invoke-expression "python -V") 2>&1
		if ($lastexitcode) {throw $er}
		if (!$lastexitcode) {Write-Output "[Found]"}
	}
	catch{
		Write-Output "[Not Found]"
	}
}

function Pipenv {
	try{
		Write-Host -NoNewline "checking pipenv..."
		$er = (invoke-expression "python -m pipenv --version") 2>&1
		if ($lastexitcode) {throw $er}
	}
	catch{
		Write-Output "[Not Found]"
	}
}

Try{
	# Check if pipenv is already installed
	Write-Host -NoNewline "checking pipenv..."
	$er = (invoke-expression "python -m pipenv --version") 2>&1
	if ($lastexitcode) {throw $er}
	if (!$lastexitcode) {Write-Output "[Found]"}
}
Catch{
	Write-Output "[Not Found]"
	## checking python
	Try{
		# Check if python is already installed
		Write-Host -NoNewline "checking python..."
		$er = (invoke-expression "python -V") 2>&1
		if ($lastexitcode) {throw $er}
		if (!$lastexitcode) {
			Write-Output "[Found]"
			Write-Host -NoNewline "installing pipenv..."
			python -m pip install pipenv
			Write-Output "[Done]"
		}
	}
	Catch{
		Write-Output "[Not Found]"
		Try{
				Write-Host -NoNewline "checking python..."
				$er = (invoke-expression "choco -v") 2>&1
				if ($lastexitcode) {throw $er}
				if (!$lastexitcode) {
					Write-Host "[Done]"
					Write-Host -NoNewline "checking pipenv..."
					python -m pip install pipenv
					Write-Host "[Done]"
				}
			}
			Catch{
				Write-Output "[Failed]"
			}

	}
			
		}