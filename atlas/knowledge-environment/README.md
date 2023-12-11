If this message is seen `Failed to create the storage index: Invalid alias name an index or data stream exists with the same name as the alias`, Take these steps to fix the issue. 

1. Tunnel to machine that's having the issue. `ssh <MACHINE> -L 5602:localhost:5602`
2. Visit `localhost:5602` on your browser and login
3. Click on `Dev Tools`
4. Paste this request into the console: `DELETE /enterprise-search-engine-<NAME-OF-INDEX>/`
5. Verify engine is no longer available `GET /enterprise-search-engine-<NAME-OF-INDEX>/`
6. Go back to app search and create the new index