$pythonVersion = '3.9'

## checking Chocolatey
Write-Host -NoNewline "checking chocolatey..."

Try{
	# Check if winget is already installed
	$er = (invoke-expression "choco -v") 2>&1
	if ($lastexitcode) {throw $er}
	Write-Host "choco is already installed."
}
Catch{
	# winget is not installed. Install it from the Github release
	Write-Host "choco is not found, installing it right now."
}
Finally {
  Write-Host "final Block"
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
