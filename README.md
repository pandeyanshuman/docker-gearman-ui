# Gearman UI Dockerfile

This repository contains **Dockerfile** of [Web Interface for Gearman Server](https://github.com/gaspaio/gearmanui).

# Installation
* Install [Docker](https://www.docker.com/)
* Build `docker build -t=gearman-ui:latest github.com/pandeyanshuman/docker-gearman-ui`

Ensure that you have a running Gearman server (either a docker using [docker-gearmand](https://github.com/pandeyanshuman/docker-gearmand) or on a dedicated host)

# Usage
* Run the Gearman UI by linking a running container for Gearman server and expose port 80

``
docker run --name gearman-ui --rm -it --link=gearmand:gearmand -p 80:80 -e SERVER_ADDR=gearmand gearman-ui:latest 
``

* Run the Gearman UI by specifying a dedicated host for Gearman server (say, we have a running Gearman server at 192.168.1.2) and expose port 80

``
docker run --name gearman-ui --rm -it -p 80:80 -e SERVER_ADDR="192.168.1.2" gearman-ui:latest 
``

* Visit http://{IP of the Gearman UI container obtained from ``docker inspect gearman-ui`` } to view the manager UI
