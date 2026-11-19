kubectl get pods -n kube-system 
kubectl delete pod kube-scheduler-cp-k8s -n kube-system 

########################

systemctl stop kubelet 
kubectl delete pod kube-scheduler-cp-k8s -n kube-system 
# kubelet is stopped, so this command does not return. press Ctrl+C and go on

kubectl create deployment nginx --image=nginx 
kubectl get pod

kubectl scale deployment nginx --replicas=3
kubectl get pods -o wide 

curl <IP>

systemctl start kubelet 


################################

systemctl stop containerd 
kubectl get pods
kubectl get pods -n kube-system 


curl <IP>

systemctl start containerd 

kubectl delete deployment nginx 

