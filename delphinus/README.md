To use with IIPImage Server:

1. Set delphinus .env to use the Apache image with an IIPImage proxy: 
 - `ENV_APACHE_CONTAINER=kingstonduo/apache-shib-iip`

2. Set the path where the files are stored:
 - `ENV_IMAGE_HOME=/data/images`

3. For DeepZoom format, adjust the file URL in the application to:
  - `images/fcgi-bin/iipsrv.fcgi?DeepZoom=[FILENAME].dzi`
