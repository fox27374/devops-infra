#!/bin/bash

docker pull guacamole/guacd
docker pull guacamole/guacamole
docker pull postgres:13

sudo mkdir -p /opt/guacamole/init
sudo mkdir -p /opt/guacamole/data
sudo touch /opt/guacamole/init/initdb.sql

chown -R root:ansible /opt/guacamole

docker run --rm guacamole/guacamole /opt/guacamole/bin/initdb.sh --postgresql > /opt/guacamole/init/initdb.sql