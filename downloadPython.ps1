## iex ((New-Object System.Net.WebClient).DownloadString('https://git.io/JR4jF'))

$pythonVersion = '3.9.6'

function installPython{
	Write-Host -NoNewline "Installing latest release`t"
	$args = '/passive', 'install', 'InstallAllUsers=1', 'PrependPath=1', 'Include_test=0'
	Start-Process -Wait $output -ArgumentList $args
	Start-Process -Wait refreshenv
	Try{
		$er = (invoke-expression "python -V") 2>&1
		if ($lastexitcode) {throw $er}
		Write-Host "[Installed]"
	}
	Catch{
		Write-Host "[Not Installed]"
	}
}
# Check if operating system architecture
	Write-Host -NoNewline "Checking architecture`t"
if (($env:PROCESSOR_ARCHITECTURE -eq "AMD64") -and ([Environment]::Is64BitOperatingSystem)) {
	Write-Host "[64bit Found]"
	$url = "https://www.python.org/ftp/python/"+$pythonVersion+"/python-"+$pythonVersion+"-amd64.exe"
	$output = "C:\Temp\python-"+$pythonVersion+"-amd64.exe"
}
else{
	Write-Host "[32bit Found]"
	$url = "https://www.python.org/ftp/python/"+$pythonVersion+"/python-"+$pythonVersion+".exe"
	$output = "C:\Temp\python-"+$pythonVersion+".exe"
}

Try{
	# Check if pipenv is already installed
	Write-Host -NoNewline "Checking pipenv`t`t"
	$er = (invoke-expression "python -m pipenv --version") 2>&1
	if ($lastexitcode) {throw $er}
	Write-Host "[Found]"
	$pip = 1
}
Catch{
	Write-Host "[Not Found]"
	$pip = 0
	## checking python
	Write-Host -NoNewline "Checking python`t`t"
	Try{
		# Check if python is already installed
		$er = (invoke-expression "python -V") 2>&1
		if ($lastexitcode) {throw $er}
		Write-Host "[Found]"
		$python = 1
		Write-Host -NoNewline "Installing pipenv`t`t"
		python -m pip install pipenv
		Write-Host "[Done]"
	}
	Catch{
		Write-Host "[Not Found]"
		$python = 0
		$statusFile = Test-Path $output -PathType Leaf
		Write-Host -NoNewline "Checking latest release`t"
		If (!$statusFile){
			Write-Host "[File not found]"
			Write-Host -NoNewline "Dowloading latest release`t"
			Invoke-WebRequest -Uri $url -OutFile $output
			Write-Host "[Downloaded]"
			installPython
		}
		else{
			Write-Host "[File found]"
			installPython
		}
		Try{
			Write-Host -NoNewline "Checking python`t`t"
			$er = (invoke-expression "python -V") 2>&1
			if ($lastexitcode) {throw $er}
			if (!$lastexitcode) {
				Write-Host "[Done]"
				Write-Host -NoNewline "Installing pipenv`t`t"
				$er = (invoke-expression "python -m pip install pipenv") 2>&1
				if ($lastexitcode) {throw $er}
				Write-Host "[Done]"
			}
		}
		Catch{
			Write-Host "[Failed]"
		}
	}
}
