# Kubernetes 명령어 가이드

> memo.md 파일을 기반으로 정리한 kubectl 명령어 사용법 가이드

## 1. 환경 설정

### 1.1 ARM 환경 설치
```bash
# VirtualBox 설치
brew install --cask ./virtualbox-v7.1.10/virtualbox.rb

# Vagrant 설치 및 실행
brew install --cask ./vagrant-v2.4.7/vagrant.rb
vagrant up

# Tabby 터미널 설치 및 설정
brew install --cask ./tabby-v1.0.207/tabby.rb
cp ./tabby-v1.0.207/config.yaml ~/Library/Application\ Support/tabby/
```

### 1.2 클러스터 접속
- **초기 비밀번호**: `vagrant`
- **기본 확인 명령어**:
  ```bash
  k get po -A    # 모든 Pod 조회
  k get svc -A   # 모든 Service 조회
  ```

## 2. kubectl get 명령어

### 2.1 기본 사용법
```bash
# 기본 조회
kubectl get <resource>

# 상세 정보 조회
kubectl get <resource> -o wide

# 모든 네임스페이스 조회
kubectl get <resource> -A
```

### 2.2 주요 리소스 조회
```bash
# Pod 조회
kubectl get pods
kubectl get pods -o wide
kubectl get po -A

# Service 조회
kubectl get services
kubectl get svc -A

# Node 조회
kubectl get nodes -o wide
```

### 2.3 실습 예시
```bash
# Pod 상태 확인
kubectl get pods
kubectl get pods -o wide

# Service 확인
kubectl get services

# 노드 정보 확인
kubectl get nodes -o wide
```

## 3. kubectl run 명령어

### 3.1 기본 사용법
```bash
# Pod 직접 실행
kubectl run <name> --image <image>
```

### 3.2 실습 예시
```bash
# nginx Pod 실행
kubectl run nginx --image nginx
```

## 4. kubectl create 명령어

### 4.1 기본 사용법
```bash
# Deployment 생성
kubectl create deployment <name> --image=<image>
```

### 4.2 실습 예시
```bash
# nginx Deployment 생성
kubectl create deployment deploy-nginx --image=nginx

# 테스트용 Deployment 생성
kubectl create deployment chk-hn --image=sysnet4admin/chk-hn
```

## 5. kubectl expose 명령어

### 5.1 기본 사용법
```bash
# Pod를 Service로 노출
kubectl expose pod <name> --type=<type> --port=<port>

# Deployment를 Service로 노출
kubectl expose deployment <name> --type=<type> --port=<port>
```

### 5.2 Service Type 옵션
```bash
# NodePort로 노출
kubectl expose <resource> <name> --type=NodePort --port=80

# LoadBalancer로 노출
kubectl expose <resource> <name> --type=LoadBalancer --port=80
```

### 5.3 실습 예시
```bash
# Pod를 NodePort로 노출
kubectl expose pod nginx --type=NodePort --port=80

# Deployment를 NodePort로 노출
kubectl expose deployment deploy-nginx --type=NodePort --port=80

# Deployment를 LoadBalancer로 노출
kubectl expose deployment chk-hn --type=LoadBalancer --port=80
```

## 6. kubectl scale 명령어

### 6.1 기본 사용법
```bash
# Deployment 스케일링
kubectl scale deployment <name> --replicas=<number>
```

### 6.2 실습 예시
```bash
# Pod 수를 3개로 확장
kubectl scale deployment deploy-nginx --replicas=3
kubectl scale deployment chk-hn --replicas=3
```

## 7. kubectl apply 명령어

### 7.1 기본 사용법
```bash
# YAML 파일로 리소스 생성/수정
kubectl apply -f <yaml-file>
```

### 7.2 실습 예시
```bash
# MetalLB 설치
kubectl apply -f ~/_Lecture_k8s_starter.kit/ch3/3.4/metallb.yaml
```

## 8. kubectl delete 명령어

### 8.1 기본 사용법
```bash
# 리소스 삭제
kubectl delete <resource> <name>

# YAML 파일로 삭제
kubectl delete -f <yaml-file>
```

### 8.2 실습 예시
```bash
# Service 삭제
kubectl delete service chk-hn
kubectl delete service deploy-nginx
kubectl delete service nginx

# Deployment 삭제
kubectl delete deployment chk-hn
kubectl delete deployment deploy-nginx

# Pod 삭제
kubectl delete pod nginx

# MetalLB 삭제
kubectl delete -f ~/_Lecture_k8s_starter.kit/ch3/3.4/metallb.yaml
```

## 9. 유틸리티 명령어

### 9.1 파일 찾기
```bash
# 특정 파일 찾기
find . -type f -name "metallb.yaml"
```

### 9.2 접속 테스트
```bash
# 클러스터 내부 IP로 접속
curl 172.16.221.129

# 외부 NodePort로 접속
curl 192.168.1.101:32423
curl 192.168.1.102:32423
curl 192.168.1.103:32423
```

## 10. 명령어 옵션 정리

### 10.1 자주 사용하는 옵션
```bash
-o wide          # 상세 정보 출력
-A               # 모든 네임스페이스
--type=NodePort  # NodePort 타입
--type=LoadBalancer  # LoadBalancer 타입
--replicas=N     # 복제본 수 설정
--port=N         # 포트 번호 지정
```

### 10.2 리소스 타입
```bash
pods, po         # Pod
services, svc    # Service
deployments      # Deployment
nodes            # Node
```

## 11. 네트워크 구성

### 11.1 IP 주소 체계
- **클러스터 내부 IP**: 172.16.x.x (Pod 간 통신)
- **노드 IP**: 192.168.1.x (외부 접속)
- **LoadBalancer IP**: 192.168.1.11 (MetalLB 할당)

### 11.2 포트 매핑
- **NodePort**: 30000-32767 범위
- **Service Port**: 80 (내부)
- **NodePort**: 32423, 32304 (외부)

## 12. 실습 워크플로우

### 12.1 기본 Pod 배포
```bash
kubectl run nginx --image nginx
kubectl get pods -o wide
kubectl expose pod nginx --type=NodePort --port=80
kubectl get services
```

### 12.2 Deployment 배포
```bash
kubectl create deployment deploy-nginx --image=nginx
kubectl scale deployment deploy-nginx --replicas=3
kubectl expose deployment deploy-nginx --type=NodePort --port=80
```

### 12.3 LoadBalancer 배포
```bash
kubectl apply -f metallb.yaml
kubectl create deployment chk-hn --image=sysnet4admin/chk-hn
kubectl scale deployment chk-hn --replicas=3
kubectl expose deployment chk-hn --type=LoadBalancer --port=80
```

### 12.4 리소스 정리
```bash
kubectl delete service <service-name>
kubectl delete deployment <deployment-name>
kubectl delete pod <pod-name>
kubectl delete -f metallb.yaml
```

---

**학습 진행 상황**: 기본 Pod 배포부터 LoadBalancer를 통한 고가용성 서비스 노출까지 전체 워크플로우 실습 완료

> 이 문서는 memo.md 파일의 실습 내용을 기반으로 작성되었으며, 앞으로 memo.md 업데이트에 따라 지속적으로 갱신됩니다.