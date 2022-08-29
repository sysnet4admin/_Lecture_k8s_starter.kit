<w1-k8s>
systemctl stop kubelet 
systemctl status kubelet

<m-k8s>
kubectl apply -f ~/_Lecture_k8s_starter.kit/ch4/4.1/del-deploy.yaml 
kubectl get pod -o wide 

<w1-k8s>
systemctl start kubelet 
systemctl status kubelet

<m-k8s>
kubectl get pod -o wide 

##################################

<w1-k8s>
systemctl stop containerd
systemctl status containerd

<m-k8s>
kubectl scale deployment del-deploy --replicas=6
kubectl get pod -o wide 

##################################
<w1-k8s>
systemctl start containerd
systemctl status continaerd 

<m-k8s>
kubectl scale deployment del-deploy --replicas=9
kubectl get pod -o wide 
