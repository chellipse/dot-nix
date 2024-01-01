#!/usr/bin/env nix-shell
#! nix-shell -i bash -p bash kitty

# spawn new term and init shell.nix
kitty --working-directory="$(pwd)" -e bash -c "nix-shell; exec bash" >/dev/null 2>&1 &

