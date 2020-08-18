This docker-compose is used to run a development environment for the participant portal admin pages. When in production, this will allow the administrators to create new accounts for participants.

Steps to bring this app up:
1) download portal-acc from the UW gitlab
2) Ensure you have maven installed on your machine
3) cd into the portal-acc project
4) 'mvn package'
5) Copy the .env.example to .env
6) Edit the .env to point at the appropriate files
7) docker-compose up -d
8) Navigate to localhost:8080
9) Log in to adminer with root/example
10) Import the database-script.sql
11) point your browser at localhost/accounts/accounts.htm
