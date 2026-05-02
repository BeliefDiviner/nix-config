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

  wsl = {
    enable = config.machineSpecific.isWSL;
    defaultUser = config.machineSpecific.userName;
    useWindowsDriver = true;
  };
  environment.extraInit = ''
    export NIX_LD_LIBRARY_PATH="/usr/lib/wsl/lib:$NIX_LD_LIBRARY_PATH"
  '';

  environment.systemPackages = with pkgs; [
    pkgs.zsh
    pkgs.tmux
    pkgs.git
    pkgs.nix-ld
    pkgs.neovim
  ];

  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
    ];
  };

  system.stateVersion = "25.05"; # Did you read the comment?
}
