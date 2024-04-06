# dotrc

These are my OS and nix tool configuration files. I am primarily using **Fedora** and **Fedora WSL** so that is the most up to date ones. All available distro setups are:
- Fedora (redhat)
- Fedora WSL (redhat + windows)
- Manjaro (btw I use arch)
- popOS (debian)

The command line utilities that require configuration are also provided here:
- [git](./git/.gitconfig)
- [kitty](./kitty/kitty.conf)
- [ssh](./ssh/config)
- [spaceship](./config/spaceship.zsh)

Along with OS specific folder there is a [common script](./general.sh) which is nix agnostic and can be used for interacting with tools like:
- GnuPG (Open Pretty Good Privacy)
- SSH (Secure Shell)
- ZSH (Z Shell): Zinit installation for plugins
- Programming Language Setup: Rust, Go, Python, NodeJS
- NeoVIM: NvChad configuration
- Kitty Terminal
- Brew Installation

## Brew Packages

I make full use of [Homebrew](https://brew.sh/) which provides easy installation and updates for all my command line softwares. Alongwith that some CLIs I don't prefer installing and they are used on the fly with help of [pkgx](https://github.com/pkgxdev/pkgx). Packages that are useful for CLI usage are:
- bottom: A customizable cross-platform graphical process/system monitor for the terminal.
- bat: A cat(1) clone with syntax highlighting and Git integration.
- ripgrep: ripgrep is a line-oriented search tool that recursively searches the current directory for a regex pattern.
- eza: A modern, maintained replacement for ls.
- procs: procs is a replacement for ps written in Rust.
- dust: du + rust = dust. Like du but more intuitive.
- duf: Disk Usage/Free Utility (Linux, BSD, macOS & Windows)
- difftastic: Difftastic is a structural diff tool that compares files based on their syntax.
- zellij: Terminal multiplexer
- nushell: A new type of shell.
- fzf: fzf is a general-purpose command-line fuzzy finder.

Most of these tools are rust rewrites except for duf and fzf.

## Terminal Hacks

### fzf

`fzf` can be come in very handy for searching history (Ctrl + r), files (fzf), play directory (Ctrl + t) and directory switch (Alt + c). Replacing words with "\*\*" triggers fzf in commands like kill, unalias, etc. We must set `export FZF_DEFAULT_COMMAND='rg --hidden --ignore .git -l -g""'` otherwise git files will also come in search.

We can combine `fzf`, `rg` and `nvim` by using something like:
```
rg <CODE_SEARCH> | fzf | cut -d':' -f 1 | xargs -n 1 nvim
```
In this case `rg` will search for string in the whole directory in each file, then pass it to `fzf` for fuzzy searching and on selecting a line we can pass the file name to `nvim` for opening.

We can also combine `fzf` with `pkgx kubectl` by selecting the pod line, then using awk to select just the name and then sending it to logs command for fetching logs using `xargs`.
```
pkgx kubectl get po -n <NAMESPACE> | fzf | awk '{print $1}' | xargs -n 1 pkgx kubectl logs -n <NAMESPACE>
```

### nvim

`nvim` using the `NvChad` gives you super powerful set of plugins out of the box. We first head to change the theme using `SPC t h`, catpuccin is my go to pastel theme these days. To refer the cheatsheet we can use `SPC c h`

For syntax highlighting we use `tree-sitter`, for any new language we just have to do `:TSInstall <LANG>` and full list can be retrieved using `:TSInstallInfo`.

To open file tree `Ctrl + n` is utilized, `a` for creating a new file, `m` key can be used to mark file in tree, `d` for delete, `c` for copying file, `p` for pasting it and `r` for renaming file.

Find files can be done using `SPC f f` throughout the directory. We can search in currently open buffers using `SPC f b`.

To split the screen we use `:sp` and `:vsp` vim commands. Then we can use `Ctrl + h/j/k/l` to move around. We can open new buffers using `SPC b`, close one using `SPC x` and then toggle them using `TAB` or `Shift TAB`.

A terminal can be opened in many configuration as `Alt v` for vertical, `Alt h` for horizontal and `Alt i` for floating terminal window.
