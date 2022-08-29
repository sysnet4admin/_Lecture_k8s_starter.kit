kubeadm upgrade plan 
yum list kubeadm --showduplicates
kubeadm upgrade apply 1.25.1
yum upgrade -y kubeadm-1.25.1
kubeadm upgrade apply 1.25.1

====== will change =====

kubeadm version 
kubeadm version: &version.Info{Major:"1", Minor:"20", GitVersion:"v1.20.4", GitCommit:"faecb196815e248d3ecfb03c680a4507229c2a56", GitTreeState:"clean", BuildDate:"2021-01-13T13:25:59Z", GoVersion:"go1.15.5", Compiler:"gc", Platform:"linux/amd64"}

kubectl get nodes 
NAME     STATUS   ROLES                  AGE   VERSION
m-k8s    Ready    control-plane,master   44m   v1.20.2
w1-k8s   Ready    <none>                 40m   v1.20.2
w2-k8s   Ready    <none>                 22m   v1.20.2
w3-k8s   Ready    <none>                 18m   v1.20.2


kubectl version 
Client Version: version.Info{Major:"1", Minor:"20", GitVersion:"v1.20.2", GitCommit:"c4d752765b3bbac2237bf87cf0b1c2e307844666", GitTreeState:"clean", BuildDate:"2020-12-18T12:09:25Z", GoVersion:"go1.15.5", Compiler:"gc", Platform:"linux/amd64"}
Server Version: version.Info{Major:"1", Minor:"20", GitVersion:"v1.20.4", GitCommit:"faecb196815e248d3ecfb03c680a4507229c2a56", GitTreeState:"clean", BuildDate:"2021-01-13T13:20:00Z", GoVersion:"go1.15.5", Compiler:"gc", Platform:"linux/amd64"}


kubelet --version 
Kubernetes v1.25.1 

yum upgrade kubelet-1.25.1 -y


## After 

[root@m-k8s ~]# kubelet --version 
Kubernetes v1.25.1

kubectl get node 
NAME     STATUS   ROLES                  AGE   VERSION
m-k8s    Ready    control-plane,master   49m   v1.20.2
w1-k8s   Ready    <none>                 45m   v1.20.2
w2-k8s   Ready    <none>                 27m   v1.20.2
w3-k8s   Ready    <none>                 23m   v1.20.2

systemctl restart kubelet 
Warning: kubelet.service changed on disk. Run 'systemctl daemon-reload' to reload units.

systemctl daemon-reload

kubectl get nodes 
NAME     STATUS   ROLES                  AGE     VERSION
m-k8s    Ready    control-plane,master   4h17m   v1.20.4
w1-k8s   Ready    <none>                 4h15m   v1.20.2
w2-k8s   Ready    <none>                 4h12m   v1.20.2
w3-k8s   Ready    <none>                 4h9m    v1.20.2
