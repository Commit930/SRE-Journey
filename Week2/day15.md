#Docker Basics

Started learning docker. Containers are lightweight as they share host's kernel and isolated using namespaces(what they can see) and cgroups(resource limits). This is why stsrt/stop is quicker than a full VM.

## Install

sudo apt update
sudo apt install docker.io -y
docker --version

## Bug 1: Couldn't pull hello-world image - TLS certificate error
The VM's clock was drifted, fixed with 
sudo timedatectl set-ntp true
date (confirmed the update)
manual way is sudo date -s "10-26-01 HH:MM:SS"

## Bug 2: Permission denied to connect to docker.sock
docker.sock was owned by root:docker my  user wasn't in the group
ls -la /var/run/docker.sock
sudo usermod -aG docker ubuntu
newfrp docker (kind of restarting to apply the updates)

## Container Lifecycle

docker run hello-world - prints a message and exits immeiately, since it's job is done
docker run nginx, runs forever since it's job is to keep listening, so we need to run in detach mode
docker run -d nginx ( This gives us the prompt back)

## Port mapping

docker ps shows us PORT as tcp/80 with no arrow, meaning container is listening to that port internally
and that PORT wasn't connected to the VM at all, FIX is
docker run -d -p 80:80 nginx
curl http://localhost:80