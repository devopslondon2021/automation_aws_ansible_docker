import boto3
import sys

s3_client = boto3.client('s3')
BUCKET_NAME = sys.argv[1]
REGION = sys.argv[2]

def check_s3_versioning(bucket_name, region):
    print(bucket_name)
    response = s3_client.get_bucket_versioning(Bucket=bucket_name)
    if 'Status' in response and response['Status'] == 'Enabled':
        print("Versioning is enabled on the S3 bucket!!")
    else:
        print("Enabling S3 version...")
        s3_resource = boto3.resource("s3", region)
        s3_resource.BucketVersioning(bucket_name).enable()
        

if __name__ == "__main__":
    check_s3_versioning(BUCKET_NAME, REGION)
