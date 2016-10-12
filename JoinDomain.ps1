#
# Adapted from Ryan Lawyer: http://thesysadminswatercooler.blogspot.com/2015/09/aws-autoscale-windows-server-and-join.html
# Script to join a Windows Server to AD. This has been tested with AWS and is run as a part of UserData.
# It takes a Hostname in as an argument for the server, renames the server, joins the domain, and then reboots.
# 
# It is recommended to use PS2exe to convert this into an EXE instead of running the PowerShell command directly.
#    This will give an extra layer for masking the password.
#
# Sample command to run: .\JoinDomain.exe "ServerNameHere"
#


# Get Hostname variable
param(
	[string]$a
)

# Set the credentials for an AD user with access to join domain
$username = "domain\Administrator"
$password = 'password' | ConvertTo-SecureString -AsPlainText -Force
$cred = New-Object -typename System.Management.Automation.PSCredential($username, $password)

Try {
	# Rename computer, add to domain, and reboot.
	Rename-Computer -NewName $a -Force
	Start-Sleep -s 5
	Add-Computer -DomainName domain.local -Options JoinWithNewName,AccountCreate -Credential $cred -Force -Restart -erroraction 'stop'
}
Catch{
	# Write error file, if required.
	echo $_.Exception | Out-File c:\temp\error-joindomain.txt -Append
}