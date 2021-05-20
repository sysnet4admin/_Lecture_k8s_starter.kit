kubectl delete service chk-hn
kubectl delete service deploy-nginx 
kubectl delete service nginx 

kubectl delete deployment chk-hn
kubectl delete deployment deploy-nginx 
kubectl delete pod nginx 

kubectl delete -f ~/_Lecture_k8s.starterkit/ch2/2.4/metallb.yaml
