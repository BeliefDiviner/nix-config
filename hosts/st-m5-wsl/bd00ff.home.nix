{ config, osConfig, lib, pkgs, inputs, ... }: {

  home = {
    username = osConfig.machineSpecific.userName;
    homeDirectory = "/home/${osConfig.machineSpecific.userName}";
  };

  programs.zsh.enable = true;

  home.file.".ssh" = {
    source = ../../ssh;
    recursive = true;
  };

  programs.git.enable = true;
  home.file.".config/git" = { source = ../../git; };

  programs.tmux.enable = true;

  programs.neovim = {
    enable = true;
    withPython3 = false;
    withRuby = false;
    defaultEditor = true;
  };

  home.stateVersion = "25.05";
}
