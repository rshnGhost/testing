$webData = Invoke-WebRequest -Uri "https://api.github.com/repos/rshnGhost/testing/commits"
$releases = ConvertFrom-Json $webData.content
$releases | get-member
$releases.sha[0]