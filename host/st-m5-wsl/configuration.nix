{ config, lib, pkgs, inputs, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking.hostName = config.machineSpecific.hostName;

  users.users = {
    ${config.machineSpecific.userName} = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];
    };
  };

  wsl.enable = config.machineSpecific.isWSL;
  wsl.defaultUser = config.machineSpecific.userName;

  environment.systemPackages = with pkgs; [
    pkgs.zsh
    pkgs.tmux
    pkgs.git
    pkgs.neovim
  ];

  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  programs.neovim.enable = true;
  programs.neovim.defaultEditor = true;

  system.stateVersion = "25.05"; # Did you read the comment?
}
