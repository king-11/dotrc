#!/bin/bash

function initial_setup(){
  sudo systemctl enable fstrim.timer
  sudo pacman-mirrors --fasttrack
  sudo pacman-db-upgrade
  sudo pacman -Rns firefox thunderbird
  sudo pacman -Syu
  sudo pacman -S git yay gufw gnome-keyring seahorse gnupg snapd
  #sudo echo "kdesu python3 /usr/lib/python3.8/site-packages/gufw/gufw.py" >> /bin/gufw
}

function git_install() {
  sudo pacman -S github-cli
  cp ~/scripts/git/.gitconfig ~/
  gpg --import ~/.ssh/gpg-github.asc
  gpg --import ~/.ssh/gpg-github.pub.asc
  #gpg --edit-key <LONGID> ; gpg --list-secret-keys --keyid-format LONG ;copy sec second line
}

function necessary_functions(){
  sudo pacman -S base-devel binutils make curl gcc clang gdb keychain gnoome-keyring
  sudo pacman -S tlp powertop
  sudo systemctl enable tlp.service
  # sudo tee /etc/systemd/system/powertop.service\
  # [Unit]\
  # Description=PowerTOP auto tune\
  # \
  # [Service]\
  # Type=idle\
  # Environment="TERM=dumb"\
  # ExecStart=/usr/sbin/powertop --auto-tune\
  # \
  # [Install]\
  # WantedBy=multi-user.target\
  systemctl daemon-reload
  systemctl enable --now powertop.service
}

function codecs(){
  sudo pacman -S exfat-utils fuse-exfat a52dec faac faad2 flac jasper lame libdca libdv gst-libav libmad libmpeg2 libtheora libvorbis libxv wavpack x264 xvidcore gstreamer0.10-plugins flashplugin libdvdcss libdvdread libdvdnav gecko-mediaplayer dvd+rw-tools dvdauthor dvgrab
  sudo pacman -Sy libxau libxi libxss libxtst libxcursor libxcomposite libxdamage libxfixes libxrandr libxrender mesa-libgl  alsa-lib libglvnd
  sudo pacman -S vlc
}

function python_setup(){
  sudo pacman -S python-pip pyenv
}

function node_setup(){
  curl -fsSL https://fnm.vercel.app/install | zsh
  curl -fsSL https://get.pnpm.io/install.sh | sh -
  sudo pamac build yarn
}

function ruby_setup(){
  yay -S rbenv ruby-build
}

function languages() {
	pamac build go rust julia
}

function shell(){
  yay -S zsh zsh-completions
  zsh --version
  chsh -s $(which zsh)
  yay -S starship
}

function browsers(){
  sudo pacman -S brave firefox-developer-edition
}

function ide_setup(){
  yay -S neovim visual-studio-code-bin insomnia-bin sublime-text sublime-merge jetbrains-toolbox
}

function utility_programs(){
  yay -S etcher fzf xclip bat mdcat stacer-bin procs ripgrep unrar tree exa ffmpeg obs-studio hplip
  sudo snap install heroku --classic
}

function notes() {
  yay -S notion-app joplin
}

function display_kde() {
  yay -S ulauncher awesome-terminal-fonts kvantnum-qt5 latte-dock ttf-ms-fonts
}

function display() {
  yay -S ulauncher awesome-terminal-fonts ttf-ms-fonts
}

function social_platforms(){
  yay -S telegram-desktop discord gitter-bin slack-desktop 
  yay -S soundaux weffe-git
}

function docker_setup(){
  sudo pacman -S docker docker-compose
  sudo systemctl start docker.service docker.socket
  sudo systemctl enable docker.service docker.socket
  sudo docker info
  sudo groupadd docker
  sudo usermod -aG docker $USER
  docker volume create portainer_data
  docker run -d -p 8000:8000 -p 9443:9443 --name portainer -v /var/run/docker.sock:/var/run/docker.sock
  docker run -d -p 9001:9001 --name portainer_agent --restart=always -v /var/run docker.sock:/var/run/docker.sock -v /var/lib/docker/volumes:/var/lib/docker/volumes portainer/agent:latest
  
}

function mongo_setup(){
  yay -S mongodb-tools-bin mongodb-bin mongodb-compass
  # sudo systemctl enable --now mongodb.service
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

function vmware(){
	yay -S fuse-2 gtkmn linux-headers ncurses libcanberra pcsclite
	sudo ~/Downloads/App\ Images/VMware-Player-*.x86_64.bundle
	sudo modprobe vmnet && sudo vmware-networks --start
	sudo modprobe -a vmw_vmci vmmon
}

function postgres() {
  sudo pamac install postgresql
  sudo chown postgres:postgres -R /var/lib/postgres
  sudo usermod -aG postgres lord
  #sudo -iu postgres psql
}
