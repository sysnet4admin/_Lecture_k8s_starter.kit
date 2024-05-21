#!/usr/bin/env bash

# ansible 
## install ansible 
apt-get install python3-pip -y
python3 -m pip install --user ansible-core==2.16.6

## check ansible version 
## ansible --version 
## ansible [core 2.16.6]

# setup ansible hosts 
cat <<EOF > /etc/ansible/hosts
[Control-Plane]
192.168.1.10

[Workers]
192.168.1.[101:103]
EOF

# ansible alias 
echo "alias ans=ansible"          >> ~/.bashrc
echo "alias anp=ansible-playbook" >> ~/.bashrc

# auto_pass to ansible_nodes 
## make a directory 
mkdir ~/.ssh

## read hosts from file 
readarray HOSTS < /etc/hosts

### 1.known_hosts##
if [ ! -f ~/.ssh/known_hosts ]; then
  for HOST in ${HOSTS[@]}; do
    ssh-keyscan -t ecdsa ${HOSTS} >> ~/.ssh/known_hosts
  done
fi

### 2.authorized_keys
if [ ! -f ~/.ssh/id_rsa.pub ]; then
  ssh-keygen -b 2048 -t rsa -f ~/.ssh/id_rsa -q -N ''
    for HOST in ${HOSTS[@]}; do 
       sshpass -p vagrant ssh-copy-id -f ${HOST}
    done
fi
