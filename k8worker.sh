#!/bin/bash


apt-get update && apt-get upgrade -y

apt-get install -y apt-transport-https awscli curl sudo ssh docker.io python python-pip awscli linux-headers-$(uname -r)

export HOME="/home/ubuntu/" 

export OUTPUT="json"

export REGION="<yourregion>"

export AWS_ACCESS_KEY_ID="<youraccesskey>" 

export AWS_SECRET_ACCESS_KEY="<yoursecretkey>"  

export ACCESS_KEY=SysdigAccessKey 

export S3DOWNLOAD=`aws s3 cp s3://yourbucketname/path/jointoken.txt jointoken.txt` 

export JOIN_TOKEN=`more jointoken.txt`

export AK=`echo $ACCESS_KEY`   

sudo aws configure set default.region $REGION   

sudo aws configure set default.output $OUTPUT 

sudo aws configure set aws_access_key_id $AWS_ACCESS_KEY_ID  

sudo aws configure set aws_secret_access_key $AWS_SECRET_ACCESS_KEY

swapoff --all

sudo curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -

cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb http://apt.kubernetes.io/ kubernetes-xenial main
EOF

sudo apt-get update -y 

sudo apt-get install -y kubelet kubeadm kubectl 

$JOIN_TOKEN 

export KUBECONFIG=/etc/kubernetes/admin.conf 

sudo curl -s https://s3.amazonaws.com/download.draios.com/stable/install-agent | sudo bash -s -- --access_key $AK


