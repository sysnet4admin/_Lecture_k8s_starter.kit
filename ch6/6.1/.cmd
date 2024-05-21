# From Control-Plane node

## check current version 
root@cp-k8s:~# kubectl get nodes
NAME     STATUS     ROLES           AGE     VERSION
cp-k8s   Ready      control-plane   5m13s   v1.30.0
w1-k8s   Ready      <none>          3m10s   v1.30.0
w2-k8s   Ready      <none>          98s     v1.30.0
w3-k8s   NotReady   <none>          6s      v1.30.0

## plan to upgrade the kubernetes 
root@cp-k8s:~# kubeadm upgrade plan 
[upgrade/config] Making sure the configuration is correct:
[preflight] Running pre-flight checks.
[upgrade/config] Reading configuration from the cluster...
[upgrade/config] FYI: You can look at this config file with 'kubectl -n kube-system get cm kubeadm-config -o yaml'
[upgrade] Running cluster health checks
[upgrade] Fetching available versions to upgrade to
[upgrade/versions] Cluster version: 1.30.1
[upgrade/versions] kubeadm version: v1.30.0
[upgrade/versions] Target version: v1.30.1
[upgrade/versions] Latest version in the v1.30 series: v1.30.1

## apply it (and failed) 
root@cp-k8s:~# kubeadm upgrade apply 1.30.1
[upgrade/config] Making sure the configuration is correct:
[preflight] Running pre-flight checks.
[upgrade/config] Reading configuration from the cluster...
[upgrade/config] FYI: You can look at this config file with 'kubectl -n kube-system get cm kubeadm-config -o yaml'
[upgrade] Running cluster health checks
[upgrade/version] You have chosen to change the cluster version to "v1.30.1"
[upgrade/versions] Cluster version: v1.30.1
[upgrade/versions] kubeadm version: v1.30.0
[upgrade/version] FATAL: the --version argument is invalid due to these errors:

        - Specified version to upgrade to "v1.30.1" is higher than the kubeadm version "v1.30.0". Upgrade kubeadm first using the tool you used to install kubeadm

Can be bypassed if you pass the --force flag
To see the stack trace of this error execute with --v=5 or higher

## due to version 
root@cp-k8s:~# kubeadm version 
kubeadm version: &version.Info{Major:"1", Minor:"30", GitVersion:"v1.30.0", GitCommit:"7c48c2bd72b9bf5c44d21d7338cc7bea77d0ad2a", GitTreeState:"clean", BuildDate:"2024-04-17T17:34:08Z", GoVersion:"go1.22.2", Compiler:"gc", Platform:"linux/amd64"}

## upgrade kubeadm 
root@cp-k8s:~# apt-get install kubeadm=1.30.1-1.1 -y
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
The following packages will be upgraded:
  kubeadm
1 upgraded, 0 newly installed, 0 to remove and 176 not upgraded.
Need to get 10.4 MB of archives.
After this operation, 0 B of additional disk space will be used.
Get:1 https://prod-cdn.packages.k8s.io/repositories/isv:/kubernetes:/core:/stable:/v1.30/deb  kubeadm 1.30.1-1.1 [10.4 MB]
Fetched 10.4 MB in 2s (5,159 kB/s)
(Reading database ... 65164 files and directories currently installed.)
Preparing to unpack .../kubeadm_1.30.1-1.1_amd64.deb ...
Unpacking kubeadm (1.30.1-1.1) over (1.30.0-1.1) ...
Setting up kubeadm (1.30.1-1.1) ...

## check again 
root@cp-k8s:~# kubeadm version 
kubeadm version: &version.Info{Major:"1", Minor:"30", GitVersion:"v1.30.1", GitCommit:"6911225c3f747e1cd9d109c305436d08b668f086", GitTreeState:"clean", BuildDate:"2024-05-14T10:49:05Z", GoVersion:"go1.22.2", Compiler:"gc", Platform:"linux/amd64"}

