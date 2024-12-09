#! /bin/bash
export KUBECONFIG=/etc/rancher/k3s/k3s.yaml
YAMLDIR=/opt/setup/k3s

cd $YAMLDIR/ns
kubectl apply -f .

cd $YAMLDIR/secret
kubectl apply -f .

cd $YAMLDIR/configmap
kubectl apply -f .

cd $YAMLDIR/service
kubectl apply -f .

cd $YAMLDIR/ingress
kubectl apply -f .

cd $YAMLDIR/deployment
kubectl apply -f .