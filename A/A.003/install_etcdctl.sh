#!/usr/bin/env bash

# arm64(Apple Silicon): the same version(v3.4.15) from the official etcd release
if [ "$(dpkg --print-architecture)" = "arm64" ]; then
  curl -L https://github.com/etcd-io/etcd/releases/download/v3.4.15/etcd-v3.4.15-linux-arm64.tar.gz \
    | tar -xzf - -C /usr/local/bin --strip-components=1 etcd-v3.4.15-linux-arm64/etcdctl
else
  curl https://raw.githubusercontent.com/sysnet4admin/BB/main/etcdctl/v3.4.15/etcdctl -o /usr/local/bin/etcdctl
fi
chmod +x /usr/local/bin/etcdctl
echo "etcdctl successfully installed"
