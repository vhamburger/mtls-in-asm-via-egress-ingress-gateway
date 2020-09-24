gcloud config set project vch-anthos-demo

gcloud container clusters get-credentials anthos-gcp --region europe-west4 --project vch-anthos-demo

kubectl delete --ignore-not-found=true secret httpbin-server-certs httpbin-ca-certs -n mesh-external
kubectl delete --ignore-not-found=true secret httpbin-client-certs httpbin-ca-certs
kubectl delete --ignore-not-found=true secret httpbin-client-certs httpbin-ca-certs -n istio-system

kubectl delete --ignore-not-found=true service httpbin-external
kubectl delete --ignore-not-found=true virtualservice vs-alias
kubectl delete --ignore-not-found=true gateway istio-egressgateway-httpbin
kubectl delete --ignore-not-found=true serviceentry httpbin-serviceentry
kubectl delete --ignore-not-found=true virtualservice direct-httpbin-through-egress-gateway
kubectl delete --ignore-not-found=true destinationrule originate-mtls-for-httpbin
kubectl delete --ignore-not-found=true destinationrule egressgateway-for-httpbin
kubectl delete --ignore-not-found=true svc sleep
kubectl delete --ignore-not-found=true deployment sleep

# reset ASM
istioctl install \
  -f ../../../istio-1.6.8-asm.9/asm/cluster/istio-operator.yaml \
-f ../../../istio-features.yaml

kubectl get deploy -n istio-system
kubectl get ns