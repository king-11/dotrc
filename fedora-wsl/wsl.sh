#!/bin/zsh

function setup_user_and_password() {
  sudo dnf install -y passwd cracklib-dicts
  sudo useradd -G wheel king-11
  sudo passwd king-11
}

function default_user() {
  printf"\n[user]\ndefault = king-11\n"| sudo tee-a/etc/wsl.conf
}

function man_pages() {
  grep-vnodocs /etc/dnf/dnf.conf | sudo tee/etc/dnf/dnf.conf
  sudo dnf install -y man man-pages
  for pkg in$(dnf repoquery --installed--qf"%{name}");do sudo dnf reinstall -qy$pkg;done
}

function packages() {
  sudo dnf install util-linux-user git
  sudo dnf groupinstall "Development Tools" "Development Libraries"
  sudo dnf -y install make automake gcc gcc-c++ kernel-devel
  sudo dnf -y install zlib-devel libffi-devel openssl-devel bzip2-devel readline-devel sqlite-devel xz-devel
}

function packages_clean() {
  sudo dnf clean all
}

function libcuda_fix() {
  echo -e "[automount]\nldconfig = false" | sudo tee -a /etc/wsl.conf
  sudo mkdir /usr/lib/wsl/lib2
  sudo ln -s /usr/lib/wsl/lib/* /usr/lib/wsl/lib2
  echo /usr/lib/wsl/lib2 | sudo tee /etc/ld.so.conf.d/ld.wsl.conf
}
