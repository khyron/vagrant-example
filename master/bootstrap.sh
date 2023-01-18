#!/bin/bash
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-add-repository -y ppa:ansible/ansible
sudo apt-get update
sudo apt-get install ansible -y
sudo ssh-keygen -q -t rsa -N '' -f ~/.ssh/id_rsa <<<y >/dev/null 2>&1
sudo su vagrant -c "ssh-keygen -q -t rsa -N '' -f ~/.ssh/id_rsa <<<y >/dev/null 2>&1"
echo root:vagrant |sudo chpasswd
sudo -- bash -c 'echo "[server-lbs]" >> /etc/ansible/hosts'
sudo -- bash -c 'echo "[server-webs]" >> /etc/ansible/hosts'
sudo -- bash -c 'echo "[server-dbs]" >> /etc/ansible/hosts'

