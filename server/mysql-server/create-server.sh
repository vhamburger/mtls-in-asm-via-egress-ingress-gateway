export CERTS_ROOT="../../mysql-eks-certs"

kubectl delete --ignore-not-found=true -n istio-system secret mysql-credential

kubectl -n istio-system patch --type=json svc istio-ingressgateway -p "$(cat gateway-patch.json)"

kubectl create -n istio-system secret generic mysql-credential \
--from-file=tls.key=$CERTS_ROOT/3_application/private/mysql-mutual-tls-eks.jeremysolarz.app.key.pem \
--from-file=tls.crt=$CERTS_ROOT/3_application/certs/mysql-mutual-tls-eks.jeremysolarz.app.cert.pem \
--from-file=ca.crt=$CERTS_ROOT/2_intermediate/certs/ca-chain.cert.pem

kubectl apply -f istio-mysql.yaml