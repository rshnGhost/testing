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
		$statusFile = Test-Path C:\Temp\python-3.9.6-amd64.exe -PathType Leaf
		Write-Host -NoNewline "Checking latest release"
		if(!$statusFile){
			Write-Host "[File not found]"
			Write-Host -NoNewline "Dowloading latest release"
			Invoke-WebRequest -Uri $url -OutFile $output
			Write-Host "[Downloaded]"
		}
		else{
			Write-Host "[File found]"
			Write-Host -NoNewline "Installing latest release"
			$exe = 'C:\Temp\python-3.9.6-amd64.exe'
			$args = '/passive', '/install', 'InstallAllUsers=1'
			Start-Process -Wait $exe -ArgumentList $args
			[Environment]::SetEnvironmentVariable(
				"Path",
				[Environment]::GetEnvironmentVariable("Path",
				[EnvironmentVariableTarget]::Machine) + ";C:\Program Files\Python39",
				[EnvironmentVariableTarget]::Machine)
			refreshenv
		}
		start powershell{
			Try{
				Write-Host -NoNewline "checking python..."
				$er = (invoke-expression "python -V") 2>&1
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
}
