#!/usr/bin/env nix-shell
#! nix-shell -i bash -p bash

# cd into first arg
cd "$1"

# spawn new term and init shell.nix
$TERMINAL --working-directory="$(pwd)" -e bash -c "nix-shell; exec bash" >/dev/null 2>&1 &

# init shell.nix in current term
nix-shell

