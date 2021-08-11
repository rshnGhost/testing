$webData = Invoke-WebRequest -Uri "https://api.github.com/repos/rshnGhost/testing/commits"
$releases = ConvertFrom-Json $webData.content
Write-Host $releases.sha[0]