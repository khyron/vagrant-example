#!/bin/bash
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install sshpass -y
sudo su vagrant -c "ssh-keygen -q -t rsa -N '' -f ~/.ssh/id_rsa <<<y >/dev/null 2>&1"
touch /home/vagrant/.ssh/authorized_keys
touch /home/vagrant/.ssh/known_hosts
ipad=$(ip a |grep 192 |awk '{print $2}'|head -c -4)
hnm=$(hostname)
ssh-keyscan -H 192.168.56.10 >> /home/vagrant/.ssh/known_hosts
sshpass -p vagrant ssh  -o StrictHostKeyChecking=no vagrant@192.168.56.10  "cat /home/vagrant/.ssh/id_rsa.pub " > /tmp/tempkey
sudo cat /tmp/tempkey >> /home/vagrant/.ssh/authorized_keys
sshpass -p vagrant ssh  -o StrictHostKeyChecking=no vagrant@192.168.56.10  "ssh-keyscan -H $hnm,$ipad >> /home/vagrant/.ssh/known_hosts"
sshpass -p vagrant ssh  -o StrictHostKeyChecking=no vagrant@192.168.56.10  "sudo -- bash -c 'echo "$ipad   $hnm" >> /etc/hosts'"

if [[ $hnm =~ "lb" ]]; then
sshpass -p vagrant ssh  -o StrictHostKeyChecking=no vagrant@192.168.56.10  "sudo -- bash -c 'sed -i '/server-lbs/a$hnm' /etc/ansible/hosts'"
fi
if [[ $hnm =~ "web" ]]; then
sshpass -p vagrant ssh  -o StrictHostKeyChecking=no vagrant@192.168.56.10  "sudo -- bash -c 'sed -i '/server-webs/a$hnm' /etc/ansible/hosts'"
fi
if [[ $hnm =~ "db" ]]; then
sshpass -p vagrant ssh  -o StrictHostKeyChecking=no vagrant@192.168.56.10  "sudo -- bash -c 'sed -i '/server-dbs/a$hnm' /etc/ansible/hosts'"
fi


