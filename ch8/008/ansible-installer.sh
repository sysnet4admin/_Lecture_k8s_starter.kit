#!/usr/bin/env bash

# install ansible 
yum install ansible-2.9.27-1.el7 -y 

# setup ansible hosts 
cat <<EOF > /etc/ansible/hosts
[nodes]
192.168.1.[101:103]
EOF

# ansible alias 
echo "alias ans=ansible"          >> /root/.bashrc
echo "alias anp=ansible-playbook" >> /root/.bashrc