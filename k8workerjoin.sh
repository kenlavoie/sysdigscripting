#!/bin/bash


apt-get update && apt-get upgrade -y

apt-get install -y apt-transport-https awscli curl sudo ssh docker.io python python-pip awscli linux-headers-$(uname -r)

export HOME="/home/ubuntu/" 

export OUTPUT="json"

export REGION="AWS Region"

export AWS_ACCESS_KEY_ID="<AWS access key>" 

export AWS_SECRET_ACCESS_KEY="<AWS secret key>"  

export ACCESS_KEY=SysdigAccessKeyHere 

export AK=`echo $ACCESS_KEY` 

export TOKENS3UPLOAD="sudo aws s3 cp jointoken.txt s3://<yourbucketname>/<folderpath>/jointoken.txt" 

sudo aws configure set default.region $REGION   

sudo aws configure set default.output $OUTPUT 

sudo aws configure set aws_access_key_id $AWS_ACCESS_KEY_ID  

sudo aws configure set aws_secret_access_key $AWS_SECRET_ACCESS_KEY

sudo curl http://169.254.169.254/latest/meta-data/local-ipv4 > $HOME/ipadd.txt

export EXPORTADDRESS=`more ipadd.txt`  

export IP_ADDRESS=`echo $EXPORTADDRESS` 

sudo curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -

cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb http://apt.kubernetes.io/ kubernetes-xenial main
EOF

sudo apt-get update -y 

sudo apt-get install -y kubelet kubeadm kubectl 

sudo kubeadm config images pull 

sudo apt-mark hold kubelet kubeadm kubectl

sudo kubeadm init --pod-network-cidr=192.168.0.0/16 --apiserver-advertise-address $IP_ADDRESS 

sudo kubeadm token create --print-join-command  > jointoken.txt

$TOKENS3UPLOAD

sleep 10s 

export KUBECONFIG=/etc/kubernetes/admin.conf 

kubectl apply -f \
https://docs.projectcalico.org/v3.1/getting-started/kubernetes/installation/hosted/kubeadm/1.7/calico.yaml

kubectl taint nodes --all node-role.kubernetes.io/master-  

curl -s https://s3.amazonaws.com/download.draios.com/stable/install-agent | sudo bash -s -- --access_key $ACCESS_KEY




