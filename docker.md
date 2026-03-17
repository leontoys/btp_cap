# Docker
## most used commands
command	explain	shorthand
docker image ls	Lists all images	docker images
docker image rm <image>	Removes an image	docker rmi
docker image pull <image>	Pulls image from a docker registry	docker pull
docker container ls -a	Lists all containers	docker ps -a
docker container run <image>	Runs a container from an image	docker run
docker container rm <container>	Removes a container	docker rm
docker container stop <container>	Stops a container	docker stop
docker container exec <container>	Executes a command inside the container 	docker exec

## Running script
docker run -d -it --name looper ubuntu sh -c 'while true; do date; sleep 1; done'
docker exec looper ls -la
docker exec -it looper bash

## Images
- we can pull from other registries like below. if we omit that, it will pull from default docker hub
docker pull quay.io/podman/hello
- we can pull a specific version or tag like below. if we omit that, it will pull the latest
docker pull ubuntu:25.10
- registry/organisation/image:tag

