export ZSH="/opt/ohmyzsh"
export KUBECONFIG=/etc/rancher/k3s/k3s.yaml
alias k=kubectl
ZSH_THEME=agnoster
plugins=(kubectl)
source "$ZSH/oh-my-zsh.sh"
