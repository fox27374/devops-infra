#! /bin/bash

curl -sfL https://get.k3s.io | sh -s - \
	--write-kubeconfig-mode=644 \
	--cluster-cidr="172.20.0.0/16" \
	--service-cidr="172.21.0.0/16" \
	--cluster-dns="172.21.0.10"
