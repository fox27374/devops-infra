#! /bin/bash
export KUBECONFIG=/etc/rancher/k3s/k3s.yaml
YAMLDIR=/opt/setup/k3s

# Wait for the traefik ingressroute to be ready
check_crd() {
    kubectl get crd ingressroutes.traefik.io &> /dev/null
    return $?
}

while true; do
    if check_crd; then
        break
    else
        echo "Waiting for CRD"
    fi
    sleep 1
done

cd $YAMLDIR/ns
kubectl apply -f .

cd $YAMLDIR/secret
kubectl apply -f .

cd $YAMLDIR/pvc
kubectl apply -f .

cd $YAMLDIR/configmap
kubectl apply -f .

cd $YAMLDIR/service
kubectl apply -f .

cd $YAMLDIR/deployment
kubectl apply -f .

cd $YAMLDIR/ingress
kubectl apply -f .