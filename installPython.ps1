if ([Console]::KeyAvailable) {
  $key = [Console]::ReadKey($true)
  if ($key.key -eq "C" -and $key.modifiers -eq "Control") { 
    Write-Host "Done"
  }
}