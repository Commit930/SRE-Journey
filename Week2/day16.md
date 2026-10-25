# Writing a Dockerfile

A Dockerfile is a recipe with 4 core components
- FROM - the base you're building on top of
- COPY - copies your actual code from your machine into the image
- EXPOSE - documents which port app uses(doesn't do the real mapping)
- CMD - the command that runs when a container starts from this image

## Dockerfile

FROM python:3.11
COPY app_server.py app/app_server.py
EXPOSE 8081
CMD ["python3", "app/app_server.py", "8081"]

## Build and run

docker build -t myapp .
docker run -d -p 8081:8081 myapp

## Bug1 Container crashed immediately with exit code 1
docker logs <container id>
Indexerror: list is out of range
This was because CMD was missing the port argument - app_server.py expects a port passed in sys.arg[1]. 
Fixed it by adding port 8081 to CMD list.

## Bug2 port already in use

8081 was already using by application on VM,
sudo ss -tulnp | grep 8081
killed it with sudo kill <PID>, then it ran fine.

## key lesson

One image can be run as multiple containers, as long as each uses a different HOST port. Container internal ports can repeat,
where as HOST port side must be unique.

