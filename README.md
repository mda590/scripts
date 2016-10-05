# AWS Scripts
This is a collection of different scripts I have created for different purposes, or solving different problems.
Most of them will be in the context of AWS.

1) aws-ebs-deleteAvailableVolumes.py - This deletes EBS volumes which are in the 'available' state. It also checks against a single tag, and if a volume has that tag, the volume will not be deleted.
2) checkInt.ps1 - This is a PowerShell script that polls the status of a NIC card on a Windows 2k12 server via UserData in CloudFormation. This can be used when a NIC card is not stabilizing fast enough and CloudFormation fails and rollsback due to the NIC card not initializing fast enough.
