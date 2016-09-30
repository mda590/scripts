#
# Delete EBS volumes in 'available' state, which are not tagged with a specific Tag Key
# This script does delete data, so be careful where you run it.
# As a safety measure, test with the dryRun variable set to True
# 

import boto3
import json

print("Deletes all available EBS volumes which are not tagged with a specific Tag")
region = "us-east-1"  
ec2 = boto3.resource('ec2', region_name=region) 
excludeTag =  'EBSVolume.Delete'
dryRun = False

def lambda_handler(event, context):

    deleted_volumes = []
    skipped_volumes = []

    volume_iterator = ec2.volumes.all()
    
    for volume in volume_iterator:
        if volume.state == 'available':
            print [volume.id, volume.availability_zone, volume.state]
            if volume.tags and excludeTag in str(volume.tags):
                print('INFO: Volume is tagged to be retained. Skipping this volume.')
                skipped_volumes.append(volume.id)
            else:
                deleted_volumes.append(volume.id)
                if not dryRun:
                    # delete the unused volumes
                    # WARNING -- THIS DELETES DATA
                    volume.delete()

    print(json.dumps({
        'Skipped Volumes': skipped_volumes,
        'Deleted Volumes': deleted_volumes,
    }))