# demo-kwok(KUBERNETES WITHOUT KUBELET)

## 사용법
```bash
$ vagrant up
Bringing machine 'kwok-cluster' up with 'virtualbox' provider...
==> kwok-cluster: Importing base box 'sysnet4admin/Ubuntu-k8s'...
==> kwok-cluster: Matching MAC address for NAT networking...
==> kwok-cluster: Checking if box 'sysnet4admin/Ubuntu-k8s' version '0.7.1' is up to date...
==> kwok-cluster: Setting the name of the VM: kwok-cluster
==> kwok-cluster: Clearing any previously set network interfaces...
==> kwok-cluster: Preparing network interfaces based on configuration...
    kwok-cluster: Adapter 1: nat
    kwok-cluster: Adapter 2: hostonly
```
진행이 모두 완료된 이후에 
127.0.0.1:60230 으로 접속하면 됨  

```bash 
root@kwok-cluster:~# k get node -o wide
NAME          STATUS   ROLES   AGE    VERSION   INTERNAL-IP   EXTERNAL-IP   OS-IMAGE    KERNEL-VERSION   CONTAINER-RUNTIME
kwok-w1-k8s   Ready    agent   112s   fake      <none>        <none>        <unknown>   <unknown>        <unknown>
kwok-w2-k8s   Ready    agent   112s   fake      <none>        <none>        <unknown>   <unknown>        <unknown>
kwok-w3-k8s   Ready    agent   112s   fake      <none>        <none>        <unknown>   <unknown>        <unknown>
```
