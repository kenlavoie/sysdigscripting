#!/bin/bash


apt-get update && apt-get upgrade -y

sudo apt-get install -y apt-transport-https wget sudo curl ssh docker.io python python-pip linux-headers-$(uname -r)

sudo apt-get install -y awscli

sudo aws configure set default.region $REGION 

sudo aws configure set default.output $OUTPUT 

sudo aws configure set aws_access_key_id $AWS_ACCESS_KEY_ID  

sudo aws configure set aws_secret_access_key $AWS_SECRET_ACCESS_KEY 

echo "AWS config complete" 

sudo curl http://169.254.169.254/latest/meta-data/local-ipv4 > $HOME/ipadd.txt

export EXPORTADDRESS=`more ipadd.txt`  

export IP_ADDRESS=`echo $EXPORTADDRESS`  

echo "IP address"

sudo curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -

cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb http://apt.kubernetes.io/ kubernetes-xenial main
EOF

echo "Kube key added"

apt-get update -y 

apt-get install -y kubelet kubeadm kubectl

export KUBECONFIG=/etc/kubernetes/admin.conf

S3JOIN=`aws s3 cp s3://lavoie-kubejointoken/join/jointoken.txt $HOME/jointoken.txt` 

S3JOIN_OUTPUT=`more jointoken.txt`

JOIN_TOKEN=`echo $S3JOIN_OUTPUT ` 

echo $JOIN_TOKEN

sleep 15

curl -s https://s3.amazonaws.com/download.draios.com/stable/install-agent | sudo bash -s -- --access_key $ACCESS_KEY


