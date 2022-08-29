kubectl expose deployment deploy-nginx --type=NodePort --port=80
kubectl get services 

kubectl apply -f ~/_Lecture_k8s_starter.kit/ch2/2.4/metallb.yaml

kubectl create deployment chk-hn --image=sysnet4admin/chk-hn
kubectl scale deployment chk-hn --replicas=3
kubectl get pods -o wide 

kubectl expose deployment chk-hn --type=LoadBalancer --port=80
kubectl get services 
