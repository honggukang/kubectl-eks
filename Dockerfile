FROM ubuntu:16.04

# Run the Update
RUN apt-get update && apt-get upgrade -y

# Install pre-reqs
RUN apt-get install -y python curl openssh-server

# Setup sshd
RUN mkdir -p /var/run/sshd
RUN echo 'root:password' | chpasswd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# Download and install pip
RUN curl -sO https://bootstrap.pypa.io/get-pip.py
RUN python get-pip.py

# Install AWS CLI
RUN pip install awscli

# Setup AWS CLI Command Completion
RUN echo complete -C '/usr/local/bin/aws_completer' aws >> ~/.bashrc

# Install kubectl
RUN apt-get update && apt-get install -y apt-transport-https && \
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - && \
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | tee -a /etc/apt/sources.list.d/kubernetes.list && \
apt-get update && apt-get install -y kubectl && \
apt-get update && apt-get install -y vim

# Setup kubectl cluster
ENV KUBECONFIG=$KUBECONFIG:/.kube/config
ENV EKS_CLUSTER_NAME tmp-value
ENV EKS_CLUSTER_ENDPOINT https\\:\\/\\/guppy.eks.amazonaws.com
ENV EKS_CLUSTER_AUTH tmp-value
ENV K8S_USER_TOKEN tmp-value

WORKDIR /
RUN mkdir -p .kube/
COPY ./config /.kube/config

COPY ./entry-point.sh /entry-point.sh
RUN chmod +x /entry-point.sh
ENTRYPOINT ["/bin/bash", "/entry-point.sh"]

EXPOSE 22
