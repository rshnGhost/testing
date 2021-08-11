$url = "https://api.github.com/repos/rshnGhost/testing/commits"
$webData = Invoke-WebRequest -Uri $url -UseBasicParsing
$releases = ConvertFrom-Json $webData.content
Write-Host $releases.sha[0].substring(0, [System.Math]::Min(7, $s.Length))
