begin { 
	[Console]::TreatControlCAsInput = $true
}
process {
	Write-Host "Waiting"
	$key = [Console]::ReadKey($true)
	if ($key.key -eq "C" -and $key.modifiers -eq "Control") { 
		Write-Host "Done"
	}
}
end { 
	[Console]::TreatControlCAsInput = $false
}