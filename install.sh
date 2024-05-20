#!/bin/sh

dir=$(CDPATH='' cd -- "$(dirname -- "$0")" && pwd)

id_like=$(grep -e "^ID_LIKE=" /etc/os-release | sed 's/ID_LIKE="\(.*\)"/\1/g')
id=$(grep -e "^ID=" /etc/os-release | sed 's/ID="\(.*\)"/\1/g')

e="$id"
while true; do
	case "$e" in
	"arch")
		exec "$dir/scripts/install_arch.sh"
		exit 0
		;;
	*)
		if [ "$e" = "$id" ]; then
			e="$id_like"
		else
			echo "Not registered" >&2
			exit 1
		fi
		;;
	esac
done
