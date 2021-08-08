$pythonVersion = '3.9.6'
$url = 'https://www.python.org/ftp/python/3.9.6/python-3.9.6-amd64.exe'
$pip = 0
$python = 0

## checking pipenv
Write-Host -NoNewline "checking pipenv..."
Try{
	# Check if pipenv is already installed
	$er = (invoke-expression "python -m pipenv --version") 2>&1
	if ($lastexitcode) {throw $er}
	Write-Output "[Found]"
	$pip = 1
}
Catch{
	Write-Output "[Not Found]"
	$pip = 0
	## checking python
	Write-Host -NoNewline "checking python..."
	Try{
		# Check if python is already installed
		$er = (invoke-expression "python -V") 2>&1
		if ($lastexitcode) {throw $er}
		Write-Output "[Found]"
		$python = 1
		Write-Host -NoNewline "installing pipenv..."
		python -m pip install pipenv
		Write-Output "[Done]"
	}
	Catch{
		Write-Output "[Not Found]"
		$python = 0
	}
}
