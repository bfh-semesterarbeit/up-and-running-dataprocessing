#!/bin/bash
# vars
MY_USER=ubuntu
HOME_DIR="/home/${MY_USER}"
apt-get update

# get git
apt install -y git-all

# install ansible
apt install -y software-properties-common
apt-add-repository --yes --update ppa:ansible/ansible
apt-get update
apt install -y ansible
apt install -y python-apt

# get project
git clone https://github.com/bfh-semesterarbeit/up-and-running-dataprocessing.git "${HOME_DIR}/up-and-running-dataprocessing"
chown -R ubuntu.ubuntu "${HOME_DIR}/up-and-running-dataprocessing/"

# mount efs
apt install -y nfs-common

mkdir "${HOME_DIR}/data"
chmod go+rw "${HOME_DIR}/data"

mount -t nfs \
-o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport fs-5ace1d90.efs.eu-west-1.amazonaws.com:/ \
"${HOME_DIR}/data"

# run ansible
sleep 10s # waiting for efs
usermod -aG docker ubuntu
cd "${HOME_DIR}/up-and-running-dataprocessing/ansible"
mkdir -p "{HOME_DIR}/log"
chmod 0770 "{HOME_DIR}/log"
 
ansible-playbook ./playbooks/base.yml
