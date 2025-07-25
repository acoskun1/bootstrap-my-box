#!/usr/bin/env bash
sudo apt update -y
#sudo apt upgrade -y
#for pkg in $(sudo apt list --upgradable 2>/dev/null | tail -n +2 | cut -d/ -f1); do
#  echo "Upgrading $pkg ..."
#  sudo apt install --only-upgrade -y "$pkg"
#done

# install curl
echo "*************************"
echo "Installing curl ..."
sudo apt install -y curl && sudo apt install -y wget

# install netcat
echo "*************************"
echo "Installing netcat ..."
sudo apt install -y netcat-openbsd

# install traceroute
echo "*************************"
echo "Installing traceroute ..."
sudo apt install -y inetutils-traceroute

# install kubectl
echo "*************************"
echo "Installing kubectl ..."
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
echo "alias k='kubectl'" >> ~/.bashrc
echo "alias kp='kubectl get pod'" >> ~/.bashrc
curl https://raw.githubusercontent.com/blendle/kns/master/bin/kns -o /usr/local/bin/kns && chmod +x $_

# install aws-cli
echo "*************************"
echo "Installing aws-cli ..."
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
rm awscliv2.zip

# install gcloud cli
echo "*************************"
echo "Installing gcloud-cli ..."
sudo apt install apt-transport-https ca-certificates gnupg curl
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
sudo apt update -y && sudo apt install -y google-cloud-cli

# install az-cli
echo "*************************"
echo "Installing az-cli ..."
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

# install helm
echo "*************************"
echo "Installing helm ..."
curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg > /dev/null
sudo apt install apt-transport-https --yes
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
sudo apt update
sudo apt install -y helm

# install terraform
echo "*************************"
echo "Installing terraform cli ..."
wget -O - https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(grep -oP '(?<=UBUNTU_CODENAME=).*' /etc/os-release || lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update -y && sudo apt install -y terraform

# install keepassxc
sudo apt install -y keepassxc

# install lazyvim
echo "*************************"
echo "Installing nvim & lazyvim ..."
sudo apt install -y neovim
mv ~/.config/nvim{,.bak}
git clone https://github.com/LazyVim/starter ~/.config/nvim
rm -rf ~/.config/nvim/.git


# install oh-my-posh
echo "*************************"
echo "Installing oh-my-posh ..."
echo 'export PATH=$PATH:/home/sinatra/.local/bin' >> ~/.bashrc
curl -s https://ohmyposh.dev/install.sh | bash -s
oh-my-posh font install LiberationMono
echo "eval \"\$(oh-my-posh init bash --config 'https://github.com/JanDeDobbeleer/oh-my-posh/blob/main/themes/onehalf.minimal.omp.json')\"" >> ~/.bashrc

sudo apt update -y 
for pkg in $(sudo apt list --upgradable 2>/dev/null | tail -n +2 | cut -d/ -f1); do
  echo "Upgrading $pkg ..."
  sudo apt install --only-upgrade -y "$pkg"
done
sudo apt autoremove

echo "Bootstrap complete."
source ~/.bashrc
