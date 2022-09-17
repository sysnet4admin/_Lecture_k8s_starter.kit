>>> From Master(Control-Plane) node
kubeadm upgrade plan 
yum list kubeadm --showduplicates
kubeadm upgrade apply 1.25.1
# begin; error!!!
# [upgrade/version] FATAL: the --version argument is invalid due to these errors:

#         - Specified version to upgrade to "v1.25.1" is higher than the kubeadm version "v1.25.0". Upgrade kubeadm first using the tool you used to install kubeadm

# Can be bypassed if you pass the --force flag
# end; thus...
yum upgrade -y kubeadm-1.25.1

[root@m-k8s ~]# kubeadm version
kubeadm version: &version.Info{Major:"1", Minor:"25", GitVersion:"v1.25.1", GitCommit:"e4d4e1ab7cf1bf15273ef97303551b279f0920a9", GitTreeState:"clean", BuildDate:"2022-09-14T19:47:53Z", GoVersion:"go1.19.1", Compiler:"gc", Platform:"linux/amd64"}

kubeadm upgrade apply 1.25.1 
# [upgrade] Are you sure you want to proceed? [y/N]: y

====== will change??? =====

[root@m-k8s ~]# kubectl get nodes 
NAME     STATUS   ROLES           AGE   VERSION
m-k8s    Ready    control-plane   26m   v1.25.0
w1-k8s   Ready    <none>          22m   v1.25.0
w2-k8s   Ready    <none>          19m   v1.25.0
w3-k8s   Ready    <none>          16m   v1.25.0

[root@m-k8s ~]# kubectl version 
WARNING: This version information is deprecated and will be replaced with the output from kubectl version --short.  Use --output=yaml|json to get the full version.
Client Version: version.Info{Major:"1", Minor:"25", GitVersion:"v1.25.0", GitCommit:"a866cbe2e5bbaa01cfd5e969aa3e033f3282a8a2", GitTreeState:"clean", BuildDate:"2022-08-23T17:44:59Z", GoVersion:"go1.19", Compiler:"gc", Platform:"linux/amd64"}
Kustomize Version: v4.5.7
Server Version: version.Info{Major:"1", Minor:"25", GitVersion:"v1.25.1", GitCommit:"e4d4e1ab7cf1bf15273ef97303551b279f0920a9", GitTreeState:"clean", BuildDate:"2022-09-14T19:42:30Z", GoVersion:"go1.19.1", Compiler:"gc", Platform:"linux/amd64"}

[root@m-k8s ~]# kubelet --version 
Kubernetes v1.25.0

[root@m-k8s ~]# yum upgrade kubelet-1.25.1 -y

## After 

[root@m-k8s ~]# kubelet --version 
Kubernetes v1.25.1

[root@m-k8s ~]# kubectl get nodes
NAME     STATUS   ROLES           AGE   VERSION
m-k8s    Ready    control-plane   29m   v1.25.0
w1-k8s   Ready    <none>          25m   v1.25.0
w2-k8s   Ready    <none>          22m   v1.25.0
w3-k8s   Ready    <none>          19m   v1.25.0

[root@m-k8s ~]# systemctl restart kubelet 
Warning: kubelet.service changed on disk. Run 'systemctl daemon-reload' to reload units.

[root@m-k8s ~]# systemctl daemon-reload

[root@m-k8s ~]# kubectl get nodes 
NAME     STATUS   ROLES           AGE   VERSION
m-k8s    Ready    control-plane   30m   v1.25.1
w1-k8s   Ready    <none>          26m   v1.25.0
w2-k8s   Ready    <none>          23m   v1.25.0
w3-k8s   Ready    <none>          20m   v1.25.0

>>> From worker nodes 
[root@w1-k8s ~]# yum upgrade -y kubeadm-1.25.1

[root@w1-k8s ~]# kubeadm upgrade node
[upgrade] Reading configuration from the cluster...
<snipped>
[root@w1-k8s ~]# yum upgrade kubelet-1.25.1 -y
[root@w1-k8s ~]# kubelet --version
Kubernetes v1.25.1
[root@w1-k8s ~]# systemctl restart kubelet
Warning: kubelet.service changed on disk. Run 'systemctl daemon-reload' to reload units.
[root@w1-k8s ~]# systemctl daemon-reload


