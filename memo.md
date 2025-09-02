# 학습 노트

## 설치
### arm 일 경우
```
$ brew install --cask ./virtualbox-v7.1.10/virtualbox.rb

$ brew install --cask ./vagrant-v2.4.7/vagrant.rb
$ vagrant up

$ brew install --cask ./tabby-v1.0.207/tabby.rb
$ cp ./tabby-v1.0.207/config.yaml ~/Library/Application\ Support/tabby/
```

### tabby 접속 예시
Node 접속 시 초기 비밀번호: vagrant

```
root@cp-k8s:~# k get po -A
root@cp-k8s:~# k get svc -A
```

## 배포를 통한 쿠버네티스 체험
### 배포 및 정상 동작 확인
```
root@cp-k8s:~# kubectl run nginx --image nginx

root@cp-k8s:~# kubectl get pod -o wide
NAME    READY   STATUS    RESTARTS   AGE     IP               NODE     NOMINATED NODE   READINESS GATES
nginx   1/1     Running   0          3m48s   172.16.221.129   w1-k8s   <none>           <none>

root@cp-k8s:~# curl 172.16.221.129
```

### 외부 접속 설정
```
root@cp-k8s:~# kubectl expose pod nginx --type=NodePort --port=80

root@cp-k8s:~# root@cp-k8s:~# kubectl get service
NAME         TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)        AGE
kubernetes   ClusterIP   10.96.0.1        <none>        443/TCP        73m
nginx        NodePort    10.105.186.103   <none>        80:32423/TCP   18s

root@cp-k8s:~# kubectl get nodes -o wide
NAME     STATUS   ROLES           AGE   VERSION   INTERNAL-IP     EXTERNAL-IP   OS-IMAGE             KERNEL-VERSION       CONTAINER-RUNTIME
cp-k8s   Ready    control-plane   73m   v1.30.0   192.168.1.10    <none>        Ubuntu 22.04.5 LTS   5.15.0-142-generic   containerd://1.6.31
w1-k8s   Ready    <none>          72m   v1.30.0   192.168.1.101   <none>        Ubuntu 22.04.5 LTS   5.15.0-142-generic   containerd://1.6.31
w2-k8s   Ready    <none>          71m   v1.30.0   192.168.1.102   <none>        Ubuntu 22.04.5 LTS   5.15.0-142-generic   containerd://1.6.31
w3-k8s   Ready    <none>          70m   v1.30.0   192.168.1.103   <none>        Ubuntu 22.04.5 LTS   5.15.0-142-generic   containerd://1.6.31
```

```
다음 정보 기반으로 curl

80:32423/TCP

192.168.1.101
192.168.1.102
192.168.1.103

---

curl 192.168.1.101:32423
curl 192.168.1.102:32423
curl 192.168.1.103:32423
```

### Deployment 단건
```
root@cp-k8s:~# kubectl create deployment deploy-nginx --image=nginx
deployment.apps/deploy-nginx created

root@cp-k8s:~# kubectl get pods
NAME                            READY   STATUS    RESTARTS   AGE
deploy-nginx-74d7d6d848-bwjlb   1/1     Running   0          24s
nginx                           1/1     Running   0          32m

root@cp-k8s:~# kubectl get pods -o wide
NAME                            READY   STATUS    RESTARTS   AGE   IP               NODE     NOMINATED NODE   READINESS GATES
deploy-nginx-74d7d6d848-bwjlb   1/1     Running   0          51s   172.16.132.1     w3-k8s   <none>           <none>
nginx                           1/1     Running   0          33m   172.16.221.129   w1-k8s   <none>           <none>

root@cp-k8s:~# curl 172.16.221.129
<!DOCTYPE html>
... 생략
</html>
```

### Deployment Pod 배포 수 설정 (ReplicaSet)
```
root@cp-k8s:~# kubectl scale deployment deploy-nginx --replicas=3
deployment.apps/deploy-nginx scaled

root@cp-k8s:~# kubectl get pods
NAME                            READY   STATUS              RESTARTS   AGE
deploy-nginx-74d7d6d848-4rv48   0/1     ContainerCreating   0          8s
deploy-nginx-74d7d6d848-7wdz8   1/1     Running             0          8s
deploy-nginx-74d7d6d848-bwjlb   1/1     Running             0          6m58s
nginx                           1/1     Running             0          39m

root@cp-k8s:~# kubectl get pods
NAME                            READY   STATUS    RESTARTS   AGE
deploy-nginx-74d7d6d848-4rv48   1/1     Running   0          63s
deploy-nginx-74d7d6d848-7wdz8   1/1     Running   0          63s
deploy-nginx-74d7d6d848-bwjlb   1/1     Running   0          7m53s
nginx                           1/1     Running   0          40m
```

