export ZSH="/opt/ohmyzsh"
ZSH_THEME=agnoster
plugins=(kubectl docker docker-compose)
source "$ZSH/oh-my-zsh.sh"
export KUBECONFIG="/etc/rancher/k3s/k3s.yaml"
alias k="kubectl"