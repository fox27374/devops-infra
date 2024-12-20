#! /bin/bash
export KUBECONFIG=/etc/rancher/k3s/k3s.yaml
YAMLDIR=/opt/setup/k3s

touch $YAMLDIR/config.log

cd $YAMLDIR/ns
kubectl apply -f . >> $YAMLDIR/config.log

cd $YAMLDIR/secret
kubectl apply -f . >> $YAMLDIR/config.log

cd $YAMLDIR/configmap
kubectl apply -f . >> $YAMLDIR/config.log

cd $YAMLDIR/service
kubectl apply -f . >> $YAMLDIR/config.log

cd $YAMLDIR/deployment
kubectl apply -f . >> $YAMLDIR/config.log

cd $YAMLDIR/ingress
kubectl apply -f . >> $YAMLDIR/config.log