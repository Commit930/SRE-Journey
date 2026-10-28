# Docker Networking

Learned how containers talk to each other on custom network

## create a custom network

docker create network mynetwork
docker network ls (confirmed my network exists alongside the default/bridge/host/none)

## Run two named containers on it

docker run -d --network mynetwork app1 nginx
docker run -d --network mynetwork app2 nginx

## Test container to container connection by name

docker exec -it app1 curl http://app2
Got nginx's welcome page back. app1 reached aap2 using just it's name,
no IP address, no port mapping to the host at all. 
Used docker exec here and not run because we don't want to create a new container,
I want to run a command inside an already running container, same as ssh-ing into a machine
that is already running.

This is useful because containers always restarts,reboots which means theie container id is
ephermal and cannot use to reach it, likely fails if ID change happens, using the container's NAME
meand docker auto resolves the DNS for the right address.

