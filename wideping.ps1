Param(
[Parameter(Mandatory=$true, position=0)]
[string]
$addrList
)

$connected = [System.Collections.ArrayList]::new()
$failed = [System.Collections.ArrayList]::new()

$addr = Import-Csv $addrList 

Write-Host "Pinging addresses stored in " $addrList
foreach ($ip in $addr){
	$msg = "`npinging host " + $ip.("Printer IP") + "..."
	Write-Host $msg
	if (test-connection $ip.("Printer IP") -count 1 -quiet){
		Write-Host "Reply Received!" -foreground green 
		[void]$connected.add($ip.("Printer IP")) }
	else {
		Write-Host "Request timed out." -foreground red 
		[void]$failed.add($ip.("Printer IP")) }
}

Write-Host "`nSucceeded:" -foreground green
foreach ($conn in $connected){
	Write-Host $conn -foreground green
}

Write-Host "`nFailed:" -foreground red
foreach ($fail in $failed){
	Write-Host $fail -foreground red
}

