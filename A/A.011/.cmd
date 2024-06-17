# M1,M2,ARM
## pre-requirements
yum install jq -y

## run arm64 platform
docker pull nginx --platform=linux/arm64
docker images
docker inspect <images-id> | jq .[].Architecture
docker run <image-id>
WARNING: The requested image's platform (linux/arm64/v8) does not match the detected host platform (linux/amd64) and no specific platform was requested
exec /docker-entrypoint.sh: exec format error

## pull arm64
docker pull mysql --platform=linux/arm64
docker pull redis --platform=linux/arm64
(https://hub.docker.com/search?q=&type=image&image_filter=official)
docker pull sysnet4admin/chk-hn --platform=linux/arm64


# Minikube
## deploy minikube 
minikube start --force --driver=docker --nodes 2

## deploy pod & expose service on minikube
k create deploy nginx --image nginx --replicas=2
k expose deploy nginx --type=LoadBalancer --port=80
tunnel 

## node management 
minikube node add
minikube ssh --node minikube-m03
docker ps
minikube node stop minikube-m02 # pod evict is not working 

## not normal status 
k get po -A -o yaml | grep -i taint 

# EKS,AKS,GKE
There is not control-plane node's components


