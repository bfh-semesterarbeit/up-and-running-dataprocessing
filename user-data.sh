#!/bin/bash
apt-get update

# get git
apt install -y git-all

# install ansible
apt install -y software-properties-common
apt-add-repository --yes --update ppa:ansible/ansible
apt install -y ansible

# get project
git clone https://github.com/bfh-semesterarbeit/up-and-running-dataprocessing.git /home/ubuntu/up-and-running-dataprocessing

