#!/usr/bin/env bash

# install ansible 
yum install ansible-2.9.27-1.el7 -y 

# setup ansible hosts 
cat <<EOF > /etc/ansible/hosts
[master]
192.168.1.10

[worker]
192.168.1.[101:103]
EOF

# ansible alias 
echo "alias ans=ansible"          >> ~/.bashrc
echo "alias anp=ansible-playbook" >> ~/.bashrc

# reload bashrc
source ~/.bashrc

#auto_pass to ansible_nodes 
##make a directory 
mkdir ~/.ssh

##Read hosts from file 
readarray hosts < /etc/hosts

###1.known_hosts##
if [ ! -f ~/.ssh/known_hosts ]; then
  for host in ${hosts[@]}; do
    ssh-keyscan -t ecdsa ${host} >> ~/.ssh/known_hosts
  done
fi

###2.authorized_keys
if [ ! -f ~/.ssh/id_rsa.pub ]; then
  ssh-keygen -b 2048 -t rsa -f ~/.ssh/id_rsa -q -N ''
    for host in ${hosts[@]}; do 
       sshpass -p vagrant ssh-copy-id -f ${host}
    done
fi