FROM ubuntu:latest
SHELL ["/bin/bash", "-c"]
ENV DEBIAN_FRONTEND=noninteractive

RUN ["sed","-i", "-e", "s/# deb-src/deb-src/g", "/etc/apt/sources.list"]
RUN ["apt", "update"]
RUN ["apt-get", "update"]
RUN ["apt", "install", "-y", "git"]
RUN ["apt", "install", "-y", "curl"]
RUN ["apt-get", "install", "-y", "ninja-build", "gettext", "libtool", "libtool-bin", "autoconf", "automake", "cmake", "g++", "pkg-config", "unzip"]
RUN git clone https://github.com/neovim/neovim ~/neovim
RUN git clone https://github.com/kazukazuinaina/NeovimOnDocker ~/.config/nvim
RUN ["bin/bash", "-c", "curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh"]
RUN ["sh", "./installer.sh", "~/.cache/dein"]
