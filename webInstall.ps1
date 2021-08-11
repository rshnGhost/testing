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

$statusFolder = Test-Path C:\Temp\$dName
if ($statusFolder) {
	Write-Host -NoNewline "Deleting old Folder"
	Remove-Item C:\Temp\$dName -Recurse
	Write-Host "[Deleted old Files]"
}

Write-Host -NoNewline "Checking for file`t`t"
$statusFile = Test-Path "C:\Temp\$dName" -PathType Leaf
if (!$statusFile) {
	Write-Host "[File not Found]"
	Write-Host -NoNewline "Dowloading latest release`t"
	Invoke-WebRequest -Uri $download -OutFile $output
	$statusFile = Test-Path "C:\Temp\$dName" -PathType Leaf
	if (!$statusFile) {
		Write-Host "[Failed]"
		pause
		exit
	}
	if ($statusFile) {
		Write-Host "[Dowloaded]"
		Write-Host -NoNewline "Expand Archive`t`t"
		Expand-Archive $output 'C:\Temp\'
		Write-Host "[Done]"
	}
}
if ($statusFile) {
	Write-Host "[File Found]"
	Write-Host -NoNewline "Expand Archive`t`t"
	Expand-Archive $output 'C:\Temp\'
	Write-Host "[Done]"
}


<#
# GUI Specs
Write-Host "Checking for file..."
cd 'C:\Temp\'
$statusFile = Test-Path C:\Temp\$dName.zip -PathType Leaf
If (!$statusFile) {
  Try{

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
#>
