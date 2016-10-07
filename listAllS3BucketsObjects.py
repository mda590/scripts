#
# Print all S3 buckets and objects
# Warning: If you have a lot of S3 objects, this could potentially incur a large cost.
#

import boto3

client = boto3.client('s3')

buckets = client.list_buckets()
for bucket in buckets["Buckets"]:
	print(bucket['Name'])
	keylist = client.list_objects_v2(Bucket=bucket["Name"])
	if "Contents" in keylist:
		for object in keylist["Contents"]:
			print(object["Key"])