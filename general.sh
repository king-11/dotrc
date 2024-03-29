#!/bin/sh

function create_gpg() {
  gpg --full-generate-key #4096 size
}

function list_gpg() {
  gpg --list-secret-keys --keyid-format=long
}

function export_gpg_key() {
  gpg --export-secret-keys <LONGID> > private.key
}

function edit_gpg() {
  gpg --edit-key <LONGID>
}

function gpg_import() {
  gpg --import public.key
  gpg --import private.key
}

function generate_ssh() {
  ssh-keygen -t ed25519 -C "lakshay.singh1108@gmail.com"
}

function add_ssh_key() {
  eval "$(ssh-agent -s)" &>/dev/null
  ssh-add ~/.ssh/github_ed &>/dev/null
}

function time_set() {
  timedatectl set-local-rtc 1
}

function config_terminal() {
  chsh -s $(which zsh)
  bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"
}

function rust_install() {
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh  
}

function fnm_install(){
  curl -fsSL https://fnm.vercel.app/install | zsh
}

function nodejs_install() {
  fnm install v18
  fnm default v18
}

function pnpm_install(){
  curl -fsSL https://get.pnpm.io/install.sh | sh -
  corepack enable
}

function python_install() {
  curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | zsh
  pyenv install 3.11
  pyenv global 3.11
}

function poetry_install() {
  curl -sSL https://install.python-poetry.org | python3 -
}

function poetry_update(){
  poetry self update
}

function zinit_update(){
  zinit self update
  zinit update --all
}

function zinit_completions(){
  zinit cclear
  zinit creinstall zsh-users/zsh-completions
}

function brew_install() {
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}

function brew_install_packages() {
  brew install bottom bat ripgrep eza procs dust duf
  brew install difftastic
  brew install zellij
  brew install nushell
  brew install teaxyz/pkgs/pkgx
  brew install fzf
}

function install_tlp_ui() {
  flatpak install flathub tlpui discord
}

function nvchad_config() {
  git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1 && nvim
}

function kitty_install() {
  curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
  ln -sf ~/.local/kitty.app/bin/kitty ~/.local/kitty.app/bin/kitten ~/.local/bin/\
  cp ~/.local/kitty.app/share/applications/kitty.desktop ~/.local/share/applications/\
  cp ~/.local/kitty.app/share/applications/kitty-open.desktop ~/.local/share/applications/\
  sed -i "s|Icon=kitty|Icon=/home/$USER/.local/kitty.app/share/icons/hicolor/256x256/apps/kitty.png|g" ~/.local/share/applications/kitty*.desktop\
  sed -i "s|Exec=kitty|Exec=/home/$USER/.local/kitty.app/bin/kitty|g" ~/.local/share/applications/kitty*.desktop
  cp ~/projects/dotrc/config/kitty ~/.config/kitty
}
