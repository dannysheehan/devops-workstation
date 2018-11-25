#!/bin/bash

USERNAME="$1"
GROUPNAME="$2"
NAMESPACE="default"
CLUSTER="minikube"


KUBECTL="/usr/local/bin/kubectl"
SERVER=$(${KUBECTL} config view -o jsonpath='{.clusters[0].cluster.server}')
CA_DATA=$(${KUBECTL} config view --minify=true --flatten -o json | jq '.clusters[0].cluster."certificate-authority-data"' -r)

echo "SERVER: $SERVER"

#
# where user config files will be kept after they are generated
#
USER_CONFIGS="./CERTS"

KUBECONFIG="config"

KUBE_DIR="${USER_CONFIGS}/${CLUSTER}-${USERNAME}"

# make sure no-one can read the files you create but you
mode 077

mkdir -p ${KUBE_DIR}
cd ${KUBE_DIR}

CSR_FILE=${CLUSTER}-client.csr
KEY_FILE=${CLUSTER}-client.key
CRT_FILE=${CLUSTER}-client.crt
CA_FILE=${CLUSTER}-ca.crt

openssl genrsa -out ${KEY_FILE} 4096

openssl req -new -key ${KEY_FILE} \
       -out ${CSR_FILE} -subj "/CN=$USERNAME/O=$GROUPNAME"

CERTIFICATE_NAME="${USERNAME}.${NAMESPACE}"

# https://kubernetes.io/docs/tasks/tls/managing-tls-in-a-cluster/
cat <<EOF | ${KUBECTL} create -f -
apiVersion: certificates.k8s.io/v1beta1
kind: CertificateSigningRequest
metadata:
  name: ${CERTIFICATE_NAME}
spec:
  groups:
  - system:authenticated
  request: $(cat $CSR_FILE | base64 | tr -d '\n')
  usages:
  - digital signature
  - key encipherment
  - client auth
EOF


${KUBECTL} certificate approve ${CERTIFICATE_NAME}


${KUBECTL} create clusterrolebinding $USERNAME-cluster-admin-binding --clusterrole=cluster-admin --user=$USERNAME


${KUBECTL} get csr ${CERTIFICATE_NAME} -o jsonpath='{.status.certificate}'  | base64 -d > $CRT_FILE

CA_DATA=$(${KUBECTL} config view --minify=true --flatten -o json | jq '.clusters[0].cluster."certificate-authority-data"' -r)
echo ${CA_DATA} | base64 --decode > ${CA_FILE}


$KUBECTL --kubeconfig=${KUBECONFIG} config set-cluster $CLUSTER \
      --server=${SERVER} \

$KUBECTL --kubeconfig=${KUBECONFIG} config set-cluster $CLUSTER \
      --certificate-authority=${CA_FILE} \
      --embed-certs=true

exit 0

$KUBECTL --kubeconfig=${KUBECONFIG} config set-credentials $USERNAME \
      --client-key=${CLUSTER}-client.key \
      --client-certificate=${CLUSTER}-client.crt \
      --embed-certs=true

$KUBECTL --kubeconfig=${KUBECONFIG} config set-context ${CLUSTER}-${USERNAME}-${NAMESPACE} \
      --cluster=$CLUSTER \
      --namespace=$NAMESPACE \
      --user=$USERNAME

$KUBECTL --kubeconfig=${KUBECONFIG} config use-context ${CLUSTER}-${USERNAME}-${NAMESPACE}

# cleanup
rm $CSR_FILE $KEY_FILE $CRT_FILE $CA_FILE

# test
$KUBECTL --kubeconfig=${KUBECONFIG} get pods

echo
echo
echo "send ${KUBEDIR}/${KUBECONIF} to ${USERNAME} to install under ~/.kube  That is all!!!"
echo