## upgrade k8s again (input y)
root@cp-k8s:~# kubeadm upgrade apply 1.30.1
[preflight] Running pre-flight checks.
[upgrade/config] Reading configuration from the cluster...
[upgrade/config] FYI: You can look at this config file with 'kubectl -n kube-system get cm kubeadm-config -o yaml'
[upgrade] Running cluster health checks
[upgrade/version] You have chosen to change the cluster version to "v1.30.1"
[upgrade/versions] Cluster version: v1.30.1
[upgrade/versions] kubeadm version: v1.30.1
[upgrade] Are you sure you want to proceed? [y/N]: y
[upgrade/prepull] Pulling images required for setting up a Kubernetes cluster
[upgrade/prepull] This might take a minute or two, depending on the speed of your internet connection
[upgrade/prepull] You can also perform this action in beforehand using 'kubeadm config images pull'
W0521 09:27:48.353132    9918 checks.go:844] detected that the sandbox image "registry.k8s.io/pause:3.6" of the container runtime is inconsistent with that used by kubeadm.It is recommended to use "registry.k8s.io/pause:3.9" as the CRI sandbox image.
[upgrade/apply] Upgrading your Static Pod-hosted control plane to version "v1.30.1" (timeout: 5m0s)...
[upgrade/etcd] Upgrading to TLS for etcd
[upgrade/staticpods] Preparing for "etcd" upgrade
[upgrade/staticpods] Current and new manifests of etcd are equal, skipping upgrade
[upgrade/etcd] Waiting for etcd to become available
[upgrade/staticpods] Writing new Static Pod manifests to "/etc/kubernetes/tmp/kubeadm-upgraded-manifests2036231893"
[upgrade/staticpods] Preparing for "kube-apiserver" upgrade
[upgrade/staticpods] Current and new manifests of kube-apiserver are equal, skipping upgrade
[upgrade/staticpods] Preparing for "kube-controller-manager" upgrade
[upgrade/staticpods] Current and new manifests of kube-controller-manager are equal, skipping upgrade
[upgrade/staticpods] Preparing for "kube-scheduler" upgrade
[upgrade/staticpods] Current and new manifests of kube-scheduler are equal, skipping upgrade
[upload-config] Storing the configuration used in ConfigMap "kubeadm-config" in the "kube-system" Namespace
[kubelet] Creating a ConfigMap "kubelet-config" in namespace kube-system with the configuration for the kubelets in the cluster
[upgrade] Backing up kubelet config file to /etc/kubernetes/tmp/kubeadm-kubelet-config3316154020/config.yaml
[kubelet-start] Writing kubelet configuration to file "/var/lib/kubelet/config.yaml"
[bootstrap-token] Configured RBAC rules to allow Node Bootstrap tokens to get nodes
[bootstrap-token] Configured RBAC rules to allow Node Bootstrap tokens to post CSRs in order for nodes to get long term certificate credentials
[bootstrap-token] Configured RBAC rules to allow the csrapprover controller automatically approve CSRs from a Node Bootstrap Token
[bootstrap-token] Configured RBAC rules to allow certificate rotation for all node client certificates in the cluster
[addons] Applied essential addon: CoreDNS
[addons] Applied essential addon: kube-proxy

[upgrade/successful] SUCCESS! Your cluster was upgraded to "v1.30.1". Enjoy!

[upgrade/kubelet] Now that your control plane is upgraded, please proceed with upgrading your kubelets if you haven't already done so.


## no update k8s 
root@cp-k8s:~# kubectl get nodes
NAME     STATUS   ROLES           AGE     VERSION
cp-k8s   Ready    control-plane   8m55s   v1.30.0
w1-k8s   Ready    <none>          6m52s   v1.30.0
w2-k8s   Ready    <none>          5m20s   v1.30.0
w3-k8s   Ready    <none>          3m48s   v1.30.0

## WHY??
## Because kubelet version is still v1.30.0 

root@cp-k8s:~# kubelet --version
Kubernetes v1.30.0

## so upgrade kubelet version 

root@cp-k8s:~# apt-get install kubelet=1.30.1-1.1 -y
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
The following packages will be upgraded:
  kubelet
1 upgraded, 0 newly installed, 0 to remove and 175 not upgraded.
Need to get 18.1 MB of archives.
After this operation, 0 B of additional disk space will be used.
Get:1 https://prod-cdn.packages.k8s.io/repositories/isv:/kubernetes:/core:/stable:/v1.30/deb  kubelet 1.30.1-1.1 [18.1 MB]
Fetched 18.1 MB in 3s (7,137 kB/s)  
(Reading database ... 65164 files and directories currently installed.)
Preparing to unpack .../kubelet_1.30.1-1.1_amd64.deb ...
Unpacking kubelet (1.30.1-1.1) over (1.30.0-1.1) ...
Setting up kubelet (1.30.1-1.1) ...

## check kubelet version but still k8s is v1.30.0
root@cp-k8s:~# kubelet --version
Kubernetes v1.30.1

root@cp-k8s:~# k get nodes
NAME     STATUS   ROLES           AGE     VERSION
cp-k8s   Ready    control-plane   11m     v1.30.0
w1-k8s   Ready    <none>          9m      v1.30.0
w2-k8s   Ready    <none>          7m28s   v1.30.0
w3-k8s   Ready    <none>          5m56s   v1.30.0

## reload kubelet service  
systemctl restart kubelet
systemctl daemon-reload

## check again 
root@cp-k8s:~# k get nodes
NAME     STATUS   ROLES           AGE   VERSION
cp-k8s   Ready    control-plane   15m   v1.30.1
w1-k8s   Ready    <none>          13m   v1.30.0
w2-k8s   Ready    <none>          11m   v1.30.0
w3-k8s   Ready    <none>          10m   v1.30.0

# FROM Worker nodes 
## run same commands like below 
apt-get install kubelet=1.30.1-1.1 -y
systemctl restart kubelet
systemctl daemon-reload


