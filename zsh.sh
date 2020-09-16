#!/bin/bash

function zsh_install() {
    sudo apt install zsh
    zsh --version
    chsh -s $(which zsh)
    curl -fsSL https://starship.rs/install.sh | zsh
}
