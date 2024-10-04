#! /bin/bash

curl -sfL https://get.k3s.io | K3S_KUBECONFIG_MODE="644" sh -s - \
  --flannel-backend=none \
  --disable-kube-proxy \
  --disable servicelb \
  --disable-network-policy \
  --disable traefik \
  --cluster-init