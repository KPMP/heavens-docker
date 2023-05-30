import boto3
import os
from botocore.client import Config
from dotenv import load_dotenv
import sys
load_dotenv()

def upload_to_s3():
  s3 = boto3.client("s3",
                    aws_access_key_id=os.environ.get('AWS_KEY'),
                    aws_secret_access_key=os.environ.get('AWS_SECRET_KEY'),
                    config=Config(signature_version='s3v4'))
  s3_resources = boto3.resource("s3",
                    aws_access_key_id=os.environ.get('AWS_KEY'),
                    aws_secret_access_key=os.environ.get('AWS_SECRET_KEY'),
                    config=Config(signature_version='s3v4'))
  
  bucket_list = []
  for bucket in s3_resources.buckets.all():
    bucket_list.append(bucket.name)
  
  if os.environ.get("BUCKET_NAME") in bucket_list and os.path.exists(os.environ.get("CONTAINER_FILE_LOCATION")): 
    s3.upload_file(
    Filename=os.environ.get("CONTAINER_FILE_LOCATION"),
    Bucket=os.environ.get("BUCKET_NAME"),
    Key=os.environ.get("OBJECT_NAME")
  )
    sys.exit(200)
  
  else:
    sys.exit(404)
  
if __name__ == "__main__":
  upload_to_s3()