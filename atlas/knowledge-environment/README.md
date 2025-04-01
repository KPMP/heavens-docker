If this message is seen `Failed to create the storage index: Invalid alias name an index or data stream exists with the same name as the alias`, Take these steps to fix the issue. 

1. Tunnel to machine that's having the issue. `ssh <MACHINE> -L 5602:localhost:5602`
2. Visit `localhost:5602` on your browser and login
3. Click on `Dev Tools`
4. Paste this request into the console: `DELETE /enterprise-search-engine-<NAME-OF-INDEX>/`
5. Verify engine is no longer available `GET /enterprise-search-engine-<NAME-OF-INDEX>/`
6. Go back to app search and create the new index

If this message is seen `Unable to retrieve version information from Elasticsearch nodes. certificate has expired`, take these steps to fix the issue. 

1. Connect to the machine that is having the issue (If you are not already). `ssh <MACHINE>`
2. Back up es-search's certs `docker cp es-search:/usr/share/elasticsearch/config/certs ./`
3. Tunnel into the es-search container `docker exec -it es-search sh`
4. Remove the es-search certs `rm -rf /usr/share/elasticsearch/config/certs`
5. Exit the container
6. Stop the containers `docker compose -f docker-compose.prod.yml down`
7. Remove the certs volume `docker volume rm knowledge-environment_certs`
8. Edit the docker-compose.prod.yml file `vim docker-compose.prod.yml`
9. Uncomment all of the code for the `search-setup` container
    - Make sure you get the `depends_on` as well in the es-search block
10. Save the file (:wq)
11. Start up the container stack `docker compose -f docker-compose.prod.yml`
12. View logs of the search setup `docker logs -f search-setup`
13. See that a cert has been made
14. Edit the docker-compose.prod.yml file again `vim docker-compose.prod.yml`
15. Comment the code for the `search-setup` 
16. Restart the stack `docker-compose -f docker-compose.prod.yml`
17. See that all containers are running
18. View logs of `es-search` container
19. See that `es-search` can connect to the kibana container