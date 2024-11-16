#! /bin/bash
export KUBECONFIG=/etc/rancher/k3s/k3s.yaml
YAMLDIR=/opt/setup/k3s

cd $YAMLDIR/ns
kubectl create -f .

cd $YAMLDIR/secret
kubectl create -f .

cd $YAMLDIR/configmap
kubectl create -f .

cd $YAMLDIR/service
kubectl create -f .

cd $YAMLDIR/ingress
kubectl create -f .

cd $YAMLDIR/deployment
kubectl create -f .