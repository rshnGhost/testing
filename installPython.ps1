$webData = Invoke-WebRequest -Uri "https://api.github.com/repos/rshnGhost/testing/commits"
$releases = ConvertFrom-Json $webData.content.sha[0]
Write-Host $releases