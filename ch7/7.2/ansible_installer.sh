#!/usr/bin/env bash

# ansible 
## install ansible 
#apt-get install python3-pip -y
#python3 -m pip install --user ansible-core==2.16.6
apt-get install ansible sshpass -y

## Tested this version  
## ansible --version 
## ansible [core 2.16.6]

## setup default ansible hosts (Ubuntu only)
mkdir /etc/ansible 
cat <<EOF > /etc/ansible/hosts
[Control_Plane]
192.168.1.10

[Workers]
192.168.1.[101:103]
EOF

## ansible alias 
echo "alias ans=ansible"          >> ~/.bashrc
echo "alias anp=ansible-playbook" >> ~/.bashrc

## avoid [WARNING]: Updating cache and auto-installing missing dependency: python3-apt
export ansible_python_interpreter=/usr/bin/python3


# auto_pass to ansible_nodes 

## read hosts from file 
readarray HOSTS < /etc/hosts

## 1.known_hosts##
if [ ! -f ~/.ssh/known_hosts ]; then
  for HOST in ${HOSTS[@]}; do
    ssh-keyscan -t ecdsa ${HOST} >> ~/.ssh/known_hosts
  done
fi

## 2.authorized_keys
if [ ! -f ~/.ssh/id_rsa.pub ]; then
  ssh-keygen -b 2048 -t rsa -f ~/.ssh/id_rsa -q -N ''
    for HOST in ${HOSTS[@]}; do 
       sshpass -p vagrant ssh-copy-id -f ${HOST}
    done
fi
