# Scripts
This is a collection of different scripts I have created for different purposes, or solving different problems. Most of them will be in the context of AWS.

1) aws-ebs-deleteAvailableVolumes.py - This deletes EBS volumes which are in the 'available' state. It also checks against a single tag, and if a volume has that tag, the volume will not be deleted.
