#!/bin/bash

## Tasks
yum update -y
yum install nfs-utils bind-utils net-tools git yum-versionlock -y

## Adding user 'sysadmin' with passwordless sudo privilege
if cat /etc/passwd | grep sysadmin
then
  echo "User sysadmin exists..."
else
  useradd sysadmin
fi

if cat /etc/sudoers | grep sysadmin
then
  echo "User sysadmin already has passwordless sudo access..."
else
  echo -e "sysadmin ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
fi

## Initial setup
yum versionlock clear -y
yum remove -y docker-1.10.3 kubernetes-1.3.0 etcd-2.3.7 \
    kubernetes-client-1.3.0 kubernetes-master-1.3.0 \
    kubernetes-node-1.3.0 docker-common-1.10.3

yum install -y git
yum versionlock git rsyslog

## Git setup
mkdir /home/sysadmin/.ssh
chmod 700 /home/sysadmin/.ssh
cp -vf /vagrant/ssh-keys/* /home/sysadmin/.ssh/
chown -R sysadmin.sysadmin /home/sysadmin/.ssh
chmod 644 /home/sysadmin/.ssh/id_rsa.pub
chmod 400 /home/sysadmin/.ssh/id_rsa


## Docker setup
echo -e "\n[kubernetes]\nname=Kubernetes\n\
baseurl=https://packages.cloud.google.com/\
yum/repos/kubernetes-el7-x86_64\n\
enabled=1\ngpgcheck=1\nrepo_gpgcheck=1\n\
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg\
\thttps://packages.cloud.google.com/yum/doc/rpm-package-key.gpg\n" > /etc/yum.repos.d/kube-docker.repo

yum repolist -y
yum install -y yum-utils device-mapper-persistent-data \
    lvm2 bridge-utils
yum install -y docker-1.13.1 subscription-manager subscription-manager-rhsm subscription-manager-rhsm-certificates
yum versionlock yum-utils device-mapper-persistent-data \
    lvm2 bridge-utils docker \
    container-storage-setup docker-client \
    docker-common oci-umount
openssl s_client -showcerts -servername registry.access.redhat.com -connect registry.access.redhat.com:443 </dev/null 2>/dev/null | openssl x509 -text > /etc/rhsm/ca/redhat-uep.pem


## Kubernetes installation
yum install -y kubectl-1.9.1 kubelet-1.9.1 \
    kubernetes-cni-0.6.0 socat-1.7.3.2 python-rhsm
yum versionlock kubectl-1.9.1 kubelet-1.9.1 \
    kubernetes-cni-0.6.0 socat-1.7.3.2

yum versionlock


## Setup deploy.sh
mkdir -p /home/sysadmin/phaas
echo "ACC" > /home/sysadmin/phaas/environment
cp -vf /vagrant/kubernetes-1.9.1/deploy.sh /home/sysadmin/
chmod +x /home/sysadmin/deploy.sh
chown -R sysadmin.sysadmin /home/sysadmin
