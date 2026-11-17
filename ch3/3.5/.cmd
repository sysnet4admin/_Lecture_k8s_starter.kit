kubectl delete service chk-hn
kubectl delete service deploy-nginx 
kubectl delete service nginx 

kubectl delete deployment chk-hn
kubectl delete deployment deploy-nginx 
kubectl delete pod nginx 

kubectl delete -f ~/_Lecture_k8s_starter.kit/ch3/3.4/metallb.yaml
