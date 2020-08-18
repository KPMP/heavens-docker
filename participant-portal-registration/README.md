This docker-compose is used to run a development environment for the participant portal user registration pages. When in production, this will allow the participatnt to complete their registration for the participant portal.

Steps to bring this app up:
1) download portal-reg and portal-acc from the UW gitlab
2) Ensure you have maven installed on your machine
3) cd into the portal-acc project
4) 'mvn package'
5) Install  jar in the local maven repository
mvn install:install-file -Dfile=/Users/rlreamy/git/kpmp/portal-acc/target/accounts-1.0.jar -DgroupId=org.kpmp.portal -DartifactId=accounts -Dversion=1.0 -Dpackaging=jar -DgeneratePom=true

Make sure to replace pathing as appropriate and version info as appropriate
6) cd into the portal-reg project
7) 'mvn package'
8) Copy the .env.example to .env
9) Edit the .env to point at the appropriate files
10) docker-compose up -d
11) Navigate to localhost:8080
12) Log in to adminer with root/example
13) Import the database-script.sql
14) point your browser at localhost/registration/registration.htm
