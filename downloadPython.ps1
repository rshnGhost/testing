## iex ((New-Object System.Net.WebClient).DownloadString('https://git.io/JR4jF'))

$pythonVersion = '3.9.6'
$url = "https://www.python.org/ftp/python/3.9.6/python-3.9.6-amd64.exe"
$download = "https://github.com/rshnGhost/"+$pName+"/archive/refs/heads/"+$fName+".zip"
$output = "C:\Temp\python-3.9.6-amd64.exe"

$statusFile = Test-Path C:\Temp\python-3.9.6-amd64.exe -PathType Leaf
If (!$statusFile) {
  Write-Host "Dowloading latest release"
  Invoke-WebRequest -Uri $url -OutFile $output
}
else{
  Write-Host "File found"
}
