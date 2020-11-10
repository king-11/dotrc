#!/bin/zsh

function initial_setup(){
  sudo systemctl enable fstrim.timer
  sudo pacman-mirrors --fasttrack
  sudo pacman-db-upgrade && syn
  sudo pacman -Syu
  sudo pacman -S git yay gufw
  sudo echo "kdesu python3 /usr/lib/python3.8/site-packages/gufw/gufw.py" >> /bin/gufw
}

function git_install() {
  git config --global user.name "Lakshya Singh"
  git config --global user.email "lakshay.singh1108@gmail.com"
  sudo pacman -S github-cli
  cp ~/scripts/git/.gitconfig ~/
}

function brave_install(){
  sudo pacman -S brave
}

function python_setup(){
  sudo pacman -S python-pip postgresql python-opengl pyenv
  curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python
  poetry completions zsh > ~/.zfunc/_poetry
}

function zsh_install(){
  yay -S zsh zsh-completions
  zsh --version
  chsh -s $(which zsh)
}

function ide_setup(){
  sudo pacman -S neovim alacritty
  yay -S visual-studio-code-bin insomnia-bin
}

function utility_programs(){
  sudo pacman -S etcher neofetch teamviewer fzf htop xclip curl bat mdcat latte-dock
}

function codecs(){
  sudo pacman -S exfat-utils fuse-exfat a52dec faac faad2 flac jasper lame libdca libdv gst-libav libmad libmpeg2 libtheora libvorbis libxv wavpack x264 xvidcore gstreamer0.10-plugins flashplugin libdvdcss libdvdread libdvdnav gecko-mediaplayer dvd+rw-tools dvdauthor dvgrab
  sudo pacman -S vlc
}

function necessary_functions(){
  sudo pacman -S base-devel binutils make curl gcc clang gdb keychain gnoome-keyring
  sudo pacman -S tlp powertop
  sudo systemctl enable tlp.service
  cat << EOF | sudo tee /etc/systemd/system/powertop.service\
  [Unit]\
  Description=PowerTOP auto tune\
  \
  [Service]\
  Type=idle\
  Environment="TERM=dumb"\
  ExecStart=/usr/sbin/powertop --auto-tune\
  \
  [Install]\
  WantedBy=multi-user.target\
EOF
  systemctl daemon-reload
  systemctl enable --now powertop.service
}

function social_platforms(){
  sudo pacman -S skypeforlinux-stable-bin teamviewer
  yay -S discord wps-office teams gitter-bin stacer-bin slack-desktop
}

function node_setup(){
  curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | zsh
  export NVM_DIR="$HOME/.nvm"
  nvm install --lts
  sudo pacman -S yarn
  npm install -g gitignore express-generator typescript firebase-tools
}

function flutter(){
  sudo pacman -S dart
  mkdir -p .development
  cd ~/.development
  tar xf ~/Downloads/flutter_linux_1.22.0-stable.tar.xz
  git clone https://github.com/flutter/flutter.git
  export PATH="$PATH:`pwd`/flutter/bin"
  flutter precache
}

function docker_setup(){
  sudo pacman -S docker docker-compose
  # sudo systemctl start docker.service docker.socket\
  # sudo systemctl enable docker.service docker.socket
  sudo docker info
  sudo groupadd docker
  echo $USER
  sudo usermod -aG docker targetx
}

function mongo_setup(){
  yay -S mongodb-tools-bin mongodb-bin mongodb-compass
  # sudo systemctl enable --now mongodb.service
}
