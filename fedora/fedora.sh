#!/bin/sh

functio initial_setup(){
  sudo dnf check-update
  sudo dnf makecache --refresh
  sudo dnf upgrade
  echo 'fastestmirror=1' | sudo tee -a /etc/dnf/dnf.conf\
  echo 'max_parallel_downloads=10' | sudo tee -a /etc/dnf/dnf.conf\
  echo 'deltarpm=true' | sudo tee -a /etc/dnf/dnf.conf
  ibus-setup #remove Control Period from emoji to make quick fix shortcut work
  sudo dnf install dnf-plugins-core

  #TLP slows down harddisk dont use when performance needed
  #sudo dnf install tlp tlp-rdw
  #sudo systemctl mask systemd-rfkill.service systemd-rfkill.socket
  #sudo systemctl enable --now tlp.service
  #sudo dnf remove power-profiles-daemon
}

function rpm_fusion(){
  sudo dnf install   https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
  sudo dnf install   https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
}

function git_install(){
  sudo dnf config-manager --add-repo https://cli.github.com/packages/rpm/gh-cli.repo
  sudo dnf install gh
}

function terminal(){
  sudo dnf install zsh chsh
  sudo dnf install hyper powerline-fonts
}

function dev_packages(){
  sudo dnf -y install gdb gcc-c++ clang make automake gcc kernel-devel ffmpeg dnf-plugins-core
  sudo dnf group install "C Development Tools and Libraries"
}

function applications(){
  sudo dnf install vlc
  # sublime-text
  sudo rpm -v --import https://download.sublimetext.com/sublimehq-rpm-pub.gpg
  sudo dnf config-manager --add-repo https://download.sublimetext.com/rpm/stable/x86_64/sublime-text.repo
  sudo dnf install sublime-text
  # syncthing
  sudo dnf install syncthing
  # cloudflare-warp 
  curl -fsSl https://pkg.cloudflareclient.com/cloudflare-warp-ascii.repo | sudo tee /etc/yum.repos.d/cloudflare-warp.repos
  sudo dnf install cloudflare-warp
  # vscode
  sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
  sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
  sudo dnf install code
  # brave browser
  sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/x86_64/
  sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
  sudo dnf install brave-browser

}

function python(){
  sudo dnf install --assumeyes python3-pip
}

function utilites(){
  sudo dnf install flatpak snapd
  sudo dnf install stacer
  sudo dnf install neovim python3-neovim 
}

function languages() {
  sudo dnf install golang
  mkdir -p $HOME/.go
  echo 'export GOPATH=$HOME/.go' >> $HOME/.zshrc
}

function firmware() {
  sudo fwupdmgr refresh --force
  sudo fwupdmgr get-updates
  sudo fwupdmgr update
}

function docker() {
  sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
  sudo dnf install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
}
