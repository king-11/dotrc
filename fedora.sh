functio initial_setup(){
  sudo dnf check-update
  sudo dnf makecache --refresh
  sudo dnf upgrade
  sudo dnf install dnf-plugins-core -y  
  sudo dnf install flatpak snapd
  sudo dnf install zsh
  chsh -s $(which zsh)
}

funtion git_install(){
  sudo dnf install 'dnf-command(config-manager)'
  sudo dnf config-manager --add-repo https://cli.github.com/packages/rpm/gh-cli.repo
  sudo dnf install gh
  gpg --import ~/.ssh/gpg-github.asc
  gpg --import ~/.ssh/gpg-github.pub.asc
  #gpg --edit-key <LONGID> ; gpg --list-secret-keys --keyid-format LONG ;copy sec second line
}

function necessary_functions(){
  sudo dnf -y install gdb gcc-c++ clang make automake gcc kernel-devel
}

function applications(){
  sudo dnf install vlc code
  sudo snap install insomnia
  sudo rpm -v --import https://download.sublimetext.com/sublimehq-rpm-pub.gpg
  sudo dnf config-manager --add-repo https://download.sublimetext.com/rpm/stable/x86_64/sublime-text.repo
  sudo dnf install sublime-text
  sudo dnf install -y neovim python3-neovim
}

function python(){
  sudo dnf install --assumeyes python3-pip
  curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | zsh
}

function nodejs(){
  curl -fsSL https://fnm.vercel.app/install | zsh
  curl -fsSL https://get.pnpm.io/install.sh | sh -
}

function social_media(){
  sudo dnf copr enable rommon/telegram
  sudo dnf install telegram-desktop
  sudo dnf copr enable tcg/discord
  sudo dnf install Discord-installer
  sudo snap install soundaux --beta --classic
}

function utilites(){
  sudo dnf install bat
  sudo dnf copr enable lunaryorn/mdcat 
  sudo dnf install mdcat stacer procs ripgrep exa
  sudo dnf copr enable atim/lazygit -y
  sudo dnf install lazygit
}

function languages() {
  sudo dnf install golang
  mkdir -p $HOME/.go
  echo 'export GOPATH=$HOME/.go' >> $HOME/.zshrc
  sudo dnf install rust cargo
  sudo dnf -y install julia
}
