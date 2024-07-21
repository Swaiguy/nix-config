{
  lib,
  outputs,
}: let
  specialExpected = {
    "ai-hyprland" = "pc";
    "ai-i3" = "pc";
    "shoukei-hyprland" = "shoukei";
    "shoukei-i3" = "shoukei";
  };
  specialHostNames = builtins.attrNames specialExpected;

  otherHosts = builtins.removeAttrs outputs.nixosConfigurations specialHostNames;
  otherHostsNames = builtins.attrNames otherHosts;
  # other hosts's hostName is the same as the nixosConfigurations name
  otherExpected = lib.genAttrs otherHostsNames (name: name);
in (specialExpected // otherExpected)
