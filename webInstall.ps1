$url = "https://api.github.com/repos/rshnGhost/django-quick/commits"
$webData = Invoke-WebRequest -Uri $url -UseBasicParsing
$releases = ConvertFrom-Json $webData.content
Write-Host $releases.sha[0].substring(0, [System.Math]::Min(7, $releases.Length))

$fName = 'django-3.2.5'
$pName = 'django-quick'
$sha = $releases.sha[0].substring(0, [System.Math]::Min(7, $releases.Length))
$dName = $pName+'-'+$sha
$output = "C:\Temp\$dName.zip"
$download = "https://github.com/rshnGhost/"+$pName+"/archive/refs/heads/"+$fName+".zip"

Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

$ErrorActionPreference = 'SilentlyContinue'
$wshell = New-Object -ComObject Wscript.Shell
$Button = [System.Windows.MessageBoxButton]::YesNoCancel
$ErrorIco = [System.Windows.MessageBoxImage]::Error
If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]'Administrator')) {
	Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
	Exit
}
function deleteOldFolder {
	$statusFolder = Test-Path C:\Temp\$dName
	if ($statusFolder) {
		Write-Host -NoNewline "Deleting old Folder`t"
		Remove-Item C:\Temp\$dName -Recurse
		Write-Host "[Deleted old Files]"
	}
}
function setupProject {
	Write-Host "Executing..."
	cd "C:\Temp\$dName\$pName-$fName\windowCmd\"
	try{
		Write-Host -NoNewline "Setting up...`t`t"
		$er = (invoke-expression "C:\Temp\$dName\$pName-$fName\windowCmd\2 setup.bat") 2>&1
		if ($lastexitcode) {throw $er}
		if (!$lastexitcode) {
			Write-Host "[Done]"
			try{
				Write-Host -NoNewline "Running...`t`t"
				$er = (invoke-expression "C:\Temp\$dName\$pName-$fName\windowCmd\3 run.bat") 2>&1
				if ($lastexitcode) {throw $er}
				if (!$lastexitcode) {
					Write-Host "[Done]"
				}
			}
			catch{
				Write-Host "[Not Done]"
				return -1
			}
		}
	}
	catch{
		Write-Host "[Not Done]"
		return -1
	}
}

function expandZip {
	Write-Host -NoNewline "Expand Archive`t`t"
	Expand-Archive $output C:\Temp\$dName
	Write-Host "[Done]"
}

deleteOldFolder
Write-Host -NoNewline "Checking for file`t"
$statusFile = Test-Path $output -PathType Leaf
if (!$statusFile) {
	Write-Host "[File not Found]"
	Write-Host -NoNewline "Dowloading latest release`t"
	Invoke-WebRequest -Uri $download -OutFile $output
	$statusFile = Test-Path $output -PathType Leaf
	if (!$statusFile) {
		Write-Host "[Failed]"
		pause
		exit
	}
	if ($statusFile) {
		Write-Host "[Dowloaded]"
		expandZip
		setupProject
	}
}
if ($statusFile) {
	Write-Host "[File Found]"
	expandZip
	setupProject
}
