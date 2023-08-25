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
  pyenv global 3.8
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
  brew install bottom bat ripgrep exa procs dust duf
  brew install difftastic
  brew install zellij
  brew install nushell
  brew install teaxyz/pkgs/tea-cli
}

function install_tlp_ui() {
  flatpak install flathub tlpui
}