### 외부로 노출하기 더 좋은 방법인 로드밸런서
```
root@cp-k8s:~# kubectl expose deployment deploy-nginx --type=NodePort --port=80
service/deploy-nginx exposed

root@cp-k8s:~# kubectl get services
NAME           TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)        AGE
deploy-nginx   NodePort    10.98.194.126    <none>        80:32304/TCP   10s
kubernetes     ClusterIP   10.96.0.1        <none>        443/TCP        107m
nginx          NodePort    10.105.186.103   <none>        80:32423/TCP   34m

root@cp-k8s:~# kubectl get nodes -o wide
NAME     STATUS   ROLES           AGE    VERSION   INTERNAL-IP     EXTERNAL-IP   OS-IMAGE             KERNEL-VERSION       CONTAINER-RUNTIME
cp-k8s   Ready    control-plane   110m   v1.30.0   192.168.1.10    <none>        Ubuntu 22.04.5 LTS   5.15.0-142-generic   containerd://1.6.31
w1-k8s   Ready    <none>          108m   v1.30.0   192.168.1.101   <none>        Ubuntu 22.04.5 LTS   5.15.0-142-generic   containerd://1.6.31
w2-k8s   Ready    <none>          107m   v1.30.0   192.168.1.102   <none>        Ubuntu 22.04.5 LTS   5.15.0-142-generic   containerd://1.6.31
w3-k8s   Ready    <none>          106m   v1.30.0   192.168.1.103   <none>        Ubuntu 22.04.5 LTS   5.15.0-142-generic   containerd://1.6.31

root@cp-k8s:~# 
```

```
deploy-nginx   NodePort    10.98.194.126    <none>        80:32304/TCP   10s
w1-k8s   Ready    <none>          108m   v1.30.0   192.168.1.101   <none>        Ubuntu 22.04.5 LTS   5.15.0-142-generic   containerd://1.6.31
w2-k8s   Ready    <none>          107m   v1.30.0   192.168.1.102   <none>        Ubuntu 22.04.5 LTS   5.15.0-142-generic   containerd://1.6.31
w3-k8s   Ready    <none>          106m   v1.30.0   192.168.1.103   <none>        Ubuntu 22.04.5 LTS   5.15.0-142-generic   containerd://1.6.31

위 정보로

웹 브라우저에서
192.168.1.101:32304
192.168.1.102:32304
192.168.1.103:32304
```

### Deployment를 NodePort로 노출하기 보다는 LoadBalancer를 사용하여 외부 노출
MetalLB

```
root@cp-k8s:~# find . -type f -name "metallb.yaml"
./ch3/3.4/metallb.yaml
 
root@cp-k8s:~# kubectl apply -f ~/_Lecture_k8s_starter.kit/ch3/3.4/metallb.yaml 
namespace/metallb-system created
serviceaccount/controller created
serviceaccount/speaker created
clusterrole.rbac.authorization.k8s.io/metallb-system:controller created
clusterrole.rbac.authorization.k8s.io/metallb-system:speaker created
role.rbac.authorization.k8s.io/config-watcher created
role.rbac.authorization.k8s.io/pod-lister created
role.rbac.authorization.k8s.io/controller created
clusterrolebinding.rbac.authorization.k8s.io/metallb-system:controller created
clusterrolebinding.rbac.authorization.k8s.io/metallb-system:speaker created
rolebinding.rbac.authorization.k8s.io/config-watcher created
rolebinding.rbac.authorization.k8s.io/pod-lister created
rolebinding.rbac.authorization.k8s.io/controller created
daemonset.apps/speaker created
deployment.apps/controller created
configmap/config created

root@cp-k8s:~# kubectl create deployment chk-hn --image=sysnet4admin/chk-hn
deployment.apps/chk-hn created

root@cp-k8s:~# kubectl scale deplyment chk-hn --replicas=3
error: the server doesn't have a resource type "deplyment"

root@cp-k8s:~# kubectl scale deployment chk-hn --replicas=3
deployment.apps/chk-hn scaled

root@cp-k8s:~# kubectl get pods
NAME                            READY   STATUS    RESTARTS   AGE
chk-hn-5f676987b7-jsxxs         1/1     Running   0          28m
chk-hn-5f676987b7-s5t9c         1/1     Running   0          28m
chk-hn-5f676987b7-xrwbh         1/1     Running   0          29m
deploy-nginx-74d7d6d848-4rv48   1/1     Running   0          66m
deploy-nginx-74d7d6d848-7wdz8   1/1     Running   0          66m
deploy-nginx-74d7d6d848-bwjlb   1/1     Running   0          72m
nginx                           1/1     Running   0          105m

root@cp-k8s:~# kubectl expose deployment chk-hn --type=LoadBalancer --port=80
service/chk-hn exposed

root@cp-k8s:~# kubectl get services
NAME           TYPE           CLUSTER-IP       EXTERNAL-IP    PORT(S)        AGE
chk-hn         LoadBalancer   10.105.92.195    192.168.1.11   80:31547/TCP   32m
deploy-nginx   NodePort       10.98.194.126    <none>         80:32304/TCP   107m
kubernetes     ClusterIP      10.96.0.1        <none>         443/TCP        3h34m
nginx          NodePort       10.105.186.103   <none>         80:32423/TCP   141m
```

