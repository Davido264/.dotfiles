#!/bin/sh

dir=$(CDPATH='' cd -- "$(dirname -- "$0")" && pwd)

# Given that I want this file to execute not just the first time, I want to check for a ._not_first_time file
if [ ! -f ._not_first_time ]; then
	pacman -Qn ansible || sudo pacman -Syu ansible --noconfirm --needed
	pacman -Qn bitwarden-cli || sudo pacman -Syu bitwarden-cli --noconfirm --needed
	pacman -Qn python-psutil || sudo pacman -Syu python-psutil --noconfirm --needed
	pacman -Qn jq || sudo pacman -Syu jq --noconfirm --needed
	ansible-galaxy install -r requirements.yml
fi

if [ ! -f ~/.ssh/id_rsa ]; then
	BW_SESSION="$(bw login --raw || bw unlock --raw)"
	export BW_SESSION
	bw sync
	mkdir -p ~/.ssh/
	bw list items --search ssh_key:github | jq -r '.[0].notes' >~/.ssh/id_rsa
	chmod 0600 ~/.ssh/id_rsa
fi

# ansible thing
ansible-playbook -K local.yml

if [ ! -f ._not_first_time ]; then
	stow -t "$HOME" --adopt configs
	git restore configs
else
	stow -t "$HOME" configs
fi

if ! [ -f ._not_first_time ]; then
	echo "Updating Home directory names"
	rm -rf ~/Descargas ~/Documentos ~/Escritorio/ ~/Público/ ~/Plantillas/ ~/Música/ ~/Imágenes/ ~/Vídeos/
	mkdir -p "$HOME/Desktop" \
		"$HOME/Downloads" \
		"$HOME/Templates" \
		"$HOME/Public" \
		"$HOME/Documents" \
		"$HOME/Music" \
		"$HOME/Pictures" \
		"$HOME/Videos"
	LC_ALL=C.UTF-8 xdg-user-dirs-update --force
fi

if [ ! -d ~/Pictures/wallpapers ]; then
	git clone git@github.com:Davido264/random-wallpapers.git ~/Pictures/wallpapers
fi

if [ -d ~/go ]; then
	mv ~/go ~/.local/share/
fi

if [ ! -f ._not_first_time ]; then
	git remote set-url origin git@github.com:Davido264/.dotfiles.git
fi

if [ ! -f ._not_first_time ]; then
	nvim --headless
fi

if [ ! -f ._not_first_time ]; then
	touch ._not_first_time
fi
