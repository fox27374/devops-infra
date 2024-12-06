#! /bin/bash

apt purge -y docker-ce docker-ce-cli containerd.io
apt autoremove -y
rm -rf /var/lib/docker
rm -rf /var/lib/containerd