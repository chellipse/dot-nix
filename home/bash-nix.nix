{ config }:

{
  home.file.".bash_nix.sh".text = ''
    ${builtins.readFile ./configs/bash_nix.sh}
  '';
}
