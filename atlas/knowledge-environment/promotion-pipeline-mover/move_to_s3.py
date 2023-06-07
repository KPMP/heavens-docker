import boto3
import os
from botocore.client import Config
from dotenv import load_dotenv
import sys
import getopt
def input_version_number(argv):
    arg_name = ""
    arg_dir = ""
    arg_obj = ""
    arg_help = "{0} -f <file_name>".format(argv[0]) + "{1} -d <file_dir>".format(argv[1]) + "{2} -o <obj_name>".format(argv[2])
    
    try:
        opts, args = getopt.getopt(argv[1:], "h:f:d:o:", ["help", "file_name=", "file_dir=", "obj_name="])
    except:
        print(arg_help)
        sys.exit(2)
    
    for opt, arg in opts:
        if opt in ("-h", "--help"):
            print(arg_help)  # print the help message
            sys.exit(2)
        elif opt in ("-v", "--version"):
            arg_ver = arg
    if arg_ver == "":
      generate_index()
      
    else:
      generate_index(None, arg_ver)
      
load_dotenv()

def upload_to_s3(file_name, file_directory, bucket_name):
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
  
  if bucket_name in bucket_list and os.path.exists(): 
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