{ config, osConfig, lib, pkgs, inputs, ... }: {

  home = {
    username = osConfig.machineSpecific.userName;
    homeDirectory = "/home/${osConfig.machineSpecific.userName}";
  };

  programs.zsh.enable = true;
  programs.git.enable = true;
  programs.tmux.enable = true;

  programs.neovim = {
    enable = true;
    withPython3 = false;
    withRuby = false;
    defaultEditor = true;
  };

  home.stateVersion = "25.05";
}
