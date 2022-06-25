#!/bin/bash
#Added bashtrap for smooth and clean suspending of the script
trap bashtrap INT
bashtrap()
{
	echo "Received interruption signal! Suspending the search. Removing any existing containers and closing connections."
	docker rm -f $(docker ps -a -q)
	docker container prune -f && docker image prune -f
	cyberghostvpn --stop
	exit 1
}

cyberghostvpn --country-code BY --connect
docker run -it --rm ghcr.io/porthole-ascend-cinnamon/proxy_finder:latest --threads 2500
#removed [--pull always]
