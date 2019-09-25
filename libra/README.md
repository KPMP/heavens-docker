## Libra
NOTE: This docker-compose (Apache only) is only needed for running libra on your local machine. The production app uses the orion Apache image (with the proxy).  

In order to run this on your local machine, you will need to start orion first using the docker-compose.dev.yml file to create the network and bring up the Mongo DB and orion-data. Then shut down the orion apache (`docker stop apache`) so it doesn't interfere with the libra Apache. 

You will need libra-web installed on your machine.
Fill in the appropriate values for .env (you will likely want to run apache-basic).
