#!/bin/bash

OPTS=`getopt -o h:n:l:p:i: --long help,host:,network:,link:,port:,image: -n 'phpmyadmin.sh' -- "$@"`

eval set -- "$OPTS"

name="phpmyadmin"
network="bridge"
mysql_host=localhost
mysql_link=""
service_port=8080
image=$name/$name

while true ; do
  case "$1" in
		-h|--host) mysql_host=$2; shift 2 ;;
		-n|--network) network=$2; shift 2 ;;
		-l|--link) mysql_link=$2; shift 2 ;;
		-p|--port) service_port=$2; shift 2 ;;
		-i|--image) image=$2; shift 2 ;;
		--help)
			echo "Usage:"
			echo
			echo "      -n|--network <network name>    Specify docker network to use. (bridge)                      "
			echo "      -h|--host <hostname/IP>        Specify the host of the MySQL/MariaDB instance. (localhost)  "
			echo "      -l|--link <container name>     Specify docker container to link to. (none)                  "
			echo "      -p|--port <network name>       Port to run phpmyadmin service on. (8080)                    "
			echo "      -i|--image <image name>        Specify a custom docker image to use. (phpmyadmin/phpmyadmin)"
			shift
			exit 0 ;;
		--) shift; break ;;
  esac
done

host="-e PMA_HOST=$mysql_host"

if [ "$mysql_link" ]; then
	host="--link $mysql_link:db"
fi

echo
echo "docker run -it --rm --network=$network --name $name $host -p $service_port:80 $image"
docker run -d --network=$network --name $name $host -p $service_port:80 $image
echo
echo "An instance of phpmyadmin is now available at: http://localhost:$service_port"
echo "Issue command: 'docker rm -vf $name' to stop the service"
