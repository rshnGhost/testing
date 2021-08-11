## iex ((New-Object System.Net.WebClient).DownloadString('https://git.io/JR4jF'))

$pythonVersion = '3.9.6'

# Check if operating system architecture
	Write-Host -NoNewline "checking architecture..."
if (($env:PROCESSOR_ARCHITECTURE -eq "AMD64") -and ([Environment]::Is64BitOperatingSystem)) {
	Write-Host "`t[64bit]"
	$url = "https://www.python.org/ftp/python/"+$pythonVersion+"/python-"+$pythonVersion+"-amd64.exe"
	$output = "C:\Temp\python-"+$pythonVersion+"-amd64.exe"
}
else{
	Write-Host "`t[32bit]"
	$url = "https://www.python.org/ftp/python/"+$pythonVersion+"/python-"+$pythonVersion+".exe"
	$output = "C:\Temp\python-"+$pythonVersion+".exe"
}

Try{
	# Check if pipenv is already installed
	Write-Host -NoNewline "checking pipenv..."
	$er = (invoke-expression "python -m pipenv --version") 2>&1
	if ($lastexitcode) {throw $er}
	Write-Host "`t`t[Found]"
	$pip = 1
}
Catch{
	Write-Host "`t`t[Not Found]"
	$pip = 0
	## checking python
	Write-Host -NoNewline "checking python..."
	Try{
		# Check if python is already installed
		$er = (invoke-expression "python -V") 2>&1
		if ($lastexitcode) {throw $er}
		Write-Host "`t[Found]"
		$python = 1
		Write-Host -NoNewline "installing pipenv..."
		python -m pip install pipenv
		Write-Host "`t[Done]"
	}
	Catch{
		Write-Host "`t[Not Found]"
		$python = 0
		$statusFile = Test-Path $output -PathType Leaf
		Write-Host -NoNewline "Checking latest release"
		If (!$statusFile){
			Write-Host "`t[File not found]"
			Write-Host -NoNewline "Dowloading latest release"
			Invoke-WebRequest -Uri $url -OutFile $output
			Write-Host "`t[Downloaded]"
		}
		else{
			Write-Host "`t[File found]"
			Write-Host -NoNewline "Installing latest release"
			$exe = 'C:\Temp\python-3.9.6-amd64.exe'
			$args = '/passive', 'install', 'InstallAllUsers=1', 'PrependPath=1', 'Include_test=0'
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
					Write-Host "`t[Done]"
					Write-Host -NoNewline "checking pipenv..."
					python -m pip install pipenv
					Write-Host "`t[Done]"
				}
			}
			Catch{
				Write-Host "`t[Failed]"
			}
		}
	}
}
