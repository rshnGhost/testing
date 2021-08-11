$url = "https://api.github.com/repos/rshnGhost/django-quick/commits"
$webData = Invoke-WebRequest -Uri $url -UseBasicParsing
$releases = ConvertFrom-Json $webData.content
Write-Host $releases.sha[0]

$fName = 'django-3.2.5'
$dName = 'django-3.2.5['+$releases.sha[0]+']'
$pName = 'django-quick'
$output = "C:\Temp\$pName-$dName.zip"
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

# GUI Specs
Write-Host "Checking for file..."
cd 'C:\Temp\'
$statusFile = Test-Path C:\Temp\$pName-$dName.zip -PathType Leaf
If (!$statusFile) {
  Try{
    $download = "https://github.com/rshnGhost/"+$pName+"/archive/refs/heads/"+$fName+".zip"
    Write-Host "Dowloading latest release"
    Invoke-WebRequest -Uri $download -OutFile $output
    Write-Output "Path of the file : $output"
		$statusFolder = Test-Path C:\Temp\$pName-$dName
		If ($statusFolder) {
    	Write-Host "Deleting..."
    	Remove-Item C:\Temp\$pName-$dName -Recurse
		}
    Write-Host "Expand Archive..."
    Expand-Archive $output 'C:\Temp\'
    Write-Host "Executing..."
    cd "C:\Temp\$pName-$dName\windowCmd\"
    Write-Host "Setting up..."
    & "C:\Temp\$pName-$dName\windowCmd\2 setup.bat"
    Write-Host "Running..."
    & "C:\Temp\$pName-$dName\windowCmd\3 run.bat"
  }
  Catch{
    Write-Host "Someting is not working"
  }
} else {
	$statusFolder = Test-Path C:\Temp\$pName-$dName
	If ($statusFolder) {
		Write-Host "Deleting..."
		Remove-Item C:\Temp\$pName-$dName -Recurse
	}
  Write-Host "Expand Archive..."
  Expand-Archive $output 'C:\Temp\'
  Write-Host "Executing..."
  cd "C:\Temp\$pName-$dName\windowCmd\"
  Write-Host "Setting up..."
  & "C:\Temp\$pName-$dName\windowCmd\2 setup.bat"
  Write-Host "Running..."
  & "C:\Temp\$pName-$dName\windowCmd\3 run.bat"
}
