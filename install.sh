function git_install(){
    sudo apt install git
    git config --global user.name "Lakshya Singh"
    git config --gloabl user.email "lakshay.singh1108@gmail.com"
    sudo apt install ~/Downloads/gh_*_linux_amd64.deb
    cp ~/scripts/git/.gitconfig ~/
}

function brave_install(){
    sudo apt install apt-transport-https curl
    curl -s https://brave-browser-apt-release.s3.brave.com/brave-core.asc | sudo apt-key --keyring /etc/apt/trusted.gpg.d/brave-browser-release.gpg add -
    echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list
    sudo apt update && sudo apt install brave-browser
}

function python_setup(){
    sudo apt-get install python3-pip pyopengl python-dev libpq-dev postgresql
    pip3 install pipenv ipykernel pylint
    zsh -c "$(wget -q -O - https://linux.kite.com/dls/linux/current)"
}

function utilities_install(){
    sudo apt install stacer build-essential git fzf vim ssss snapd
    sudo apt-get install xclip fonts-powerline
    sudo apt install espeak neofetch figlet stacer build-essential nmap htop
}

function debug_tools_install(){
    sudo apt-get insall net-tools g++ clang valgrind ping traceroute keychain
}

function snap_packages_install(){
    sudo snap install --classic code
    sudo snap install --classic vlc
    sudo snap install --classic heroku
    sudo snap install --classic skype
    sudo snap install --classic android-studio
}

function node_setup(){
    curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | zsh
    export NVM_DIR="$HOME/.nvm"
    nvm install --lts
    # yarn install
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
    sudo apt update && sudo apt install --no-install-recommends yarn
    yarn add global gitignore express-generator typescript

}

function flutter_setup(){
    sudo sh -c 'wget -qO- https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -'
    sudo sh -c 'wget -qO- https://storage.googleapis.com/download.dartlang.org/linux/debian/dart_stable.list > /etc/apt/sources.list.d/dart_stable.list'
    sudo apt-get update && sudo apt-get install dart
    sudo snap install --classic flutter
}

function downloads_install() {
    cd Downloads
    sudo apt install ./Insomnia.Core-*.deb ./mongodb-compass_*_amd64.deb ./teams_*_amd64.deb ./teamviewer_*_amd64.deb ./discord-*.deb ./bat_*_amd64.deb
    sudo ./VMware-Player-*.x86_64.bundle
}
