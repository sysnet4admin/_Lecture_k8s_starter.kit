ETCDCTL_API=3 etcdctl --endpoints=https://[192.168.1.10]:2379 --cacert=/etc/kubernetes/pki/etcd/ca.crt --cert=/etc/kubernetes/pki/etcd/server.crt --key=/etc/kubernetes/pki/etcd/server.key get --prefix=true "" > /tmp/prefix

cat /tmp/prefix | nl | tail 
cat /tmp/prefix | nl | grep -i 'pod":"sysnet4admin'
