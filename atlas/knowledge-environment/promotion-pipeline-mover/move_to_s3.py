import boto3
import os
from botocore.client import Config
from dotenv import load_dotenv
import sys
import argparse
def upload_to_s3(file_name, file_directory, bucket_name):
  load_dotenv()
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
  if bucket_name in bucket_list and os.path.exists(file_directory): 
    s3.upload_file(
    Filename=file_directory,
    Bucket=bucket_name,
    Key=file_name
  )
    sys.exit(200)
  else:
    sys.exit(404)
  
if __name__ == "__main__":
  parser = argparse.ArgumentParser()
  parser.add_argument(
    "-f",
    "--file_name",
    required=True,
    help="Name of file to be moved",
  )
  parser.add_argument(
    '-d',
    '--file_dir',
    required=True,
    help="file directory inside container"
  )
  parser.add_argument(
    '-b',
    '--bucket_name',
    required=True,
    help="Name of S3 bucket uploading to"
  )
  args = parser.parse_args()
  # print(args.file_name, args.file_dir, args.bucket_name)
  upload_to_s3(args.file_name, args.file_dir, args.bucket_name)