function fedora_container{
  docker run --name fedora38 fedora:38
}

function export_wsl{
  docker export -o fedora-38-rootfs.tar fedora38
}

function import_wsl{
  mkdir $HOME\wsl\fedora
  wsl --import fedora $HOME\wsl\fedora $HOME\Downloads\fedora-38-rootfs.tar
}

function export_fedora{
  wsl --export fedora $HOME\Downloads\fedora-wsl.tar
}

function run_fedora{
  wsl -d fedora
}

function enter_fedora{
  wsl -s fedora
}

function terminate_fedora() {
  wsl -t fedora
}
