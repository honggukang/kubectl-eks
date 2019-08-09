# kubectl로 EKS 클러스터에 접근 가능한 도커

## 사용방법


### 이미지 빌드

```
docker build -t kubectl-eks:1.0 ./
```

### 컨테이너 실행

```
docker run -itd --name kubectl-eks \
-e EKS_CLUSTER_NAME=${EKS_CLUSTER_NAME} \
-e EKS_CLUSTER_ENDPOINT=${EKS_CLUSTER_ENDPOINT} \
-e EKS_CLUSTER_AUTH=${EKS_CLUSTER_AUTH} \
-e K8S_USER_TOKEN=${K8S_SECRET_TOKEN} \
kubectl-eks:1.0
```

환경변수
- KUBECONFIG : kubectl config 경로 (default : /.kube/config)
- EKS_CLUSTER_NAME : eks 클러스터 이름 (default : tmp_value)
- EKS_CLUSTER_ENDPOINT : eks 클러스터 api 서버 엔드포인트 (default : https\\:\\/\\/guppy.eks.amazonaws.com)
- EKS_CLUSTER_AUTH : eks 클러스터 인증번호 (default : tmp_value)
- K8S_USER_TOKEN : k8s 시크릿 토큰 (default : tmp_value)

### 컨테이너 접속

```
docker exec -it $(docker ps --filter="name=kubectl-eks" -aq) /bin/bash

> kubectl config view
...
> kubectl verison
Client Version: version.Info{Major:"1", Minor:"15", GitVersion:"v1.15.2", GitCommit:"f6278300bebbb750328ac16ee6dd3aa7d3549568", GitTreeState:"clean", BuildDate:"2019-08-05T09:23:26Z", GoVersion:"go1.12.5", Compiler:"gc", Platform:"linux/amd64"}
Server Version: version.Info{Major:"1", Minor:"13+", GitVersion:"v1.13.8-eks-a977ba", GitCommit:"a977bab148535ec195f12edc8720913c7b943f9c", GitTreeState:"clean", BuildDate:"2019-07-29T20:47:04Z", GoVersion:"go1.11.5", Compiler:"gc", Platform:"linux/amd64"}

```
