{ config, osConfig, lib, pkgs, inputs, ... }: {

  home = {
    username = osConfig.machineSpecific.userName;
    homeDirectory = "/home/${osConfig.machineSpecific.userName}";
  };

  # home.packages = with pkgs; [];

  programs.home-manager.enable = true;
  home.stateVersion = "25.05";
}
