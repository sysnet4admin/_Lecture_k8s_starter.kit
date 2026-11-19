<w1-k8s>
systemctl stop kubelet 
systemctl status kubelet

<cp-k8s>
kubectl apply -f ~/_Lecture_k8s_starter.kit/ch5/5.1/del-deploy.yaml 
kubectl get pod -o wide 

<w1-k8s>
systemctl start kubelet 
systemctl status kubelet

<cp-k8s>
kubectl get pod -o wide 

##################################

<w1-k8s>
systemctl stop containerd
systemctl status containerd

<cp-k8s>
kubectl scale deployment del-deploy --replicas=6
kubectl get pod -o wide 

##################################
<w1-k8s>
systemctl start containerd
systemctl status containerd 

<cp-k8s>
kubectl scale deployment del-deploy --replicas=9
kubectl get pod -o wide 
