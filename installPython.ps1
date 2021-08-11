$url = "https://api.github.com/repos/rshnGhost/testing/commits"
$webData = Invoke-WebRequest -Uri $url
$releases = ConvertFrom-Json $webData.content
Write-Host $releases.sha[0]
