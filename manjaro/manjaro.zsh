git config --global user.name "Lakshya Singh"
git config --global user.email "lakshay.singh1108@gmail.com"
sudo pacman -S github-c

sudo pacman -S brave

sudo pacman -S python-pip
sudo pacman -Sy postgresql
sudo pacman -S python-opengl
pip3 install pipenv ipykernel pylint
zsh -c "$(wget -q -O - https://linux.kite.com/dls/linux/current)"

sudo pacman -S etcher flameshot neofetch skypeforlinux-stable-bin teamviewer fzf htop xclip
sudo pacman -S base-devel

curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | zsh
export NVM_DIR="$HOME/.nvm"
nvm install --lts

sudo pacman -S yarn
yarn add global gitignore express-generator typescript

sudo pacman -S dart

git clone https://aur.archlinux.org/snapd.git
cd snapd
makepkg -si
sudo systemctl enable --now snapd.socket
sudo ln -s /var/lib/snapd/snap /snap

mkdir -p .development
cd ~/.development
tar xf ~/Downloads/flutter_linux_1.22.0-stable.tar.xz
git clone https://github.com/flutter/flutter.git
export PATH="$PATH:`pwd`/flutter/bin"
flutter precache

sudo pacman -S neovim

curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python
poetry completions zsh > ~/.zfunc/_poetry
