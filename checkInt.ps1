#
#	This script handles an issue in AWS when trying to attach 2 NIC cards to a Windows 2012 R1 server.
#	For whatever reason, this OS requires more time to recognize and install a second NIC card. This issue doesn't appear to occur in R2.
#	When trying to provision a 2k12 R1 server via CloudFormation with 2 NICs, CloudFormation will time out and roll back the entire stack,
#	stating that the NIC card could not be stabilized. This script when put into UserData will check the status of the 2nd NIC card for 
#	1 extra minute, and allows enough time for the NIC card to stabilize, and allows the CloudFormation script to finish successfully.
#
#	September 12, 2016
#

$timeout = New-Timespan -Minutes 1          # Run the while loop for 1 minutes
$stopwatch= [diagnostics.stopwatch]::StartNew()
$IntStatus = (get-wmiobject win32_networkadapter -filter 'netconnectionid = "Ethernet 2"' | select netconnectionstatus) | Out-String
$IntStatus
while(($IntStatus -eq "")) {
    $IntStatus = (get-wmiobject win32_networkadapter -filter 'netconnectionid = "Ethernet 2"' | select netconnectionstatus) | Out-String
    if ($stopwatch.elapsed -gt $timeout) {
        Write-Host "Breaking Now"
        break
    }
    Start-Sleep -s 1         # Pause while loop for every 1 second
}
Write-Host "Timed out"
