function create_gpg(){
  gpg --full-generate-key #4096 size
}

function list_gpg(){
  gpg --list-secret-keys --keyid-format=long
}

function export_gpg_key(){
  gpg --export-secret-keys <LONGID> > private.key
}

function edit_gpg(){
  gpg --edit-key <LONGID>
}

function gpg_import(){
  gpg --import ~/.ssh/gpg-github.asc
}

function generate_ssh(){
  ssh-keygen -t ed25519 -C "lakshay.singh1108@gmail.com"
}

function add_ssh_key(){
  eval "$(ssh-agent -s)"
  ssh-add ~/.ssh/github_rsa
}

function time_set(){
  timedatectl set-local-rtc 1
}
