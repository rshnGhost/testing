$er = (invoke-expression "$webData = Invoke-WebRequest -Uri 'https://api.github.com/repos/rshnGhost/testing/commits'") 2>&1
$er = (invoke-expression "$releases = ConvertFrom-Json $webData.content") 2>&1
$er = (invoke-expression "$releases | get-member") 2>&1
$releases.sha[0]
