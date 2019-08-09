#/bin/bash

sed -i "s/EKS_CLUSTER_NAME/$EKS_CLUSTER_NAME/g" /.kube/config
sed -i "s/EKS_CLUSTER_ENDPOINT/$EKS_CLUSTER_ENDPOINT/g" /.kube/config
sed -i "s/EKS_CLUSTER_AUTH/$EKS_CLUSTER_AUTH/g" /.kube/config
sed -i "s/K8S_USER_TOKEN/$K8S_USER_TOKEN/g" /.kube/config

/usr/sbin/sshd -D
