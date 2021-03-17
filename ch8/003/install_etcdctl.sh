#!/usr/bin/env bash

curl https://raw.githubusercontent.com/sysnet4admin/BB/main/etcdctl/v3.4.15/etcdctl -o /usr/local/bin/etcdctl
chmod +x /usr/local/bin/etcdctl
echo "etcdctl successfully installed"
