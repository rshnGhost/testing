## iex ((New-Object System.Net.WebClient).DownloadString('https://git.io/JR4jF'))

$pythonVersion = '3.9.6'
$url = "https://www.python.org/ftp/python/3.9.6/python-3.9.6-amd64.exe"
$download = "https://github.com/rshnGhost/"+$pName+"/archive/refs/heads/"+$fName+".zip"
$output = "C:\Temp\python-3.9.6-amd64.exe"

$statusFile = Test-Path C:\Temp\python-3.9.6-amd64.exe -PathType Leaf
Write-Host -NoNewline "Checking latest release"
If (!$statusFile) {
  Write-Host "[File not found]"
  Write-Host -NoNewline "Dowloading latest release"
  Invoke-WebRequest -Uri $url -OutFile $output
  Write-Host "[Downloaded]"
}
else{
  Write-Host "[File found]"
  & C:\Temp\python-3.9.6-amd64.exe /passive /install
}