192.168.1.11 웹 브라우저로 접속
> chk-hn-5f676987b7-jsxxs 출력

실제 존재하는 지 확인
```
root@cp-k8s:~# kubectl get pods -o wide
NAME                            READY   STATUS    RESTARTS   AGE    IP               NODE     NOMINATED NODE   READINESS GATES
chk-hn-5f676987b7-jsxxs         1/1     Running   0          78m    172.16.221.131   w1-k8s   <none>           <none>
chk-hn-5f676987b7-s5t9c         1/1     Running   0          78m    172.16.132.3     w3-k8s   <none>           <none>
chk-hn-5f676987b7-xrwbh         1/1     Running   0          78m    172.16.103.130   w2-k8s   <none>           <none>
deploy-nginx-74d7d6d848-4rv48   1/1     Running   0          115m   172.16.103.129   w2-k8s   <none>           <none>
deploy-nginx-74d7d6d848-7wdz8   1/1     Running   0          115m   172.16.221.130   w1-k8s   <none>           <none>
deploy-nginx-74d7d6d848-bwjlb   1/1     Running   0          122m   172.16.132.1     w3-k8s   <none>           <none>
nginx                           1/1     Running   0          154m   172.16.221.129   w1-k8s   <none>           <none>
```

### 테스트 생성한 것들 삭제
서비스 삭제
```
root@cp-k8s:~# kubectl delete service chk-hn
service "chk-hn" deleted

root@cp-k8s:~# kubectl get service
NAME           TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)        AGE
deploy-nginx   NodePort    10.98.194.126    <none>        80:32304/TCP   114m
kubernetes     ClusterIP   10.96.0.1        <none>        443/TCP        3h41m
nginx          NodePort    10.105.186.103   <none>        80:32423/TCP   148m

root@cp-k8s:~# kubectl get pods -o wide
NAME                            READY   STATUS    RESTARTS   AGE    IP               NODE     NOMINATED NODE   READINESS GATES
chk-hn-5f676987b7-jsxxs         1/1     Running   0          82m    172.16.221.131   w1-k8s   <none>           <none>
chk-hn-5f676987b7-s5t9c         1/1     Running   0          82m    172.16.132.3     w3-k8s   <none>           <none>
chk-hn-5f676987b7-xrwbh         1/1     Running   0          83m    172.16.103.130   w2-k8s   <none>           <none>
deploy-nginx-74d7d6d848-4rv48   1/1     Running   0          120m   172.16.103.129   w2-k8s   <none>           <none>
deploy-nginx-74d7d6d848-7wdz8   1/1     Running   0          120m   172.16.221.130   w1-k8s   <none>           <none>
deploy-nginx-74d7d6d848-bwjlb   1/1     Running   0          127m   172.16.132.1     w3-k8s   <none>           <none>
nginx                           1/1     Running   0          159m   172.16.221.129   w1-k8s   <none>           <none>

root@cp-k8s:~# kubectl delete service deploy-nginx
service "deploy-nginx" deleted

root@cp-k8s:~# kubectl delete service nginx
service "nginx" deleted

root@cp-k8s:~# kubectl get service
NAME         TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP   3h44m
```

deployment 삭제
```
root@cp-k8s:~# kubectl delete deployment chk-hn
deployment.apps "chk-hn" deleted

root@cp-k8s:~# kubectl delete deployment deploy-nginx
deployment.apps "deploy-nginx" deleted

root@cp-k8s:~# kubectl delete pod nginx
pod "nginx" deleted

root@cp-k8s:~# kubectl get service
NAME         TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP   3h47m

root@cp-k8s:~# kubectl get pods
No resources found in default namespace.
```

