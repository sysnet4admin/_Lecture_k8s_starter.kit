# install bash-completion for kubectl 
yum install bash-completion -y 

# kubectl completion on bash-completion dir
kubectl completion bash >/etc/bash_completion.d/kubectl

# alias kubectl to k 
echo 'alias k=kubectl' >> ~/.bashrc
echo 'complete -F __start_kubectl k' >> ~/.bashrc

###################################

bash <(curl -s  https://raw.githubusercontent.com/sysnet4admin/IaC/master/tools/k8s_rc.sh)

keq