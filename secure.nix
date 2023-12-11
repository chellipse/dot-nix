{ config, pkgs, ... }:

{
  security.sudo = {
    wheelNeedsPassword = true;
    extraRules = [
      { groups = [ "wheel" ]; commands = [ { command = "/etc/validate/validate-sudo"; options = [ "NOPASSWD" ]; } ]; }
    ];
  };

  environment.variables = {
      LD_PRELOAD = "/usr/local/lib/libwlbouncer-preload.so";
      BOUNCER_CONFIG = "/etc/validate/wlbouncer.yaml";
      # BOUNCER_DEBUG = "value";
  };
}