metallb 삭제
```
root@cp-k8s:~# kubectl delete -f ~/_Lecture_k8s_starter.kit/ch3/3.4/metallb.yaml 
namespace "metallb-system" deleted
serviceaccount "controller" deleted
serviceaccount "speaker" deleted
clusterrole.rbac.authorization.k8s.io "metallb-system:controller" deleted
clusterrole.rbac.authorization.k8s.io "metallb-system:speaker" deleted
role.rbac.authorization.k8s.io "config-watcher" deleted
role.rbac.authorization.k8s.io "pod-lister" deleted
role.rbac.authorization.k8s.io "controller" deleted
clusterrolebinding.rbac.authorization.k8s.io "metallb-system:controller" deleted
clusterrolebinding.rbac.authorization.k8s.io "metallb-system:speaker" deleted
rolebinding.rbac.authorization.k8s.io "config-watcher" deleted
rolebinding.rbac.authorization.k8s.io "pod-lister" deleted
rolebinding.rbac.authorization.k8s.io "controller" deleted
daemonset.apps "speaker" deleted
deployment.apps "controller" deleted
configmap "config" deleted
root@cp-k8s:~# 
```

## 쿠버네티스 인사이드
### 쿠버네티스 구성 요소 확인(+EKS,AKS,GKE 관리형 쿠버네티스)


### 쿠버네티스의 기본 철학
### 실제 쿠버네티스의 파드 배포 흐름

## 문제를 통해 배우는 쿠버네티스
### 쿠버네티스 파드에 문제가 생겼다면
### 쿠버네티스 워커 노드의 구성 요소에 문제가 생겼다면-v1.25
### 쿠버네티스 컨트롤 플레인 노드의 구성 요소에 문제가 생겼다면-v1.25

## 쿠버네티스 오브젝트
### 쿠버네티스에서 오브젝트란
### 쿠버네티스 기본 오브젝트

## 쿠버네티스 Tips
### 쿠버네티스 버전 업그레이드-v1.30
### 앤서블(Ansible)을 통한 쿠버네티스 버전 업그레이드-v1.30
### 오브젝트 예약 단축어

## Closing - 강의 마무리 및 다음 강의 소개 (+쿠버네티스 공부법)
### 강의를 마치며…
### 후속 강의 소개(그림으로 배우는 쿠버네티스)

## 보강 수업 (v1.30 ~)
### 오브젝트와 리소스의 차이
### 기본(default) 설정의 중요성
### Pod-imagePullPolicy
### Deployment-rollingUpdate
### Service-sessionAffinity

## 외부 세미나
### 네전따: 네트워크 엔지니어에게 쿠버네티스는 어떤 의미일까요?
### NCP: kubectl 잘 활용하기
### 바이라인네트워크 - 쿠버네티스의 과거와 현재 그리고 미래

## 보강 수업 (v1.20 ~ v1.25)
### 도커(X), 컨테이너(D)가 중단되었는데 파드가 그대로예요
### vagrant up 실행 시에 발생하는 에러와 해결책
### API서버와 etcd 정보 일치 확인
### 관리형 쿠버네티스(EKS,AKS,GKE)에서 배포하는 경우 같은 점과 다른 점은
### 애플리케이션(파드 | 컨테이너) 배포 추가 예제 (Polaris, Chaos-Mesh)
### macOS X에서 쿠버네티스 랩을 접근하기 위한 터미널 구성
### 숨겨진 기능 및 개선 기능
### 그림으로 배우는 쿠버네티스 랩과 관리형 쿠버네티스(GKE)와 비교
### 앤서블(Ansible)을 통한 쿠버네티스 노드의 버전 업그레이드
### 쿠버네티스 실습 랩(v1.20+)을 Vagrant가 아닌 이미지로 바로 구성 설치하는 법
### 가상머신(x86-64)으로 구성한 쿠버네티스 랩 환경의 3가지 장점
### 슈퍼푸티(SuperPutty) 터미널을 생산성 있게 꾸미기
### 잘가! 슈퍼푸티(SuperPutty) 환영해! 타비(Tabby)
### 향후 강의 계획 및 CKA 준비 랩 환경 제공

## 보관됨 (Archived) - v1.20
### 쿠버네티스 워커 노드의 구성 요소에 문제가 생겼다면
### 쿠버네티스 마스터 노드의 구성 요소에 문제가 생겼다면
### 쿠버네티스 버전 업그레이드

## 보관됨 (Archived) - v1.25
### 코드로 쉽게 구성하는 쿠버네티스 랩 환경
### 쿠버네티스 랩을 쉽게 접근하기 위한 터미널 구성
### kubectl 쉽게 쓰는 법
### 쿠버네티스 버전 업그레이드 - v1.25

## 보관됨 (Archived) - v1.30
### 베이그런트(Vagrant)+VMware Fusion으로 쿠버네티스 환경 구축하기 (arm64 사용자) - v1.30
### UTM(QEMU)로 쿠버네티스 환경 구축하기 (상업적, arm64) - v1.30