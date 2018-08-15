#!/bin/bash


apt-get update && apt-get upgrade -y

apt-get install -y apt-transport-https curl ssh docker.io python python-pip linux-headers-$(uname -r)

apt-get install -y awscli 

sudo aws configure set default.region $REGION 

sudo aws configure set default.output $OUTPUT 

sudo aws configure set aws_access_key_id $AWS_ACCESS_KEY_ID  

sudo aws configure set aws_secret_access_key $AWS_SECRET_ACCESS_KEY 

sudo curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -

cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb http://apt.kubernetes.io/ kubernetes-xenial main
EOF

swapoff --all

sudo apt-get update -y 

sudo apt-get install -y kubelet kubeadm kubectl

export S3JOIN=`aws s3 cp s3://lavoie-kubejointoken/join/jointoken.txt $HOME/jointoken.txt` 

export S3JOIN_OUTPUT=`more jointoken.txt`

export JOIN_TOKEN=`echo $S3JOIN_OUTPUT ` 

$JOIN_TOKEN 

sudo curl -s https://s3.amazonaws.com/download.draios.com/stable/install-agent | sudo bash -s -- --access_key $ACCESS_KEY





