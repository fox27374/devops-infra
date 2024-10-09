#! /bin/bash
export KUBECONFIG=/etc/rancher/k3s/k3s.yaml
cd /opt/lab/np
kubectl delete -f .
cd /opt/lab/deployment
kubectl delete -f .
kubectl delete -f /opt/lab/ns/ns.yaml
kubectl create -f /opt/lab/ns/ns.yaml
kubectl create -f /opt/lab/opa/gatekeeper.yaml
cd /opt/lab/np
kubectl create -f .
cd /opt/lab/deployment
kubectl create -f .
kubectl create -f /opt/lab/ingress/ingress.yaml