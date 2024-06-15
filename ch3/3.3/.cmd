kubectl create deployment deploy-nginx --image=nginx
kubectl get pods
kubectl scale deployment deploy-nginx --replicas=3
kubectl get pods