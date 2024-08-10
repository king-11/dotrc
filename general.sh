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
  fnm install v20
  fnm default v20
}

function pnpm_install(){
  curl -fsSL https://get.pnpm.io/install.sh | sh -
  corepack enable
}

function python_install() {
  curl -L https://pyenv.run | zsh
  # install build deps https://github.com/pyenv/pyenv/wiki#suggested-build-environment
  pyenv install 3.12
  pyenv global 3.12
}

function poetry_install() {
  pipx install poetry
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
  brew install bat \
    bottom \
    ripgrep \
    eza \
    procs \
    dust \
    duf \
    difftastic \
    zellij \
    zoxide \
    atuin \
    fzf \
    pkgxdev/made/pkgx \
    pipx
}

function install_tlp_ui() {
  flatpak install flathub tlpui com.discordapp.Discord im.riot.Riot md.obsidian.Obsidian
}

function nvchad_config() {
  git clone https://github.com/NvChad/starter ~/.config/nvim && nvim
  rm -rf ~/.config/nvim/.git
}

function kitty_install() {
  # Create symbolic links to add kitty and kitten to PATH (assuming ~/.local/bin is install_tlp_ui
  # your system-wide PATH)
  ln -sf ~/.local/kitty.app/bin/kitty ~/.local/kitty.app/bin/kitten ~/.local/bin/
  # Place the kitty.desktop file somewhere it can be found by the OS
  cp ~/.local/kitty.app/share/applications/kitty.desktop ~/.local/share/applications/
  # Update the paths to the kitty and its icon in the kitty desktop file(s)
  sed -i "s|Icon=kitty|Icon=$(readlink -f ~)/.local/kitty.app/share/icons/hicolor/256x256/apps/kitty.png|g" ~/.local/share/applications/kitty*.desktop
  sed -i "s|Exec=kitty|Exec=$(readlink -f ~)/.local/kitty.app/bin/kitty|g" ~/.local/share/applications/kitty*.desktop
  # Make xdg-terminal-exec (and hence desktop environments that support it use kitty)
  echo 'kitty.desktop' > ~/.config/xdg-terminals.list
  cp ~/projects/dotrc/config/kitty ~/.config/kitty
}

function zed_install() {
  curl -f https://zed.dev/install.sh | sh
}

function udev_rules() {
  sudo curl https://raw.githubusercontent.com/LedgerHQ/udev-rules/master/20-hw1.rules -o /etc/udev/rules.d/20-hw1.rules
  sudo curl https://raw.githubusercontent.com/trezor/trezor-common/master/udev/51-trezor.rules -o /etc/udev/rules.d/51-trezor.rules
  sudo curl https://raw.githubusercontent.com/Yubico/libfido2/main/udev/70-u2f.rules -o /etc/udev/rules.d/70-u2f.rules
}

function docker_access() {
  sudo groupadd docker;
  sudo usermod -aG docker $USER;
  newgrp docker
  sudo systemctl enable --now docker.service containerd.service
}
