#!/bin/bash

docker pull guacamole/guacd
docker pull guacamole/guacamole
docker pull postgres:17

sudo mkdir -p /opt/guacamole/init
sudo mkdir -p /opt/guacamole/data
sudo touch /opt/guacamole/init/initdb.sql
sudo chmod g+w /opt/guacamole/init/initdb.sql

sudo chown -R root:ansible /opt/guacamole

docker run --rm guacamole/guacamole /opt/guacamole/bin/initdb.sh --postgresql > /opt/guacamole/init/initdb.sql
