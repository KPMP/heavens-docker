FROM python:3.8-alpine3.10
RUN apk add py3-pip 
RUN pip3 install boto3
RUN pip3 install python-dotenv
COPY move_to_s3.py /

ENTRYPOINT [ "python3", "move_to_s3.py" ]